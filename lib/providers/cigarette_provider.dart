import 'package:flutter_riverpod/flutter_riverpod.dart';

class CigaretteState {
  final Duration interval;
  final int dailyLimit;
  final double pricePerCigarette;

  CigaretteState({
    required this.interval,
    required this.dailyLimit,
    required this.pricePerCigarette,
  });

  // Method to copy the current state with new values
  CigaretteState copyWith({
    Duration? interval,
    int? dailyLimit,
    double? pricePerCigarette,
  }) {
    return CigaretteState(
      interval: interval ?? this.interval,
      dailyLimit: dailyLimit ?? this.dailyLimit,
      pricePerCigarette: pricePerCigarette ?? this.pricePerCigarette,
    );
  }
}

class CigaretteNotifier extends StateNotifier<CigaretteState> {
  CigaretteNotifier()
      : super(CigaretteState(
          interval: Duration(minutes: 60),
          dailyLimit: 10,
          pricePerCigarette: 1.0,
        ));

  void setInterval(Duration newInterval) {
    state = state.copyWith(interval: newInterval);
  }

  void setDailyLimit(int newLimit) {
    state = state.copyWith(dailyLimit: newLimit);
  }

  void setPricePerCigarette(double newPrice) {
    state = state.copyWith(pricePerCigarette: newPrice);
  }
}

final cigaretteProvider =
    StateNotifierProvider<CigaretteNotifier, CigaretteState>((ref) {
  return CigaretteNotifier();
});
