import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:house_management_app/light_object/light_screen.dart';
import 'package:house_management_app/light_object/living_control_widget.dart';
import 'package:house_management_app/screen_login/signin_screen.dart';
import 'package:house_management_app/screen_login/sigup_screen.dart';
import 'package:house_management_app/screen_login/welcome_screen.dart';
//import 'package:house_management_app/screen_login/welcome_screen.dart';
import 'package:house_management_app/views/home_page.dart';
//import 'package:house_management_app/light_object/light_screen.dart';
//import 'package:house_management_app/views/notification_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:house_management_app/views/notification_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        "/": (context) => WelcomeScreen(),
        "/signin": (context) => SignInScreen(),
        "/signup": (context) => SignUpScreen(),
        "/homepage": (context) => HomeScreen(),
        '/notifications': (context) => NotificationScreen(),
        '/settingscreen': (context) => LightScreen()
      },
    );
  }
}
