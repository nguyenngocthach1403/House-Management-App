import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:shared_preferences/shared_preferences.dart';

class AlarmControlWidget extends StatefulWidget {
  const AlarmControlWidget({
    Key? key,
    required this.selectedTime,
    required this.selectedValue,
    required this.incrementTime,
    required this.decrementTime,
    required this.onValueChange,
  }) : super(key: key);

  final int selectedTime;
  final String selectedValue;
  final VoidCallback incrementTime;
  final VoidCallback decrementTime;
  final ValueChanged<String?> onValueChange;

  @override
  _AlarmControlWidgetState createState() => _AlarmControlWidgetState();
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
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 25),
                      child: Icon(
                        Icons.speed_outlined,
                        color: Colors.black,
                        size: 40.0,
                      ),
                    ),
                    const SizedBox(width: 9),
                    Title(
                      color: Colors.black,
                      child: const Text(
                        "Flashing speed:",
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 90),
                    DropdownButton<String>(
                      value: widget.selectedValue,
                      items: List.generate(5, (index) {
                        int value = (index + 1) * 100;
                        return DropdownMenuItem<String>(
                          value: '$value' + 'mls',
                          child: Text(
                            '$value' + ' mls',
                            style: const TextStyle(
                              fontSize: 17.0,
                              color: Colors.black,
                            ),
                          ),
                        );
                      }),
                      onChanged: widget.onValueChange,
                      style: const TextStyle(
                        fontSize: 17.0,
                        color: Colors.black,
                      ),
                      iconSize: 20.0,
                      icon: const Icon(
                        Icons.arrow_drop_down,
                        color: Colors.black,
                      ),
                      underline: Container(
                        height: 2,
                        color: Colors
                            .black, // Màu của đường gạch dưới DropdownButton
                      ),
                      iconDisabledColor: Colors.grey,
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 25),
                      child: Icon(
                        Icons.access_alarms_outlined,
                        color: Colors.black,
                        size: 40.0,
                      ),
                    ),
                    const SizedBox(width: 9),
                    Title(
                      color: Colors.black,
                      child: const Text(
                        "Time:",
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: widget.decrementTime,
                      color: Colors.blue,
                    ),
                    Text(
                      '${widget.selectedTime} s',
                      style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: widget.incrementTime,
                      color: Colors.red,
                    ),
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
