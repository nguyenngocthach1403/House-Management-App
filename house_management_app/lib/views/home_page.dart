import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                child:
                    CircleAvatar(backgroundImage: AssetImage("images/h1.png")),
              ),
              TweenAnimationBuilder(
                tween: Tween<double>(begin: 0, end: 1),
                duration: const Duration(seconds: 1),
                builder: ((context, value, child) {
                  return Opacity(
                    opacity: value,
                    child: Padding(
                      padding: EdgeInsets.only(left: 20 - value * 20),
                      child: child,
                    ),
                  );
                }),
                child: const Text("Home"),
              ),
            ],
          ),
          backgroundColor: const Color.fromARGB(255, 15, 125, 21),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
          child: Column(
            children: [],
          ),
        ));
  }
}
