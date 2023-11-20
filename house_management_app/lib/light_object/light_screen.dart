import 'package:flutter/material.dart';
import 'package:house_management_app/light_object/living_control_widget.dart';
import 'package:house_management_app/light_object/kitchen_control_widget.dart';

import 'package:house_management_app/light_object/bedroom_control_widget.dart';
import 'package:house_management_app/light_object/alarm_control_widgget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LightScreen extends StatefulWidget {
  const LightScreen({Key? key}) : super(key: key);

  @override
  State<LightScreen> createState() => _LightScreenState();
}

class _LightScreenState extends State<LightScreen> {
  double livingRoomBrightnessValue = 0;
  double livingRoomTemperatureValue = 31.0;
  double livingRoomHumidityValue = 28.2;
  bool livingRoomSwitchValue = false;

  double kitchenBrightnessValue = 0;
  double kitchenTemperatureValue = 33.0;
  double kitchenHumidityValue = 39.0;
  bool kitchenSwitchValue = false;

  double bedRoomBrightnessValue = 0;
  double bedRoomTemperatureValue = 25.0;
  double bedRoomHumidityValue = 40.0;
  bool bedRoomSwitchValue = false;

  late SharedPreferences _prefs;

  @override
  void initState() {
    super.initState();
    _loadSwitchAndBrightnessValues();
  }

  void onSwitchChanged(
      bool value, bool isLivingRoom, bool isKitchen, bool isBedRoom) {
    setState(() {
      if (isLivingRoom) {
        livingRoomSwitchValue = value;
        _saveSwitchState(value, 'livingRoom');
      }
      if (isKitchen) {
        kitchenSwitchValue = value;
        _saveSwitchState(value, 'kitchen');
      }
      if (isBedRoom) {
        bedRoomSwitchValue = value;
        _saveSwitchState(value, 'bedRoom');
      }
    });
  }

  Future<void> _loadSwitchState(String roomKey) async {
    _prefs = await SharedPreferences.getInstance();
    bool switchValue = _prefs.getBool('$roomKey-switchValue') ?? false;
    double brightnessValue = _prefs.getDouble('$roomKey-brightnessValue') ?? 0;
    setState(() {
      if (roomKey == 'livingRoom') {
        livingRoomSwitchValue = switchValue;
        livingRoomBrightnessValue = brightnessValue;
      } else if (roomKey == 'kitchen') {
        kitchenSwitchValue = switchValue;
        kitchenBrightnessValue = brightnessValue;
      } else if (roomKey == 'bedRoom') {
        bedRoomSwitchValue = switchValue;
        bedRoomBrightnessValue = brightnessValue;
      }
    });
  }

  Future<void> _saveSwitchState(bool value, String roomKey) async {
    _prefs = await SharedPreferences.getInstance();
    _prefs.setBool('$roomKey-switchValue', value);
  }

  Future<void> _loadBrightnessValue(String roomKey) async {
    _prefs = await SharedPreferences.getInstance();
    double brightnessValue = _prefs.getDouble('$roomKey-brightnessValue') ?? 0;
    setState(() {
      if (roomKey == 'livingRoom') {
        livingRoomBrightnessValue = brightnessValue;
      } else if (roomKey == 'kitchen') {
        kitchenBrightnessValue = brightnessValue;
      } else if (roomKey == 'bedRoom') {
        bedRoomBrightnessValue = brightnessValue;
      }
    });
  }

  Future<void> _saveBrightnessValue(double value, String roomKey) async {
    _prefs = await SharedPreferences.getInstance();
    _prefs.setDouble('$roomKey-brightnessValue', value);
  }

  Future<void> _loadSwitchAndBrightnessValues() async {
    await _loadSwitchState('livingRoom');
    await _loadBrightnessValue('livingRoom');
    await _loadSwitchState('kitchen');
    await _loadBrightnessValue('kitchen');
    await _loadSwitchState('bedRoom');
    await _loadBrightnessValue('bedRoom');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("LIGHT MENU"),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          switch (index) {
            case 0:
              return LivingControlWidget(
                brightnessValue: livingRoomBrightnessValue,
                onBrightnessChanged: (value) {
                  setState(() {
                    livingRoomBrightnessValue = value;
                    _saveBrightnessValue(value, 'livingRoom');
                  });
                },
                temperatureValue: livingRoomTemperatureValue,
                humidityValue: livingRoomHumidityValue,
                onSwitchChanged: () {
                  onSwitchChanged(!livingRoomSwitchValue, true, false, false);
                },
                switchValue: livingRoomSwitchValue,
              );
            case 1:
              return KitchenControlWidget(
                brightnessValue: kitchenBrightnessValue,
                onBrightnessChanged: (value) {
                  setState(() {
                    kitchenBrightnessValue = value;
                    _saveBrightnessValue(value, 'kitchen');
                  });
                },
                temperatureValue: kitchenTemperatureValue,
                humidityValue: kitchenHumidityValue,
                onSwitchChanged: () {
                  onSwitchChanged(!kitchenSwitchValue, false, true, false);
                },
                switchValue: kitchenSwitchValue,
              );
            case 2:
              return BedRoomControlWidget(
                brightnessValue: bedRoomBrightnessValue,
                onBrightnessChanged: (value) {
                  setState(() {
                    bedRoomBrightnessValue = value;
                    _saveBrightnessValue(value, 'bedRoom');
                  });
                },
                temperatureValue: bedRoomTemperatureValue,
                humidityValue: bedRoomHumidityValue,
                onSwitchChanged: () {
                  onSwitchChanged(!bedRoomSwitchValue, false, false, true);
                },
                switchValue: bedRoomSwitchValue,
              );
            case 3:
              return AlarmControlWidget();
            // case 4:
            //   return BedRoomControlWidget(
            //     brightnessValue: bedRoomBrightnessValue,
            //     onBrightnessChanged: (value) {
            //       setState(() {
            //         bedRoomBrightnessValue = value;
            //         _saveBrightnessValue(value, 'bedRoom');
            //       });
            //     },
            //     temperatureValue: bedRoomTemperatureValue,
            //     humidityValue: bedRoomHumidityValue,
            //     onSwitchChanged: () {
            //       onSwitchChanged(!bedRoomSwitchValue, false, false, true);
            //     },
            //     switchValue: bedRoomSwitchValue,
            //   );

            default:
              return Container();
          }
        },
      ),
    );
  }
}
