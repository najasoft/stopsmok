import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

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

// Méthode pour convertir un utilisateur Firebase en un utilisateur du modèle
  factory User.fromFirebaseUser(firebase_auth.User firebaseUser) {
    return User(
      id: firebaseUser.uid,
      email: firebaseUser.email!,
      displayName: firebaseUser.displayName ?? '',
      photoUrl: firebaseUser.photoURL,
      // Vous pouvez ajouter d'autres champs si nécessaire
    );
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
