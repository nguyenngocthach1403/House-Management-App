import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  Future signIn() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim());
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Center(
            child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.android,
                size: 100,
              ),
              const Text(
                "Hello Again!",
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Wellcome back!",
                style: TextStyle(fontSize: 30, color: Colors.grey),
              ),
              const SizedBox(
                height: 50,
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 60),
                  child: Container(
                    padding: const EdgeInsets.only(left: 20, bottom: 5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.white, width: 1),
                        borderRadius: BorderRadius.circular(10)),
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    alignment: Alignment.center,
                    child: TextField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                          border: InputBorder.none, hintText: 'Email'),
                      style: const TextStyle(fontSize: 15),
                    ),
                  )),
              const SizedBox(
                height: 12,
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 60),
                  child: Container(
                    padding: const EdgeInsets.only(left: 20, bottom: 5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.white, width: 1),
                        borderRadius: BorderRadius.circular(10)),
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    alignment: Alignment.center,
                    child: TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                          border: InputBorder.none, hintText: 'Password'),
                      style: const TextStyle(fontSize: 15),
                    ),
                  )),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 60),
                child: GestureDetector(
                  onTap: signIn,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(12)),
                    height: 60,
                    alignment: Alignment.center,
                    child: const Text(
                      "Sign in",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "Not a member?",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    " Register now",
                    style: TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.bold),
                  )
                ],
              )
            ],
          ),
        )),
      ),
    );
  }
}
