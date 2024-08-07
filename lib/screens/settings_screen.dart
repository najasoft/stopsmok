import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cigarette_provider.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late TextEditingController _intervalController;
  late TextEditingController _dailyLimitController;

  @override
  void initState() {
    super.initState();

    // Utilisez addPostFrameCallback pour garantir que le context est complètement initialisé
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final cigaretteProvider =
          Provider.of<CigaretteProvider>(context, listen: false);
      _intervalController = TextEditingController(
          text: cigaretteProvider.interval.inMinutes.toString());
      _dailyLimitController =
          TextEditingController(text: cigaretteProvider.dailyLimit.toString());
    });
  }

  @override
  void dispose() {
    _intervalController.dispose();
    _dailyLimitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cigaretteProvider = Provider.of<CigaretteProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _intervalController,
              decoration: InputDecoration(labelText: 'Interval (minutes)'),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                if (value.isNotEmpty) {
                  final interval = int.tryParse(value);
                  if (interval != null) {
                    cigaretteProvider.setInterval(Duration(minutes: interval));
                  }
                }
              },
            ),
            TextField(
              controller: _dailyLimitController,
              decoration: InputDecoration(labelText: 'Daily Limit'),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                if (value.isNotEmpty) {
                  final limit = int.tryParse(value);
                  if (limit != null) {
                    cigaretteProvider.setDailyLimit(limit);
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
