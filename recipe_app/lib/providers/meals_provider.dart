import 'package:flutter/material.dart';
import '../models/meal_summary.dart';
import '../models/meal_detail.dart';
import '../repositories/meal_repository.dart';

class MealsProvider extends ChangeNotifier {
  final MealRepository _repo = MealRepository();
  List<MealSummary> _meals = [];
  List<MealSummary> get meals => _meals;

  bool _loading = false;
  bool get loading => _loading;

  Future<void> loadMeals(String category) async {
    _loading = true;
    notifyListeners();
    _meals = await _repo.fetchMealsByCategory(category);
    _loading = false;
    notifyListeners();
  }

  Future<List<MealDetail>> searchMeals(String query, String category) async {
    final results = await _repo.searchMeals(query);
    return results.where((m) => m.category == category).toList();
  }
}