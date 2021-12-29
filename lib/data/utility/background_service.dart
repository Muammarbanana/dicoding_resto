import 'dart:math';
import 'dart:ui';
import 'dart:isolate';

import 'package:flutter_resto_dicoding/data/api/api_service.dart';
import 'package:flutter_resto_dicoding/data/helper/notification_helper.dart';
import 'package:flutter_resto_dicoding/main.dart';

final ReceivePort port = ReceivePort();

class BackgroundService {
  static BackgroundService? _instance;
  static const String _isolateName = 'isolate';
  static SendPort? _uiSendPort;

  BackgroundService._internal() {
    _instance = this;
  }

  factory BackgroundService() => _instance ?? BackgroundService._internal();

  void initializeIsolate() {
    IsolateNameServer.registerPortWithName(
      port.sendPort,
      _isolateName,
    );
  }

  static Future<void> callback() async {
    final NotificationHelper _notificationHelper = NotificationHelper();
    // generate random index for random restaurant
    var restaurantData = await ApiService().fetchRestoList();
    var randomIndex = Random().nextInt(restaurantData.restaurants.length);

    var result = await ApiService()
        .fetchRestoDetail(restaurantData.restaurants[randomIndex].id);
    await _notificationHelper.showNotification(
        flutterLocalNotificationsPlugin, result.restaurant);

    _uiSendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
    _uiSendPort?.send(null);
  }
}
