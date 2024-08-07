import 'package:flutter/material.dart';
import 'package:stopsmok/services/cigarette_record_service.dart';
import 'package:stopsmok/models/user_model.dart';

class HomeScreen extends StatefulWidget {
  final User user;

  HomeScreen({required this.user});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CigaretteRecordService _cigaretteRecordService =
      CigaretteRecordService();

  // Autres champs et méthodes...

  void _onAddCigarette() async {
    await _cigaretteRecordService.addCigaretteRecord(widget.user.id);
    setState(() {
      // Mettre à jour l'état pour refléter les nouvelles données
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stop Smoke'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _onAddCigarette,
          child: Text('Add Cigarette'),
        ),
      ),
    );
  }
}
