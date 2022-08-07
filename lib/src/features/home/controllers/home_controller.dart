import 'dart:async';

import 'package:mobx/mobx.dart';
import 'package:pomodoro_to_do_app/src/features/home/entities/enums/time_type.dart';

part 'home_controller.g.dart';

class HomeController = HomeControllerBase with _$HomeController;

abstract class HomeControllerBase with Store {
  @observable
  int total = 120;

  @observable
  int _seconds = 120;

  @computed
  int get seconds => _seconds;

  @observable
  Timer? timer;

  HomeControllerBase();

  @action
  void restartTimer() {
    _seconds = total;
  }

  @action
  void startTimer() {
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (_seconds > 0) {
          _seconds -= 1;
        } else {
          stopTimer();
          restartTimer();
        }
      },
    );
  }

  @action
  void stopTimer() {
    timer?.cancel();
  }

  double percentage() => _seconds / total;

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
