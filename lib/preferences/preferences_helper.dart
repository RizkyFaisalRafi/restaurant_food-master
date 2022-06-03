import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper{
  final Future<SharedPreferences> sharedPreference;

  PreferencesHelper({required this.sharedPreference});

  static const restaurantAlarm = "reminder";

  Future<bool> get isReminderActivate async{
    final prefs = await sharedPreference;
    return prefs.getBool(restaurantAlarm) ?? false;
  }

  void setReminder(bool value) async{
    final prefs = await sharedPreference;
    prefs.setBool(restaurantAlarm, value);
  }
}