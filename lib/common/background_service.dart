import 'dart:isolate';
import 'dart:ui';

import 'package:restaurant_food/api/api_service.dart';
import 'package:restaurant_food/common/notification_helper.dart';
import 'package:restaurant_food/main.dart';

final ReceivePort port = ReceivePort();

class BackgroundService {
  static BackgroundService? _instance;
  static const String _isolateName = 'isolate';
  static SendPort? _uiSendPort;

  BackgroundService._internal(){
    _instance = this;
  }

  factory BackgroundService() => _instance ?? BackgroundService._internal();

  void initializeIsolateDate() {
    IsolateNameServer.registerPortWithName(port.sendPort, _isolateName);
  }

  static Future<void> callback() async {
    print('Alarm Fired!');
    final NotificationHelper _notificationHelper = NotificationHelper();
    var result = await ApiService().restaurantList();
    await _notificationHelper.showNotification(
        flutterLocalNotificationsPlugin, result);

    _uiSendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
    _uiSendPort?.send(null);
  }
}