import 'package:flutter/material.dart';
import 'package:house_management_app/animation/animation.dart';
import 'package:house_management_app/models/sharedPreferences.dart';
import 'signin_screen.dart';
import 'sigup_screen.dart';
import 'package:house_management_app/custom_scaffold/custom_scaffold.dart';
import 'package:house_management_app/custom_scaffold/welcome_button.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool isLogged = false;
  loadAccountCurrent() {
    SharedPreferencesInfo.getToken().then((value) {
      setState(() {
        isLogged = value;
        a();
      });
    });
  }

  void a() {
    if (isLogged) {
      Navigator.pushReplacementNamed(context, '/homepage');
    }
  }

  @override
  void initState() {
    loadAccountCurrent();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: Column(
        children: [
          Flexible(
              flex: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 0,
                  horizontal: 40,
                ),
                child: FadeAnimation(
                  1.2,
                  Center(
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: const TextSpan(
                        children: [
                          TextSpan(
                              text: 'Welcome Back!\n',
                              style: TextStyle(
                                fontSize: 45.0,
                                fontWeight: FontWeight.w600,
                              )),
                          TextSpan(
                              text:
                                  '\nEnter personal details to your employee account',
                              style: TextStyle(fontSize: 20))
                        ],
                      ),
                    ),
                  ),
                ),
              )),
          Flexible(
            flex: 1,
            child: Align(
              alignment: Alignment.bottomRight,
              child: FadeAnimation(
                1.4,
                Row(
                  children: const [
                    Expanded(
                        child: WelcomeButton(
                      buttonText: 'Sign in',
                      onTap: SignInScreen(),
                      color: Colors.transparent,
                      textColor: Colors.white,
                    )),
                    Expanded(
                        child: WelcomeButton(
                      buttonText: 'Sign up',
                      onTap: SignUpScreen(),
                      color: Colors.white,
                      textColor: Colors.green,
                    )),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
