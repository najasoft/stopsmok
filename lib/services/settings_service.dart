import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stopsmok/models/settings_model.dart' as model;

class SettingsService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String collectionName = 'settings';

  Future<void> updateSettings(model.Settings settings) async {
    await _firestore
        .collection(collectionName)
        .doc(settings.userId)
        .set(settings.toMap());
  }

  Future<model.Settings?> getSettings(String userId) async {
    DocumentSnapshot doc =
        await _firestore.collection(collectionName).doc(userId).get();
    if (doc.exists) {
      return model.Settings.fromMap(doc.data() as Map<String, dynamic>, doc.id);
    }
    return null;
  }
}
