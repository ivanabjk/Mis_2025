import 'package:flutter/material.dart';
import '../models/meal_summary.dart';
import '../repositories/favorites_repository.dart';

class FavoritesProvider extends ChangeNotifier {
  final _repo = FavoritesRepository();
  final List<MealSummary> _favorites = [];
  bool _loading = false;

  List<MealSummary> get favorites => List.unmodifiable(_favorites);
  bool get loading => _loading;

  Future<void> loadFavorites() async {
    _loading = true;
    notifyListeners();
    final items = await _repo.getFavorites();
    _favorites
      ..clear()
      ..addAll(items);
    _loading = false;
    notifyListeners();
  }

  Future<void> addFavorite(MealSummary meal) async {
    await _repo.addFavorite(meal);
    if (!_favorites.any((m) => m.id == meal.id)) {
      _favorites.insert(0, meal);
      notifyListeners();
    }
  }

  Future<void> removeFavorite(String mealId) async {
    await _repo.removeFavorite(mealId);
    _favorites.removeWhere((m) => m.id == mealId);
    notifyListeners();
  }

  bool isFavorite(String mealId) {
    return _favorites.any((m) => m.id == mealId);
  }

  Future<void> toggleFavorite(MealSummary meal) async {
    if (isFavorite(meal.id)) {
      await removeFavorite(meal.id);
    } else {
      await addFavorite(meal);
    }
  }
}