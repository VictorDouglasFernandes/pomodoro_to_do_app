import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:pomodoro_to_do_app/src/commons/palette.dart';
import 'package:pomodoro_to_do_app/src/commons/text_styles.dart';
import 'package:pomodoro_to_do_app/src/features/home/controllers/home_controller.dart';
import 'package:pomodoro_to_do_app/src/features/home/entities/enums/clock_type.dart';
import 'package:pomodoro_to_do_app/src/features/home/entities/enums/time_type.dart';

class HomePageBody extends StatefulWidget {
  const HomePageBody({Key? key}) : super(key: key);

  @override
  State<HomePageBody> createState() => _HomePageBodyState();
}

class _HomePageBodyState extends State<HomePageBody> {
  final HomeController _controller = HomeController();

  late Size _size;

  @override
  void initState() {
    _controller.getPreviousState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildConfigureIcon(),
          _buildActionClock(),
          _buildStateButtons(),
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
            onTap: _onTapConfigureIcon,
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

  void _onTapConfigureIcon() {
    Navigator.pushNamed(context, 'settings');
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
          ),
        ),
        const Spacer(),
      ],
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

  Widget _buildStateButtons() {
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
