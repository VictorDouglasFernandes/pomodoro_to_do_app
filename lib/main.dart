import 'package:flutter/material.dart';
import 'package:pomodoro_to_do_app/src/features/home/view/home_page.dart';
import 'package:pomodoro_to_do_app/src/features/notification/services/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pomodoro To Do App',
      initialRoute: 'home',
      routes: {
        'home': (_) => const HomePage(),
        //'settings': (_) => const SettingsPage(),
      },
    );
  }
}
