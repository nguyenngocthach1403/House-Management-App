import 'package:flutter/material.dart';

class AlarmControlWidget extends StatefulWidget {
  const AlarmControlWidget({super.key});

  @override
  State<AlarmControlWidget> createState() => _AlarmControlWidgetState();
}

class _AlarmControlWidgetState extends State<AlarmControlWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 10.0,
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(30.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  spreadRadius: 5,
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            height: MediaQuery.of(context).size.height / 5,
            width: MediaQuery.of(context).size.width - 20,
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Icon(
                        Icons.notifications_active_outlined,
                        color: Colors.red[900],
                        size: 45.0,
                      ),
                    ),
                    Title(
                      color: Colors.black,
                      child: const Text(
                        "Alarm",
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
