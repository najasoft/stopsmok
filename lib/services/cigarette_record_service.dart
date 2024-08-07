import 'package:cloud_firestore/cloud_firestore.dart' as firestore;
import 'package:stopsmok/models/cigarette_model.dart';
import 'package:stopsmok/models/settings_model.dart' as model;
import 'package:uuid/uuid.dart';
import 'package:stopsmok/services/settings_service.dart';

class CigaretteRecordService {
  final firestore.FirebaseFirestore _firestore =
      firestore.FirebaseFirestore.instance;
  final String collectionName = 'cigarettes';
  final SettingsService _settingsService = SettingsService();
  final Uuid _uuid = Uuid();

  Future<void> addCigaretteRecord(String userId) async {
    // Récupérer les paramètres utilisateur
    model.Settings? settings = await _settingsService.getSettings(userId);
    double price = settings?.pricePerCigarette ?? 0.0;

    // Créer un nouvel enregistrement de cigarette
    CigaretteRecord newRecord = CigaretteRecord(
      id: _uuid.v4(),
      userId: userId,
      time: DateTime.now(),
      price: price,
    );

    // Ajouter l'enregistrement à Firestore
    await _firestore
        .collection(collectionName)
        .doc(newRecord.id)
        .set(newRecord.toMap());
  }

  Future<List<CigaretteRecord>> getCigaretteRecords(String userId) async {
    firestore.QuerySnapshot snapshot = await _firestore
        .collection(collectionName)
        .where('userId', isEqualTo: userId)
        .get();

    return snapshot.docs
        .map((doc) =>
            CigaretteRecord.fromMap(doc.data() as Map<String, dynamic>, doc.id))
        .toList();
  }
}
