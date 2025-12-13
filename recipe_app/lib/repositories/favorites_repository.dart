import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/meal_summary.dart';

class FavoritesRepository {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  String get _uid => _auth.currentUser!.uid;

  CollectionReference<Map<String, dynamic>> get _favoritesRef =>
      _firestore.collection('users').doc(_uid).collection('favorites');

  Future<void> addFavorite(MealSummary meal) async {
    await _favoritesRef.doc(meal.id).set({
      'id': meal.id,
      'name': meal.name,
      'thumbnail': meal.thumbnail,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> removeFavorite(String mealId) async {
    await _favoritesRef.doc(mealId).delete();
  }

  Future<bool> isFavorite(String mealId) async {
    final doc = await _favoritesRef.doc(mealId).get();
    return doc.exists;
  }

  Future<List<MealSummary>> getFavorites() async {
    final snapshot = await _favoritesRef.orderBy('createdAt', descending: true).get();
    return snapshot.docs.map((doc) {
      final data = doc.data();
      return MealSummary(
        id: data['id'] ?? '',
        name: data['name'] ?? '',
        thumbnail: data['thumbnail'] ?? '',
      );
    }).toList();
  }
}