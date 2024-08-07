import 'package:flutter/material.dart';
import 'package:stopsmok/screens/settings_screen.dart';
import 'package:stopsmok/services/cigarette_record_service.dart';
import 'package:stopsmok/models/user_model.dart';
import 'package:stopsmok/services/settings_service.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  final User user;

  HomeScreen({required this.user});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CigaretteRecordService _cigaretteRecordService =
      CigaretteRecordService();
  final SettingsService _settingsService = SettingsService();
  int _dailyCigaretteCount = 0;
  int _totalCigaretteCount = 0;
  DateTime? _lastCigaretteTime;
  Duration? _interval;
  double _price = CigaretteRecordService.defaultPrice;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final userId = widget.user.id;
    _dailyCigaretteCount =
        await _cigaretteRecordService.getTodayCigaretteCount(userId);
    final settings = await _settingsService.getSettings(userId);
    if (settings != null) {
      setState(() {
        _lastCigaretteTime = settings.lastCigaretteTime;
        _interval = Duration(minutes: settings.interval);
        _price = settings.pricePerCigarette;
      });
    }
    // Load total cigarette count if needed.
  }

  void _onAddCigarette() async {
    await _cigaretteRecordService.addCigaretteRecord(widget.user.id);
    setState(() {
      _dailyCigaretteCount++;
      _lastCigaretteTime = DateTime.now();
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildInfoCard(String title, String value) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        leading: Icon(Icons.info, color: Colors.blueAccent),
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(value),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final canAddCigarette = _lastCigaretteTime == null ||
        now.difference(_lastCigaretteTime!) > (_interval ?? Duration(hours: 1));

    List<Widget> _pages = [
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: canAddCigarette ? Colors.green : Colors.grey,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                textStyle: TextStyle(fontSize: 18),
              ),
              onPressed: canAddCigarette ? _onAddCigarette : null,
              child: Text(canAddCigarette
                  ? 'Add Cigarette'
                  : 'You must wait before adding another cigarette'),
            ),
            SizedBox(height: 20),
            _buildInfoCard('Cigarettes today', '$_dailyCigaretteCount'),
            if (_lastCigaretteTime != null)
              _buildInfoCard('Last cigarette time',
                  DateFormat('yyyy-MM-dd – HH:mm').format(_lastCigaretteTime!)),
            if (_interval != null)
              _buildInfoCard('Interval', '${_interval!.inMinutes} minutes'),
            _buildInfoCard('Price per cigarette', '\$$_price'),
            // Add more fields as needed...
          ],
        ),
      ),
      Center(child: Text('Statistics Screen (Under Development)')),
      Center(child: SettingsScreen(user: widget.user)),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Stop Smoke'),
        backgroundColor: Colors.blueAccent,
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Statistics',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blueAccent,
        onTap: _onItemTapped,
      ),
    );
  }
}
