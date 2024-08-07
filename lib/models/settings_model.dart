class Settings {
  String userId;
  int interval; // Intervalle entre les cigarettes en minutes
  int dailyLimit; // Limite quotidienne de cigarettes
  double pricePerCigarette; // Prix par cigarette

  Settings({
    required this.userId,
    this.interval = 60,
    this.dailyLimit = 10,
    this.pricePerCigarette = 0.0,
  });

  // Méthode pour convertir un objet Settings en un Map pour Firestore
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'interval': interval,
      'dailyLimit': dailyLimit,
      'pricePerCigarette': pricePerCigarette,
    };
  }

  // Méthode pour créer un objet Settings à partir d'un DocumentSnapshot
  factory Settings.fromMap(Map<String, dynamic> map, String documentId) {
    return Settings(
      userId: documentId,
      interval: map['interval'] ?? 60,
      dailyLimit: map['dailyLimit'] ?? 10,
      pricePerCigarette: map['pricePerCigarette'] ?? 0.0,
    );
  }
}