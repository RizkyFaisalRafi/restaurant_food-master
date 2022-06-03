import 'dart:io';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_food/common/background_service.dart';
import 'package:restaurant_food/common/notification_helper.dart';
import 'package:restaurant_food/db/database_helper.dart';
import 'package:restaurant_food/preferences/preferences_helper.dart';
import 'package:restaurant_food/provider/database_provider.dart';
import 'package:restaurant_food/provider/preferences_provider.dart';
import 'package:restaurant_food/provider/reminder_provider.dart';
import 'package:restaurant_food/provider/restaurant_list_provider.dart';
import 'package:restaurant_food/styles/styles.dart';
import 'package:restaurant_food/view/detail_restaurant_page.dart';
import 'package:restaurant_food/view/home_page.dart';
import 'package:restaurant_food/view/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'models/restaurant.dart';


final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _service = BackgroundService();

  _service.initializeIsolateDate();

  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  await _notificationHelper.initNotification(flutterLocalNotificationsPlugin);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: secondaryColor));
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<RestaurantListProvider>(create: (_) => RestaurantListProvider()),
        ChangeNotifierProvider<ReminderProvider>(
          create: (_) => ReminderProvider(),
        ),
        ChangeNotifierProvider<PreferencesProvider>(
            create: (_) => PreferencesProvider(
                preferencesHelper: PreferencesHelper(
                    sharedPreference: SharedPreferences.getInstance()
                )
            )
        ),
        ChangeNotifierProvider<DatabaseProvider>(
            create: (_) => DatabaseProvider(databaseHelper: DatabaseHelper())
        )
      ],
      child: MaterialApp(
        title: 'Restaurant App',
        theme: ThemeData(
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
              selectedItemColor: secondaryColor,
              unselectedItemColor: Colors.grey),
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: SplashScreen.routeName,
        routes: {
          SplashScreen.routeName: (context) => const SplashScreen(),
          HomePage.routeName: (context) => const HomePage(),
          RestaurantDetailPage.routeName: (context) => RestaurantDetailPage(
              restaurant:
              ModalRoute.of(context)?.settings.arguments as RestaurantList)
        },
      ),
    );
  }
}
