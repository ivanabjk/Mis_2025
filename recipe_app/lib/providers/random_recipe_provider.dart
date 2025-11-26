import 'package:flutter/material.dart';
import '../models/meal_detail.dart';
import '../repositories/meal_repository.dart';

class RandomRecipeProvider extends ChangeNotifier {
  final MealRepository _repo = MealRepository();
  MealDetail? _meal;
  MealDetail? get meal => _meal;

  DateTime? _lastFetchedDate;

  bool _loading = false;
  bool get loading => _loading;

  Future<void> loadRandomMeal() async {
    final today = DateTime.now();

    // If we already have a meal for today, reuse it
    if (_meal != null &&
        _lastFetchedDate != null &&
        _lastFetchedDate!.year == today.year &&
        _lastFetchedDate!.month == today.month &&
        _lastFetchedDate!.day == today.day) {
      return; // keep the same meal
    }

    _loading = true;
    notifyListeners();

    // Fetch a new random meal
    _meal = await _repo.fetchRandomMeal();
    _lastFetchedDate = today;

    _loading = false;
    notifyListeners();

  }
}