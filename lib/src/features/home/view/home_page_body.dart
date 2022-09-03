import 'package:flutter/material.dart';
import 'package:pomodoro_to_do_app/src/commons/palette.dart';
import 'package:pomodoro_to_do_app/src/features/clock/controllers/clock_kf_controller.dart';
import 'package:pomodoro_to_do_app/src/features/clock/view/clock_kf.dart';
import 'package:pomodoro_to_do_app/src/features/clock/view/clock_status_navigation.dart';

class HomePageBody extends StatefulWidget {
  const HomePageBody({Key? key}) : super(key: key);

  @override
  State<HomePageBody> createState() => _HomePageBodyState();
}

class _HomePageBodyState extends State<HomePageBody> {
  final ClockKFController _clockController = ClockKFController();

  @override
  void initState() {
    _clockController.getPreviousState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildConfigureIcon(),
          ClockKF(controller: _clockController),
          ClockStatusNavigation(controller: _clockController),
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
}
