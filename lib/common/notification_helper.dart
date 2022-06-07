import 'dart:convert';
import 'dart:math';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:restaurant_food/common/navigation.dart';
import 'package:restaurant_food/models/restaurant.dart';
import 'package:rxdart/rxdart.dart';

final selectNotificationSubject = BehaviorSubject<String>();

class NotificationHelper{
  static NotificationHelper? _instance;

  NotificationHelper._internal(){
    _instance = this;
  }

  factory NotificationHelper() => _instance ?? NotificationHelper._internal();

  Future<void> initNotification(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async{
    var initializationSettingsAndroid = const AndroidInitializationSettings('app_icon');

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String? payload) async {
          if(payload != null){
            print('Notification payload: ' + payload);
          }
          selectNotificationSubject.add(payload ?? 'empty payload');
        }
    );
  }

  Future<void> showNotification(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
      RestaurantResult restaurant) async{
    var _channelId = "30";
    var _channelName = "restaurant_reminder";
    var _channelDescription = "this reminder for check restaurant";

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        _channelId,
        _channelName,
        _channelDescription,
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker',
        styleInformation: const DefaultStyleInformation(true, true)
    );

    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics
    );

    var randomIndex = Random().nextInt(restaurant.restaurants.length - 1);
    var randomRestaurantName = restaurant.restaurants[randomIndex].name;

    var titleNotification = "<b>$randomRestaurantName</b>";
    var titleRestaurant = "Ayo buka aplikasi restaurant sekarang";
    await flutterLocalNotificationsPlugin.show(
        0, titleNotification, titleRestaurant, platformChannelSpecifics,
        payload: json.encode(restaurant.toJson())
    );
  }

  void configureSelectNotificationSubject(String route){
    selectNotificationSubject.stream.listen((String payload) async {
      var data = RestaurantResult.fromJson(json.decode(payload));
      final random = Random();
      var randomizeRestaurant = random.nextInt(data.restaurants.length);
      var restaurant = data.restaurants[randomizeRestaurant];
      Navigation.intentWithData(route, restaurant);
    });
  }
}