import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_resto_dicoding/data/utility/background_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SchedulingProvider extends ChangeNotifier {
  bool? _isScheduled;

  bool? get isScheduled => _isScheduled;

  SchedulingProvider() {
    getSwitchValue();
  }

  Future<void> getSwitchValue() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final switchValue = prefs.getBool('switchValue');
    if (switchValue == null) {
      _isScheduled = false;
      notifyListeners();
    } else {
      _isScheduled = switchValue;
      notifyListeners();
    }
  }

  Future<bool> scheduledRestaurant(bool value) async {
    _isScheduled = value;
    if (_isScheduled == true && _isScheduled != null) {
      notifyListeners();
      return await AndroidAlarmManager.periodic(
        const Duration(seconds: 5),
        1,
        BackgroundService.callback,
        startAt: DateTime.now(),
        exact: true,
        wakeup: true,
      );
    } else {
      notifyListeners();
      return await AndroidAlarmManager.cancel(1);
    }
  }
}
