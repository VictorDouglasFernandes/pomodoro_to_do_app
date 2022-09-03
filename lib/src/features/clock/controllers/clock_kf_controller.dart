import 'dart:async';

import 'package:mobx/mobx.dart';
import 'package:pomodoro_to_do_app/src/features/clock/entities/enums/clock_type.dart';
import 'package:pomodoro_to_do_app/src/features/clock/entities/enums/time_type.dart';
import 'package:pomodoro_to_do_app/src/features/notification/services/notification_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'clock_kf_controller.g.dart';

class ClockKFController extends ClockKFControllerBase with _$ClockKFController {
  static final ClockKFController _singleton = ClockKFController._internal();

  factory ClockKFController() {
    return _singleton;
  }

  ClockKFController._internal();
}

abstract class ClockKFControllerBase with Store {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @observable
  int _total = 1500;

  final int _focusSeconds = 1500;

  final int _restSeconds = 300;

  @observable
  int _seconds = 1500;

  @computed
  int get seconds => _seconds;

  @observable
  Timer? timer;

  @observable
  ClockType _type = ClockType.FOCUS;

  @computed
  ClockType get type => _type;

  @action
  void setType(ClockType type) {
    _type = type;
    if (type == ClockType.FOCUS) {
      _total = _focusSeconds;
    } else if (type == ClockType.REST) {
      _total = _restSeconds;
    }
    stopTimer();
    restartTimer();
  }

  Future<void> getPreviousState() async {
    SharedPreferences prefs = await _prefs;
    String? endString = prefs.getString('endTimer');
    DateTime? endDate;

    if (endString?.isNotEmpty ?? false) {
      endDate = DateTime.tryParse(endString!);
    }
    int? duration = prefs.getInt('duration');

    bool? active = prefs.getBool('active');

    int? remainingSeconds = prefs.getInt('remainingSeconds');

    if (endDate != null && duration != null) {
      if (endDate.difference(DateTime.now()).inSeconds > 0) {
        _setPreviousToCurrentState(
          endDate: endDate,
          duration: duration,
          active: active ?? false,
          remainingSeconds: remainingSeconds,
        );
      }
    }
  }

  @action
  void _setPreviousToCurrentState({
    required DateTime endDate,
    required int duration,
    required bool active,
    int? remainingSeconds,
  }) {
    _total = duration;
    _seconds = endDate.difference(DateTime.now()).inSeconds;
    if (active) {
      startTimer(saveData: false);
    } else {
      _seconds = remainingSeconds ?? _seconds;
    }

    // If the duration is greater then the _type is alteady set
    // to ClockType.FOCUS
    if (duration == 300) {
      _type = ClockType.REST;
    }
  }

  @action
  Future<void> restartTimer() async {
    _seconds = _total;
    SharedPreferences prefs = await _prefs;
    prefs.remove('endTimer');
    prefs.remove('duration');
    prefs.remove('active');
  }

  @action
  void startTimer({bool saveData = true}) {
    if (saveData) {
      _saveTimer();
    }
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (_seconds > 0) {
          _seconds -= 1;
        } else {
          _timerEnd();
        }
      },
    );
  }

  @action
  Future<void> stopTimer() async {
    timer?.cancel();

    SharedPreferences prefs = await _prefs;
    prefs.setBool('active', false);
    prefs.setInt('remainingSeconds', _seconds);
  }

  void _timerEnd() {
    stopTimer();
    restartTimer();

    String? _message;

    if (_type == ClockType.FOCUS) {
      _message = 'Take a rest';
      setType(ClockType.REST);
    } else if (_type == ClockType.REST) {
      _message = 'Let\'s focus again';
      setType(ClockType.FOCUS);
    }

    NotificationService().showNotification(
      0,
      title: 'Time ended',
      message: _message,
    );
  }

  Future<void> _saveTimer() async {
    SharedPreferences prefs = await _prefs;
    DateTime current = DateTime.now();

    prefs.setString(
        'endTimer', current.add(Duration(seconds: _total)).toIso8601String());
    prefs.setInt('duration', _total);
    prefs.setBool('active', timer?.isActive ?? false);
  }

  double percentage() => _seconds / _total;

  String getTime({TimeType type = TimeType.MINUTES}) {
    int _time;

    if (type == TimeType.SECONDS) {
      _time = seconds % 60;
    } else {
      _time = seconds ~/ 60;
    }

    return _formatTime(_time);
  }

  String _formatTime(int value) => '${value > 9 ? '' : '0'}$value';
}
