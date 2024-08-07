import 'package:flutter/material.dart';
import 'package:stopsmok/models/settings_model.dart';
import 'package:stopsmok/services/settings_service.dart';
import 'package:intl/intl.dart';
import 'package:stopsmok/models/user_model.dart';

// Page des paramètres
class SettingsScreen extends StatelessWidget {
  final SettingsService _settingsService = SettingsService();
  final User user; // Use User instead of userId

  SettingsScreen({required this.user});

  Future<Settings?> _fetchSettings() async {
    return await _settingsService
        .getSettings(user.id); // Use user.id to fetch settings
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Settings?>(
      future: _fetchSettings(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData) {
          return Center(child: Text('No settings found'));
        }

        final settings = snapshot.data!;
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Settings',
                  style: Theme.of(context).textTheme.headlineSmall),
              SizedBox(height: 20),
              Text('Interval: ${settings.interval} minutes'),
              SizedBox(height: 10),
              Text('Price per cigarette: \$${settings.pricePerCigarette}'),
              SizedBox(height: 10),
              Text(
                  'Last cigarette time: ${settings.lastCigaretteTime != null ? DateFormat('yyyy-MM-dd – HH:mm').format(settings.lastCigaretteTime!) : 'N/A'}'),
              // Add more settings details as needed
            ],
          ),
        );
      },
    );
  }
}
