import '../services/meal_api.dart';
import '../models/category.dart';
import '../models/meal_summary.dart';
import '../models/meal_detail.dart';

class MealRepository {
  final MealApi _api = MealApi();

  Future<List<Category>> fetchCategories() async {
    final response = await _api.getCategories();
    final List data = response.data['categories'] ?? [];
    return data.map((e) => Category.fromJson(e)).toList();
  }

  Future<List<MealSummary>> fetchMealsByCategory(String category) async {
    final response = await _api.getMealsByCategory(category);
    final List data = response.data['meals'] ?? [];
    return data.map((e) => MealSummary.fromJson(e)).toList();
  }

  Future<List<MealDetail>> searchMeals(String query) async {
    final response = await _api.searchMeals(query);
    final List data = response.data['meals'] ?? [];
    return data.map((e) => MealDetail.fromJson(e)).toList();
  }

  Future<MealDetail?> fetchMealById(String id) async {
    final response = await _api.getMealById(id);
    final List data = response.data['meals'] ?? [];
    if (data.isEmpty) return null;
    return MealDetail.fromJson(data.first);
  }

  Future<MealDetail?> fetchRandomMeal() async {
    final response = await _api.getRandomMeal();
    final List data = response.data['meals'] ?? [];
    if (data.isEmpty) return null;
    return MealDetail.fromJson(data.first);
  }
}