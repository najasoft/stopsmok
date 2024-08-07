import 'package:flutter/material.dart';

class CigaretteProvider with ChangeNotifier {
  Duration _interval = Duration(minutes: 60);
  int _dailyLimit = 10;
  double _pricePerCigarette = 1.0; // Exemple de prix par cigarette

  Duration get interval => _interval;
  int get dailyLimit => _dailyLimit;
  double get pricePerCigarette => _pricePerCigarette;

  void setInterval(Duration newInterval) {
    _interval = newInterval;
    notifyListeners();
  }

  void setDailyLimit(int newLimit) {
    _dailyLimit = newLimit;
    notifyListeners();
  }

  void setPricePerCigarette(double newPrice) {
    _pricePerCigarette = newPrice;
    notifyListeners();
  }
}
