import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:house_management_app/animation/animation.dart';
import 'package:house_management_app/screen_login/forgot_password_sreen.dart';
import 'package:house_management_app/views/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'sigup_screen.dart';
import 'package:house_management_app/custom_scaffold/custom_scaffold.dart';
import 'package:house_management_app/custom_scaffold/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:house_management_app/models/sharedPreferences.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  final _formSignInKey = GlobalKey<FormState>();
  bool rememberPassword = true;

  Future<void> login() async {
    final _auth = FirebaseAuth.instance;
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: _email.text.trim(), password: _password.text.trim());
      print('User signed in: ${userCredential.user!.email}');
      // ignore: use_build_context_synchronously
      if (userCredential.user!.emailVerified) {
        Navigator.pushNamedAndRemoveUntil(
            context, "/homepage", (route) => false);
      } else {
        FirebaseAuth.instance.currentUser!.sendEmailVerification();
        // ignore: use_build_context_synchronously
        showDialog(
            context: context,
            builder: (context) {
              return const AlertDialog(
                content: Text('Please check email before login!!!'),
              );
            });
      }
    } on FirebaseAuthException catch (e) {
      print('Error signing in: $e');
      // ignore: use_build_context_synchronously
      showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              content:
                  Text('Invalid email or password!!! Please check again!!!'),
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: Column(
        children: [
          const Expanded(
            flex: 1,
            child: SizedBox(
              height: 10,
            ),
          ),
          Expanded(
            flex: 7,
            child: Container(
              padding: const EdgeInsets.fromLTRB(25.0, 50.0, 25.0, 20.0),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40.0),
                  topRight: Radius.circular(40.0),
                ),
              ),
              child: SingleChildScrollView(
                child: Form(
                  key: _formSignInKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      FadeAnimation(
                        1,
                        Text(
                          'Welcome back',
                          style: TextStyle(
                            fontSize: 30.0,
                            fontWeight: FontWeight.w900,
                            color: lightColorScheme.primary,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 40.0,
                      ),
                      FadeAnimation(
                        1.2,
                        TextFormField(
                          controller: _email,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Email';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            label: const Text('Email'),
                            hintText: 'Enter Email',
                            hintStyle: const TextStyle(
                              color: Colors.black26,
                            ),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.black12, // Default border color
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.black12, // Default border color
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 25.0,
                      ),
                      FadeAnimation(
                        1.6,
                        TextFormField(
                          controller: _password,
                          obscureText: true,
                          obscuringCharacter: '*',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Password';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            label: const Text('Password'),
                            hintText: 'Enter Password',
                            hintStyle: const TextStyle(
                              color: Colors.black26,
                            ),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.black12, // Default border color
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.black12, // Default border color
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 25.0,
                      ),
                      FadeAnimation(
                        1.8,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Checkbox(
                                  value: rememberPassword,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      rememberPassword = value!;
                                    });
                                  },
                                  activeColor: lightColorScheme.primary,
                                ),
                                const Text(
                                  'Remember me',
                                  style: TextStyle(
                                    color: Colors.black45,
                                  ),
                                ),
                              ],
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (e) => const ForgotPassword(),
                                  ),
                                );
                              },
                              child: Text(
                                'Forget password?',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: lightColorScheme.primary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 25.0,
                      ),
                      FadeAnimation(
                        2.0,
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formSignInKey.currentState!.validate()) {
                                login();
                                // final user = login(_email.text, _password.text);
                                // if (user == null) {
                                //   ScaffoldMessenger.of(context).showSnackBar(
                                //     const SnackBar(
                                //         content: Text(
                                //             'Please check again email and password!!!!!')),
                                //   );
                                // } else {
                                //   ScaffoldMessenger.of(context).showSnackBar(
                                //     const SnackBar(
                                //       content: Text('Login Success!'),
                                //     ),
                                //   );
                                //   Navigator.pushNamedAndRemoveUntil(
                                //       context, "/homepage", (route) => false);
                                //   if (rememberPassword) {
                                //     SharedPreferencesInfo.updateData(true);
                                //   }
                                // }
                                // if (user == 'user-not-found') {
                                //   ScaffoldMessenger.of(context).showSnackBar(
                                //     const SnackBar(
                                //       content: Text('Not found user'),
                                //     ),
                                //   );
                                // } else if (user == 'wrong-password') {
                                //   ScaffoldMessenger.of(context).showSnackBar(
                                //     const SnackBar(
                                //       content: Text('wrong password'),
                                //     ),
                                //   );
                                // } else {
                                if (rememberPassword) {
                                  SharedPreferencesInfo.updateData(true);
                                }
                                //   ScaffoldMessenger.of(context).showSnackBar(
                                //     const SnackBar(
                                //       content: Text('Login Success!'),
                                //     ),
                                //   );
                                //   Navigator.pushNamedAndRemoveUntil(
                                //       context, "/homepage", (route) => false);
                                // }
                              }

                              // if (!rememberPassword) {
                              //   ScaffoldMessenger.of(context).showSnackBar(
                              //     const SnackBar(
                              //         content: Text(
                              //             'Please agree to the processing of personal data')),
                              //   );
                              // }
                            },
                            child: const Text('Sign in'),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 25.0,
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     Expanded(
                      //       child: Divider(
                      //         thickness: 0.7,
                      //         color: Colors.grey.withOpacity(0.5),
                      //       ),
                      //     ),
                      //     const Padding(
                      //       padding: EdgeInsets.symmetric(
                      //         vertical: 0,
                      //         horizontal: 10,
                      //       ),
                      //       child: Text(
                      //         'Sign up with',
                      //         style: TextStyle(
                      //           color: Colors.black45,
                      //         ),
                      //       ),
                      //     ),
                      //     Expanded(
                      //       child: Divider(
                      //         thickness: 0.7,
                      //         color: Colors.grey.withOpacity(0.5),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      const SizedBox(
                        height: 25.0,
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //   children: [
                      //     Logo(Logos.facebook_f),
                      //     Logo(Logos.twitter),
                      //     Logo(Logos.google),
                      //     Logo(Logos.apple),
                      //   ],
                      // ),
                      const SizedBox(
                        height: 25.0,
                      ),
                      // don't have an account
                      FadeAnimation(
                        2.2,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Don\'t have an account? ',
                              style: TextStyle(
                                color: Colors.black45,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (e) => const SignUpScreen(),
                                  ),
                                );
                              },
                              child: Text(
                                'Sign up',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: lightColorScheme.primary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
