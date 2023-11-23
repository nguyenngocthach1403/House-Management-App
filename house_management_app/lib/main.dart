import 'package:flutter/material.dart';
import 'package:house_management_app/screen_login/welcome_screen.dart';
import 'package:house_management_app/views/home_page.dart';
import 'package:house_management_app/light_object/light_screen.dart';
import 'package:house_management_app/views/notification_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}
