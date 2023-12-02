import 'package:firebase_database/firebase_database.dart';

class FirebaseService {
  late DatabaseReference _databaseReference;

  FirebaseService(String roomKey) {
    // ignore: deprecated_member_use
    _databaseReference = FirebaseDatabase.instance.reference().child(roomKey);
  }

  Future<void> updateSwitchStatus(bool status) async {
    try {
      await _databaseReference
          .child('light')
          .update({'status': status ? 'ON' : 'OFF'});
    } catch (error) {
      print('Error updating switch status: $error');
    }
  }

  Future<void> updateBrightness(double brightness) async {
    await _databaseReference.child('light').update({'brightness': brightness});
  }

  Future<void> updateAlarmTime(int time) async {
    await _databaseReference.child('alarmLed').update({'time': time});
  }

  Future<void> updateAlarmSpeed(int speed) async {
    await _databaseReference.child('alarmLed').update({'speed': speed});
  }
}
