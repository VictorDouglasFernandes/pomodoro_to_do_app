import 'dart:async';

import 'package:mobx/mobx.dart';
import 'package:pomodoro_to_do_app/src/features/home/entities/enums/clock_type.dart';
import 'package:pomodoro_to_do_app/src/features/home/entities/enums/time_type.dart';
import 'package:pomodoro_to_do_app/src/features/notification/services/notification_service.dart';

part 'home_controller.g.dart';

class HomeController = HomeControllerBase with _$HomeController;

abstract class HomeControllerBase with Store {
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

  @action
  void restartTimer() {
    _seconds = _total;
  }

  @action
  void startTimer() {
    _seconds -= 1;
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
  void stopTimer() {
    timer?.cancel();
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
