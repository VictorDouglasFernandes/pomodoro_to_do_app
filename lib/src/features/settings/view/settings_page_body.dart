import 'package:flutter/material.dart';
import 'package:pomodoro_to_do_app/src/commons/palette.dart';
import 'package:pomodoro_to_do_app/src/commons/text_styles.dart';

class SettingsPageBody extends StatefulWidget {
  const SettingsPageBody({Key? key}) : super(key: key);

  @override
  State<SettingsPageBody> createState() => _SettingsPageBodyState();
}

class _SettingsPageBodyState extends State<SettingsPageBody> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildBackIcon(),
          _buildCreatorPanel(),
        ],
      ),
    );
  }

  Widget _buildBackIcon() {
    return Row(
      children: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            splashColor: Palette.main,
            onTap: _onTapBackIcon,
            child: const Icon(
              Icons.chevron_left,
              size: 32.0,
              color: Palette.white,
            ),
          ),
        ),
      ],
    );
  }

  void _onTapBackIcon() => Navigator.pop(context);

  Widget _buildCreatorPanel() {
    return Container(
      child: const Text(
        'Developed by:\nVíctor Douglas Fernandes',
        style: montserrat18RegularWhite,
        textAlign: TextAlign.center,
      ),
    );
  }
}
