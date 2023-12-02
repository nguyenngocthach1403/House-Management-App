import 'package:flutter/material.dart';
import 'package:house_management_app/light_object/alarm_control_widgget.dart';
import 'package:house_management_app/light_object/living_control_widget.dart';
import 'package:house_management_app/light_object/kitchen_control_widget.dart';
import 'package:house_management_app/light_object/bedroom_control_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:house_management_app/firebase_service.dart';
import 'package:firebase_database/firebase_database.dart';

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

  late FirebaseService _livingRoomFirebaseService;
  late FirebaseService _kitchenFirebaseService;
  late FirebaseService _bedRoomFirebaseService;

  // Variables for AlarmControlWidget
  String selectedValue = '100mls';
  int selectedTime = 5;

  // DatabaseReference for 'alarmLed'
  final DatabaseReference _alarmLedReference =
      FirebaseDatabase.instance.reference().child('alarmLed');

  @override
  void initState() {
    super.initState();
    _loadSwitchAndBrightnessValues();
    _loadSelectedTime();
    _loadSelectedValue();
    _livingRoomFirebaseService = FirebaseService('livingRoomLed');
    _kitchenFirebaseService = FirebaseService('kitchenRoomLed');
    _bedRoomFirebaseService = FirebaseService('bedRoomLed');
  }

  void onSwitchChanged(
      bool value, bool isLivingRoom, bool isKitchen, bool isBedRoom) {
    setState(() {
      if (isLivingRoom) {
        livingRoomSwitchValue = value;
        _saveSwitchState(value, 'livingRoom');
        _livingRoomFirebaseService.updateSwitchStatus(value);
      }
      if (isKitchen) {
        kitchenSwitchValue = value;
        _saveSwitchState(value, 'kitchen');
        _kitchenFirebaseService.updateSwitchStatus(value);
      }
      if (isBedRoom) {
        bedRoomSwitchValue = value;
        _saveSwitchState(value, 'bedRoom');
        _bedRoomFirebaseService.updateSwitchStatus(value);
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

  Future<void> _updateBrightness(
      FirebaseService firebaseService, double brightness) async {
    await firebaseService.updateBrightness(brightness);
  }

  Future<void> _loadSwitchAndBrightnessValues() async {
    await _loadSwitchState('livingRoom');
    await _loadBrightnessValue('livingRoom');
    await _loadSwitchState('kitchen');
    await _loadBrightnessValue('kitchen');
    await _loadSwitchState('bedRoom');
    await _loadBrightnessValue('bedRoom');
  }

  // Phương thức để cập nhật dữ liệu 'time' và 'speed' lên Firebase
  Future<void> _updateAlarmLedData(int time, int speed) async {
    await _alarmLedReference.update({
      'time': time,
      'speed': speed,
    });
  }

  void _loadSelectedTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedTime = prefs.getInt('selectedTime') ?? 5;
    });
  }

  void _saveSelectedTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('selectedTime', selectedTime);
  }

  void _loadSelectedValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedValue = prefs.getString('selectedValue') ?? '100mls';
    });
  }

  void _saveSelectedValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('selectedValue', selectedValue);
  }

  void incrementTime() {
    setState(() {
      if (selectedTime < 30) {
        selectedTime += 1;
        _saveSelectedTime();
        // Cập nhật 'time' lên Firebase khi giá trị thay đổi
        _updateAlarmLedData(
            selectedTime, int.parse(selectedValue.replaceAll('mls', '')));
      }
    });
  }

  void decrementTime() {
    setState(() {
      if (selectedTime > 5) {
        selectedTime -= 1;
        _saveSelectedTime();
        // Cập nhật 'time' lên Firebase khi giá trị thay đổi
        _updateAlarmLedData(
            selectedTime, int.parse(selectedValue.replaceAll('mls', '')));
      }
    });
  }

  void onValueChange(String? value) {
    if (value != null) {
      setState(() {
        selectedValue = value;
        _saveSelectedValue();
        // Cập nhật 'speed' lên Firebase khi giá trị thay đổi
        _updateAlarmLedData(
            selectedTime, int.parse(value.replaceAll('mls', '')));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
              child: CircleAvatar(backgroundImage: AssetImage("images/h1.png")),
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
              child: const Text(
                "Light Menu",
                style: TextStyle(fontSize: 25),
              ),
            ),
            const SizedBox(width: 56),
          ],
        ),
        backgroundColor: const Color.fromRGBO(58, 126, 111, 1),
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: 4,
        itemBuilder: (context, index) {
          switch (index) {
            case 0:
              return LivingControlWidget(
                brightnessValue: livingRoomBrightnessValue,
                onBrightnessChanged: (value) async {
                  setState(() {
                    livingRoomBrightnessValue = value;
                    _saveBrightnessValue(value, 'livingRoom');
                  });
                  await _updateBrightness(
                      _livingRoomFirebaseService, livingRoomBrightnessValue);
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
                onBrightnessChanged: (value) async {
                  setState(() {
                    kitchenBrightnessValue = value;
                    _saveBrightnessValue(value, 'kitchen');
                  });
                  await _updateBrightness(
                      _kitchenFirebaseService, kitchenBrightnessValue);
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
                onBrightnessChanged: (value) async {
                  setState(() {
                    bedRoomBrightnessValue = value;
                    _saveBrightnessValue(value, 'bedRoom');
                  });
                  await _updateBrightness(
                      _bedRoomFirebaseService, bedRoomBrightnessValue);
                },
                temperatureValue: bedRoomTemperatureValue,
                humidityValue: bedRoomHumidityValue,
                onSwitchChanged: () {
                  onSwitchChanged(!bedRoomSwitchValue, false, false, true);
                },
                switchValue: bedRoomSwitchValue,
              );
            case 3:
              return AlarmControlWidget(
                selectedTime: selectedTime,
                selectedValue: selectedValue,
                incrementTime: incrementTime,
                decrementTime: decrementTime,
                onValueChange: onValueChange,
              );

            default:
              return Container();
          }
        },
      ),
    );
  }
}
