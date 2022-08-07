import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:pomodoro_to_do_app/src/commons/palette.dart';
import 'package:pomodoro_to_do_app/src/commons/text_styles.dart';
import 'package:pomodoro_to_do_app/src/features/home/controllers/home_controller.dart';
import 'package:pomodoro_to_do_app/src/features/home/entities/enums/time_type.dart';

class HomePageBody extends StatefulWidget {
  const HomePageBody({Key? key}) : super(key: key);

  @override
  State<HomePageBody> createState() => _HomePageBodyState();
}

class _HomePageBodyState extends State<HomePageBody> {
  final HomeController _controller = HomeController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(32.0, 32.0, 32.0, 32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildConfigureIcon(),
          _buildActionClock(),
          _buildRestartButton()
        ],
      ),
    );
  }

  Widget _buildConfigureIcon() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            splashColor: Palette.main,
            onTap: () {
              print('Settings');
            },
            child: const Icon(
              Icons.settings_outlined,
              size: 32.0,
              color: Palette.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionClock() {
    return Row(
      children: [
        const Spacer(),
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: _onTapClock,
            splashColor: Palette.main,
            child: Observer(
              builder: (_) {
                return Stack(
                  children: [
                    SizedBox(
                      height: 250,
                      width: 250,
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
          ),
        ),
        const Spacer(),
      ],
    );
  }

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

  Widget _buildRestartButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
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
      ],
    );
  }

  void _onTapRestart() {
    _controller.stopTimer();
    _controller.restartTimer();
  }
}
