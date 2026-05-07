import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/user_preferences.dart';

class UserService {
  static final UserService _instance = UserService._internal();
  factory UserService() => _instance;
  UserService._internal();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  String? get _uid => FirebaseAuth.instance.currentUser?.uid;

  DocumentReference? get _profileDoc {
    final uid = _uid;
    if (uid == null) return null;
    return _db.collection('users').doc(uid).collection('data').doc('profile');
  }

  Future<void> saveProfile(UserPreferences prefs) async {
    final doc = _profileDoc;
    if (doc == null) return;
    await doc.set({
      'goal': prefs.goal?.name,
      'age': prefs.age,
      'weight': prefs.weight,
      'height': prefs.height,
      'fitnessLevel': prefs.fitnessLevel?.name,
      'weightUnit': prefs.weightUnit.name,
      'heightUnit': prefs.heightUnit.name,
      'updatedAt': DateTime.now().toIso8601String(),
    });
  }

  Future<UserPreferences?> loadProfile() async {
    final doc = _profileDoc;
    if (doc == null) return null;
    try {
      final snap = await doc.get();
      if (!snap.exists) return null;
      final data = snap.data() as Map<String, dynamic>;
      return UserPreferences(
        goal: data['goal'] != null
            ? FitnessGoal.values.firstWhere(
                (e) => e.name == data['goal'],
                orElse: () => FitnessGoal.general,
              )
            : null,
        age: data['age'] as int?,
        weight: (data['weight'] as num?)?.toDouble(),
        height: (data['height'] as num?)?.toDouble(),
        fitnessLevel: data['fitnessLevel'] != null
            ? FitnessLevel.values.firstWhere(
                (e) => e.name == data['fitnessLevel'],
                orElse: () => FitnessLevel.beginner,
              )
            : null,
        weightUnit: data['weightUnit'] != null
            ? WeightUnit.values.firstWhere(
                (e) => e.name == data['weightUnit'],
                orElse: () => WeightUnit.kg,
              )
            : WeightUnit.kg,
        heightUnit: data['heightUnit'] != null
            ? HeightUnit.values.firstWhere(
                (e) => e.name == data['heightUnit'],
                orElse: () => HeightUnit.cm,
              )
            : HeightUnit.cm,
      );
    } catch (_) {
      return null;
    }
  }

  Future<void> deleteProfile() async {
    final doc = _profileDoc;
    if (doc == null) return;
    try {
      await doc.delete();
    } catch (_) {}
  }
}
