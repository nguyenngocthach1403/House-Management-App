import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KitchenControlWidget extends StatelessWidget {
  final double brightnessValue;
  final ValueChanged<double> onBrightnessChanged;
  final double temperatureValue;
  final double humidityValue;
  final VoidCallback onSwitchChanged;
  final bool switchValue;

  const KitchenControlWidget({
    Key? key,
    required this.brightnessValue,
    required this.onBrightnessChanged,
    required this.temperatureValue,
    required this.humidityValue,
    required this.onSwitchChanged,
    required this.switchValue,
  }) : super(key: key);

  Future<void> _saveBrightnessValue(double value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble('kitchenBrightnessValue', value);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 10.0,
        ),
        Container(
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
          height: MediaQuery.of(context).size.height / 3.81,
          width: MediaQuery.of(context).size.width - 20,
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Icon(
                      Icons.light_outlined,
                      color: Colors.yellow[700],
                      size: 45.0,
                    ),
                  ),
                  Title(
                    color: Colors.black,
                    child: const Text(
                      "Kitchen Light",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 135),
                    child: Transform.scale(
                      scale: 1.3,
                      child: CupertinoSwitch(
                        value: switchValue,
                        onChanged: (bool value) {
                          onSwitchChanged();
                        },
                      ),
                    ),
                  )
                ],
              ),
              Expanded(
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: Icon(
                        Icons.lightbulb_outlined,
                        color: Colors.yellow[600],
                        size: 30.0,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          activeTrackColor: Colors.blue,
                          inactiveTrackColor: Colors.grey,
                          thumbColor: Colors.white,
                          overlayColor: Colors.grey.withOpacity(0.3),
                          valueIndicatorColor: Colors.grey[350],
                          valueIndicatorTextStyle: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          trackHeight: 9.5,
                        ),
                        child: Slider(
                          value: brightnessValue,
                          onChanged: onBrightnessChanged,
                          min: 0,
                          max: 100,
                          divisions: 10,
                          label: "${brightnessValue.toInt()}%",
                        ),
                      ),
                    ),
                    Icon(
                      Icons.lightbulb,
                      color: Colors.yellow[600],
                      size: 30.0,
                    ),
                    const SizedBox(width: 45.0),
                    Title(
                      color: Colors.black,
                      child: Text(
                        "${brightnessValue.toInt()}%",
                        style: const TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8),
                    child: Icon(
                      Icons.thermostat_outlined,
                      color: Colors.red,
                      size: 45.0,
                    ),
                  ),
                  Title(
                    color: Colors.black,
                    child: const Text(
                      "Temperature",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 140),
                  Title(
                    color: Colors.black,
                    child: Text(
                      "${temperatureValue} °C",
                      style: const TextStyle(
                        fontSize: 19.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8),
                    child: Icon(
                      Icons.water_drop_outlined,
                      color: Colors.blue,
                      size: 45.0,
                    ),
                  ),
                  Title(
                    color: Colors.black,
                    child: const Text(
                      "Humidity",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 170),
                  Title(
                    color: Colors.black,
                    child: Text(
                      "${humidityValue}%",
                      style: const TextStyle(
                        fontSize: 19.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
