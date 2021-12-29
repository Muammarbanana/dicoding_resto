import 'dart:io';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_resto_dicoding/common/navigation.dart';
import 'package:flutter_resto_dicoding/data/helper/notification_helper.dart';
import 'package:flutter_resto_dicoding/data/utility/background_service.dart';
import 'package:flutter_resto_dicoding/presentation/pages/homepage.dart';
import 'package:flutter_resto_dicoding/presentation/pages/resto_detail.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _service = BackgroundService();
  _service.initializeIsolate();
  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  await _notificationHelper.initNotifications(flutterLocalNotificationsPlugin);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      routes: {
        RestoDetail.routeName: (context) {
          return RestoDetail(
            restoId: ModalRoute.of(context)?.settings.arguments as String,
          );
        }
      },
      title: 'RestoranKoe',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}
