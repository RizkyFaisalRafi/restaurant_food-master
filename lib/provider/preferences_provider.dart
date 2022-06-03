import 'package:flutter/material.dart';
import 'package:restaurant_food/preferences/preferences_helper.dart';

class PreferencesProvider extends ChangeNotifier {
  PreferencesHelper preferencesHelper;

  PreferencesProvider({required this.preferencesHelper}) {
    _getReminderPreferences();
  }

  bool _isReminderActive = false;

  bool get isReminderActive => _isReminderActive;

  void _getReminderPreferences() async {
    _isReminderActive = await preferencesHelper.isReminderActivate;
    notifyListeners();
  }

  void enableReminderPreferences(bool value) {
    preferencesHelper.setReminder(value);
    _getReminderPreferences();
  }
}
