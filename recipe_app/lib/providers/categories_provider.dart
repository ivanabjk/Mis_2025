import 'package:flutter/material.dart';
import '../models/category.dart';
import '../repositories/meal_repository.dart';

class CategoriesProvider extends ChangeNotifier {
  final MealRepository _repo = MealRepository();
  List<Category> _categories = [];
  List<Category> get categories => _categories;

  bool _loading = false;
  bool get loading => _loading;

  Future<void> loadCategories() async {
    _loading = true;
    notifyListeners();
    _categories = await _repo.fetchCategories();
    _loading = false;
    notifyListeners();
  }

  List<Category> search(String query) {
    if (query.isEmpty) return _categories;
    return _categories
        .where((c) => c.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}