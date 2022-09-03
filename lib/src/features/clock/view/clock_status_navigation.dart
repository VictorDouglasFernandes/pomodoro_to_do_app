import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:pomodoro_to_do_app/src/commons/palette.dart';
import 'package:pomodoro_to_do_app/src/commons/text_styles.dart';
import 'package:pomodoro_to_do_app/src/features/clock/controllers/clock_kf_controller.dart';
import 'package:pomodoro_to_do_app/src/features/clock/entities/enums/clock_type.dart';

class ClockStatusNavigation extends StatefulWidget {
  final ClockKFController controller;

  const ClockStatusNavigation({
    required this.controller,
    Key? key,
  }) : super(key: key);

  @override
  State<ClockStatusNavigation> createState() => _ClockStatusNavigationState();
}

class _ClockStatusNavigationState extends State<ClockStatusNavigation> {
  ClockKFController get _controller => this.widget.controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: _buildFocusButton(),
        ),
        Visibility(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: _onTapRestart,
              splashColor: Palette.main,
              child: const Icon(
                Icons.restore,
                size: 32.0,
                color: Palette.white,
              ),
            ),
          ),
        ),
        Expanded(
          child: _buildRestButton(),
        ),
      ],
    );
  }

  void _onTapRestart() {
    _controller.stopTimer();
    _controller.restartTimer();
  }

  Widget _buildFocusButton() {
    return Observer(builder: (_) {
      return Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: _onTapFocus,
          child: Container(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'FOCUS',
              style: montserrat18RegularWhite.copyWith(
                color: _getButtonColor(ClockType.FOCUS),
              ),
            ),
          ),
        ),
      );
    });
  }

  Color _getButtonColor(ClockType type) {
    return Palette.white.withOpacity(_controller.type == type ? 1 : 0.5);
  }

  void _onTapFocus() {
    _controller.setType(ClockType.FOCUS);
  }

  Widget _buildRestButton() {
    return Observer(builder: (_) {
      return Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: _onTapRest,
          child: Container(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'REST',
              style: montserrat18RegularWhite.copyWith(
                color: _getButtonColor(ClockType.REST),
              ),
              textAlign: TextAlign.end,
            ),
          ),
        ),
      );
    });
  }

  void _onTapRest() {
    _controller.setType(ClockType.REST);
  }
}
