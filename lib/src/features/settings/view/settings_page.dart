import 'package:flutter/material.dart';
import 'package:pomodoro_to_do_app/src/commons/palette.dart';
import 'package:pomodoro_to_do_app/src/features/settings/view/settings_page_body.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Palette.black,
        child: const SafeArea(
          child: SettingsPageBody(),
        ),
      ),
    );
  }
}
