import 'package:flutter/material.dart';
import 'package:house_management_app/screen_login/signin_screen.dart';
import 'package:house_management_app/screen_login/sigup_screen.dart';
import 'package:house_management_app/screen_login/welcome_screen.dart';
//import 'package:house_management_app/screen_login/welcome_screen.dart';
import 'package:house_management_app/views/home_page.dart';
//import 'package:house_management_app/light_object/light_screen.dart';
//import 'package:house_management_app/views/notification_page.dart';
import 'package:firebase_core/firebase_core.dart';
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

  Future<String> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    final user = prefs.getString('user') ?? '';
    return user;
  }

  @override
  Widget build(BuildContext context) {
    String init_route = "/";
    Future<String> user = getToken().then((value) => init_route = value);
    print(init_route);

    return MaterialApp(
      initialRoute: init_route,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        "/": (context) => WelcomeScreen(),
        "/signin": (context) => SignInScreen(),
        "/signup": (context) => SignUpScreen(),
        "/homepage": (context) => HomeScreen()
      },
    );
  }
}
