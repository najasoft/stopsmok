class CigaretteRecord {
  String id;
  String userId;
  DateTime time;
  double price;

  // Constructeur avec un paramètre différent pour éviter le conflit
  CigaretteRecord({
    required this.id,
    required this.userId,
    required this.time,
    required this.price,
  });

  // Méthode pour convertir un objet CigaretteRecord en un Map pour Firestore
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'time': time.toIso8601String(),
      'price': price,
    };
  }

  // Méthode pour créer un objet CigaretteRecord à partir d'un DocumentSnapshot
  factory CigaretteRecord.fromMap(Map<String, dynamic> map, String documentId) {
    return CigaretteRecord(
      id: documentId,
      userId: map['userId'],
      time: DateTime.parse(map['time']),
      price: map['price'],
    );
  }
}
