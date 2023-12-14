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
  double livingRoomTemperatureValue = 0;
  double livingRoomHumidityValue = 0;
  bool livingRoomSwitchValue = false;
  String livingRoomLightStatus = 'OFF';

  double kitchenRoomBrightnessValue = 0;
  double kitchenRoomTemperatureValue = 0;
  double kitchenRoomHumidityValue = 0;
  bool kitchenRoomSwitchValue = false;
  String kitchenRoomLightStatus = 'OFF';

  double bedRoomBrightnessValue = 0;
  double bedRoomTemperatureValue = 0;
  double bedRoomHumidityValue = 0;
  bool bedRoomSwitchValue = false;
  String bedRoomLightStatus = 'OFF';

  int alarmLedTimeValue = 0;

  late SharedPreferences _prefs;

  late FirebaseService _livingRoomFirebaseService;
  late FirebaseService _kitchenFirebaseService;
  late FirebaseService _bedRoomFirebaseService;

  String selectedValue = '100mls';
  int selectedTime = 5;

  final DatabaseReference _alarmLedReference =
      // ignore: deprecated_member_use
      FirebaseDatabase.instance.reference().child('alarmLed');

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _loadSwitchAndBrightnessValues();
    _loadSelectedTime();
    _loadSelectedValue();
    _livingRoomFirebaseService = FirebaseService('livingRoom');
    _kitchenFirebaseService = FirebaseService('kitchenRoom');
    _bedRoomFirebaseService = FirebaseService('bedRoom');

    DatabaseReference alarmLedTimeRef =
        FirebaseDatabase.instance.reference().child('alarmLed/time');

    alarmLedTimeRef.onValue.listen((event) {
      setState(() {
        var value = event.snapshot.value;
        if (value is num) {
          alarmLedTimeValue = value.toInt();
          // Cập nhật selectedTime khi giá trị time thay đổi
          selectedTime = alarmLedTimeValue;
        } else {
          alarmLedTimeValue = 0;
        }
      });
    });

    /* Cập nhật trạng thái của LivingRoom */
    DatabaseReference livingRoomLightStatusRef =
        // ignore: deprecated_member_use
        FirebaseDatabase.instance.reference().child('livingRoom/light/status');
    livingRoomLightStatusRef.onValue.listen((event) {
      if (mounted) {
        setState(() {
          livingRoomLightStatus = event.snapshot.value.toString();
          livingRoomSwitchValue = (livingRoomLightStatus == 'ON');
        });
      }
    });
    DatabaseReference livingRoomBrightnessRef = FirebaseDatabase.instance
        // ignore: deprecated_member_use
        .reference()
        .child('livingRoom/light/brightness');
    livingRoomBrightnessRef.onValue.listen((event) {
      if (mounted) {
        setState(() {
          var value = event.snapshot.value;
          if (value is num) {
            livingRoomBrightnessValue = value.toDouble();
          } else {
            livingRoomBrightnessValue = 0.0;
          }
        });
      }
    });

    /* Cập nhật trạng thái của KitchenRoom */
    DatabaseReference kitchenRoomLightStatusRef =
        // ignore: deprecated_member_use
        FirebaseDatabase.instance.reference().child('kitchenRoom/light/status');
    kitchenRoomLightStatusRef.onValue.listen((event) {
      if (mounted) {
        setState(() {
          kitchenRoomLightStatus = event.snapshot.value.toString();
          kitchenRoomSwitchValue = (kitchenRoomLightStatus == 'ON');
        });
      }
    });
    DatabaseReference kitchenRoomBrightnessRef = FirebaseDatabase.instance
        // ignore: deprecated_member_use
        .reference()
        .child('kitchenRoom/light/brightness');
    kitchenRoomBrightnessRef.onValue.listen((event) {
      if (mounted) {
        setState(() {
          var value = event.snapshot.value;
          if (value is num) {
            kitchenRoomBrightnessValue = value.toDouble();
          } else {
            kitchenRoomBrightnessValue = 0.0;
          }
        });
      }
    });

    /* Cập nhật trạng thái của BedRoom */
    DatabaseReference bedRoomLightStatusRef =
        // ignore: deprecated_member_use
        FirebaseDatabase.instance.reference().child('bedRoom/light/status');
    bedRoomLightStatusRef.onValue.listen((event) {
      setState(() {
        bedRoomLightStatus = event.snapshot.value.toString();
        bedRoomSwitchValue = (bedRoomLightStatus == 'ON');
      });
    });
    DatabaseReference bedRoomBrightnessRef =
        // ignore: deprecated_member_use
        FirebaseDatabase.instance.reference().child('bedRoom/light/brightness');
    bedRoomBrightnessRef.onValue.listen((event) {
      if (mounted) {
        setState(() {
          var value = event.snapshot.value;
          if (value is num) {
            bedRoomBrightnessValue = value.toDouble();
          } else {
            bedRoomBrightnessValue = 0.0;
          }
        });
      }
    });

    /* Cập nhật nhiệt độ và độ ẩm của LivingRoom */
    DatabaseReference livingRoomHumidityRef = FirebaseDatabase.instance
        // ignore: deprecated_member_use
        .reference()
        .child('livingRoom/humidity');

    livingRoomHumidityRef.onValue.listen((event) {
      if (mounted) {
        setState(() {
          var value = event.snapshot.value;
          if (value is num) {
            livingRoomHumidityValue = value.toDouble();
          } else {
            livingRoomHumidityValue = 0.0;
          }
        });
      }
    });
    DatabaseReference livingRoomTemperatureRef = FirebaseDatabase.instance
        // ignore: deprecated_member_use
        .reference()
        .child('livingRoom/temperature');

    livingRoomTemperatureRef.onValue.listen((event) {
      if (mounted) {
        setState(() {
          var value = event.snapshot.value;
          if (value is num) {
            livingRoomTemperatureValue = value.toDouble();
          } else {
            livingRoomTemperatureValue = 0.0;
          }
        });
      }
    });

    /* Cập nhật nhiệt độ và độ ẩm của KitchenRoom */
    DatabaseReference kitChenRoomHumidityRef = FirebaseDatabase.instance
        // ignore: deprecated_member_use
        .reference()
        .child('kitchenRoom/humidity');

    kitChenRoomHumidityRef.onValue.listen((event) {
      setState(() {
        var value = event.snapshot.value;
        if (value is num) {
          kitchenRoomHumidityValue = value.toDouble();
        } else {
          kitchenRoomHumidityValue = 0.0;
        }
      });
    });
    DatabaseReference kitChenRoomTemperatureRef = FirebaseDatabase.instance
        // ignore: deprecated_member_use
        .reference()
        .child('kitchenRoom/temperature');

    kitChenRoomTemperatureRef.onValue.listen((event) {
      if (mounted) {
        setState(() {
          var value = event.snapshot.value;
          if (value is num) {
            kitchenRoomTemperatureValue = value.toDouble();
          } else {
            kitchenRoomTemperatureValue = 0.0;
          }
        });
      }
    });

    /* Cập nhật nhiệt độ và độ ẩm của BedRoom */
    DatabaseReference bedRoomHumidityRef = FirebaseDatabase.instance
        // ignore: deprecated_member_use
        .reference()
        .child('bedRoom/humidity');

    bedRoomHumidityRef.onValue.listen((event) {
      if (mounted) {
        setState(() {
          var value = event.snapshot.value;
          if (value is num) {
            bedRoomHumidityValue = value.toDouble();
          } else {
            bedRoomHumidityValue = 0.0;
          }
        });
      }
    });

    DatabaseReference bedRoomTemperatureRef = FirebaseDatabase.instance
        // ignore: deprecated_member_use
        .reference()
        .child('bedRoom/temperature');

    bedRoomTemperatureRef.onValue.listen((event) {
      if (mounted) {
        setState(() {
          var value = event.snapshot.value;
          if (value is num) {
            bedRoomTemperatureValue = value.toDouble();
          } else {
            bedRoomTemperatureValue = 0.0;
          }
        });
      }
    });
  }

  void onSwitchChanged(
      bool value, bool isLivingRoom, bool isKitchen, bool isBedRoom) {
    if (mounted) {
      setState(() {
        if (isLivingRoom) {
          livingRoomSwitchValue = value;
          _saveSwitchState(value, 'livingRoom');
          _livingRoomFirebaseService.updateSwitchStatus(value);
        }
        if (isKitchen) {
          kitchenRoomSwitchValue = value;
          _saveSwitchState(value, 'kitchenRoom');
          _kitchenFirebaseService.updateSwitchStatus(value);
        }
        if (isBedRoom) {
          bedRoomSwitchValue = value;
          _saveSwitchState(value, 'bedRoom');
          _bedRoomFirebaseService.updateSwitchStatus(value);
        }
      });
    }
  }

  Future<void> _loadSwitchState(String roomKey) async {
    _prefs = await SharedPreferences.getInstance();
    bool switchValue = _prefs.getBool('$roomKey-switchValue') ?? false;
    double brightnessValue = _prefs.getDouble('$roomKey-brightnessValue') ?? 0;
    if (mounted) {
      setState(() {
        if (roomKey == 'livingRoom') {
          livingRoomSwitchValue = switchValue;
          livingRoomBrightnessValue = brightnessValue;
        } else if (roomKey == 'kitchenRoom') {
          kitchenRoomSwitchValue = switchValue;
          kitchenRoomBrightnessValue = brightnessValue;
        } else if (roomKey == 'bedRoom') {
          bedRoomSwitchValue = switchValue;
          bedRoomBrightnessValue = brightnessValue;
        }
      });
    }
  }

  Future<void> _saveSwitchState(bool value, String roomKey) async {
    _prefs = await SharedPreferences.getInstance();
    _prefs.setBool('$roomKey-switchValue', value);
  }

  Future<void> _loadBrightnessValue(String roomKey) async {
    _prefs = await SharedPreferences.getInstance();
    double brightnessValue = _prefs.getDouble('$roomKey-brightnessValue') ?? 0;
    if (mounted) {
      setState(() {
        if (roomKey == 'livingRoom') {
          livingRoomBrightnessValue = brightnessValue;
        } else if (roomKey == 'kitchenRoom') {
          kitchenRoomBrightnessValue = brightnessValue;
        } else if (roomKey == 'bedRoom') {
          bedRoomBrightnessValue = brightnessValue;
        }
      });
    }
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
    await _loadSwitchState('kitchenRoom');
    await _loadBrightnessValue('kitchenRoom');
    await _loadSwitchState('bedRoom');
    await _loadBrightnessValue('bedRoom');
  }

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
    if (mounted) {
      setState(() {
        if (selectedTime < 30) {
          selectedTime += 1;
          _saveSelectedTime();

          _updateAlarmLedData(
              selectedTime, int.parse(selectedValue.replaceAll('mls', '')));
        }
      });
    }
  }

  void decrementTime() {
    if (mounted) {
      setState(() {
        if (selectedTime > 5) {
          selectedTime -= 1;
          _saveSelectedTime();

          _updateAlarmLedData(
              selectedTime, int.parse(selectedValue.replaceAll('mls', '')));
        }
      });
    }
  }

  void onValueChange(String? value) {
    if (value != null) {
      if (mounted) {
        setState(() {
          selectedValue = value;
          _saveSelectedValue();

          _updateAlarmLedData(
              selectedTime, int.parse(value.replaceAll('mls', '')));
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
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
                  if (mounted) {
                    setState(() {
                      livingRoomBrightnessValue = value;
                      _saveBrightnessValue(value, 'livingRoom');
                    });
                  }
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
                brightnessValue: kitchenRoomBrightnessValue,
                onBrightnessChanged: (value) async {
                  if (mounted) {
                    setState(() {
                      kitchenRoomBrightnessValue = value;
                      _saveBrightnessValue(value, 'kitchenRoom');
                    });
                  }
                  await _updateBrightness(
                      _kitchenFirebaseService, kitchenRoomBrightnessValue);
                },
                temperatureValue: kitchenRoomTemperatureValue,
                humidityValue: kitchenRoomHumidityValue,
                onSwitchChanged: () {
                  onSwitchChanged(!kitchenRoomSwitchValue, false, true, false);
                },
                switchValue: kitchenRoomSwitchValue,
              );
            case 2:
              return BedRoomControlWidget(
                brightnessValue: bedRoomBrightnessValue,
                onBrightnessChanged: (value) async {
                  if (mounted) {
                    setState(() {
                      bedRoomBrightnessValue = value;
                      _saveBrightnessValue(value, 'bedRoom');
                    });
                  }
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
                alarmLedTimeValue: alarmLedTimeValue,
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
