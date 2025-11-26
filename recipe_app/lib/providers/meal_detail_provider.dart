import 'package:flutter/material.dart';
import '../models/meal_detail.dart';
import '../repositories/meal_repository.dart';

class MealDetailProvider extends ChangeNotifier {
  final MealRepository _repo = MealRepository();
  MealDetail? _meal;
  MealDetail? get meal => _meal;

  bool _loading = false;
  bool get loading => _loading;

  Future<void> loadMeal(String id) async {
    _loading = true;
    notifyListeners();
    _meal = await _repo.fetchMealById(id);
    _loading = false;
    notifyListeners();
  }
}