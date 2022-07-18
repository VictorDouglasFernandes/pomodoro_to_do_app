import 'package:flutter/material.dart';
import 'package:pomodoro_to_do_app/src/features/home/view/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Pomodoro To Do App',
      home: HomePage(),
    );
  }
}
