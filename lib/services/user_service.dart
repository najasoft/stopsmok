import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stopsmok/models/user_model.dart';

class UserService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String collectionName = 'users';

  Future<void> createUser(User user) async {
    await _firestore.collection(collectionName).doc(user.id).set(user.toMap());
  }

  Future<User?> getUser(String userId) async {
    DocumentSnapshot doc =
        await _firestore.collection(collectionName).doc(userId).get();
    if (doc.exists) {
      return User.fromMap(doc.data() as Map<String, dynamic>, doc.id);
    }
    return null;
  }

  Future<void> updateUser(User user) async {
    await _firestore
        .collection(collectionName)
        .doc(user.id)
        .update(user.toMap());
  }
}
