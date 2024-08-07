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
  final Uuid _uuid = const Uuid();
  static const double defaultPrice = 34.5;

  Future<void> addCigaretteRecord(String userId) async {
    final now = DateTime.now();
    // Récupérer les paramètres utilisateur
    model.Settings? settings = await _settingsService.getSettings(userId);
    double price = settings?.pricePerCigarette ?? defaultPrice;

    // Créer un nouvel enregistrement de cigarette
    CigaretteRecord newRecord = CigaretteRecord(
      id: _uuid.v4(),
      userId: userId,
      time: now,
      price: price,
    );

    // Ajouter l'enregistrement à Firestore
    await _firestore
        .collection(collectionName)
        .doc(newRecord.id)
        .set(newRecord.toMap());

    // Mise à jour des paramètres utilisateur avec la nouvelle lastCigaretteTime
    if (settings != null) {
      settings.lastCigaretteTime = now;
      await _settingsService.updateSettings(settings);
    }
  }

  Future<int> getTodayCigaretteCount(String userId) async {
    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day);
    final endOfDay = DateTime(now.year, now.month, now.day, 23, 59, 59);

    final querySnapshot = await _firestore
        .collection('cigarettes')
        .where('userId', isEqualTo: userId)
        .where('time', isGreaterThanOrEqualTo: startOfDay.toIso8601String())
        .where('time', isLessThanOrEqualTo: endOfDay.toIso8601String())
        .get();

    return querySnapshot.docs.length;
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
