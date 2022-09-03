import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:pomodoro_to_do_app/src/commons/palette.dart';
import 'package:pomodoro_to_do_app/src/commons/text_styles.dart';
import 'package:pomodoro_to_do_app/src/features/clock/controllers/clock_kf_controller.dart';
import 'package:pomodoro_to_do_app/src/features/clock/entities/enums/time_type.dart';

class ClockKF extends StatefulWidget {
  final ClockKFController controller;

  const ClockKF({
    required this.controller,
    Key? key,
  }) : super(key: key);

  @override
  State<ClockKF> createState() => _ClockKFState();
}

class _ClockKFState extends State<ClockKF> {
  ClockKFController get _controller => this.widget.controller;

  late Size _size;

  @override
  void didChangeDependencies() {
    _size = MediaQuery.of(context).size;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(),
        Material(
          color: Colors.transparent,
          child: _buildInkWell(),
        ),
        const Spacer(),
      ],
    );
  }

  Widget _buildInkWell() {
    return InkWell(
      onTap: _onTapClock,
      onLongPress: () {},
      splashColor: Palette.main,
      child: Observer(
        builder: (_) {
          return Stack(
            children: [
              SizedBox(
                height: _getClockHeight(),
                width: _getClockHeight(),
                child: CircularProgressIndicator(
                  value: _controller.percentage(),
                  color: Palette.white,
                ),
              ),
              Positioned.fill(
                child: _buildClock(),
              ),
            ],
          );
        },
      ),
    );
  }

  double _getClockHeight() =>
      (_size.height > _size.width ? _size.width : _size.height) * 0.8;

  Widget _buildClock() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Spacer(),
        Text(
          _controller.getTime(),
          style: montserrat84MediumWhite,
        ),
        Text(
          _controller.getTime(type: TimeType.SECONDS),
          style: montserrat84MediumWhite,
        ),
        const Spacer(),
      ],
    );
  }

  void _onTapClock() {
    if (_controller.timer?.isActive ?? false) {
      _controller.stopTimer();
    } else {
      _controller.startTimer();
    }
  }
}
