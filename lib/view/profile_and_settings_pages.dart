import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_food/provider/preferences_provider.dart';
import 'package:restaurant_food/provider/reminder_provider.dart';

class ProfileAndSettingsPage extends StatefulWidget {
  const ProfileAndSettingsPage({Key? key}) : super(key: key);

  @override
  State<ProfileAndSettingsPage> createState() => _ProfileAndSettingsPageState();
}

class _ProfileAndSettingsPageState extends State<ProfileAndSettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<PreferencesProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                      left: 16, right: 16, top: 150, bottom: 8),
                  child: Center(
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.asset(
                            'assets/image.jpg',
                            width: 200,
                            height: 200,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Text(
                          "Rifara",
                          style: GoogleFonts.eczar(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Material(
                    child: ListTile(
                      title: const Text('Jadwalkan Pengingat'),
                      trailing: Consumer<ReminderProvider>(
                        builder: (context, scheduled, _) {
                          return Switch.adaptive(
                            value: provider.isReminderActive,
                            onChanged: (value) async {
                              scheduled.scheduledReminder(value);
                              provider.enableReminderPreferences(value);
                            },
                          );
                        },
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
