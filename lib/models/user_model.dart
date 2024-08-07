class User {
  String id;
  String email;
  String displayName;
  String? photoUrl;
  DateTime? birthday;

  User({
    required this.id,
    required this.email,
    required this.displayName,
    this.photoUrl,
    this.birthday,
  });

  // Méthode pour convertir un objet User en un Map pour Firestore
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'displayName': displayName,
      'photoUrl': photoUrl,
      'birthday': birthday?.toIso8601String(),
    };
  }

  // Méthode pour créer un objet User à partir d'un DocumentSnapshot
  factory User.fromMap(Map<String, dynamic> map, String documentId) {
    return User(
      id: documentId,
      email: map['email'],
      displayName: map['displayName'],
      photoUrl: map['photoUrl'],
      birthday:
          map['birthday'] != null ? DateTime.parse(map['birthday']) : null,
    );
  }
}
