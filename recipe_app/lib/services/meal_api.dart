import 'package:dio/dio.dart';
import 'api_client.dart';

class MealApi {
  final Dio _dio = ApiClient.dio;

  Future<Response> getCategories() {
    return _dio.get('categories.php');
  }

  Future<Response> getMealsByCategory(String category) {
    return _dio.get('filter.php', queryParameters: {'c': category});
  }

  Future<Response> searchMeals(String query) {
    return _dio.get('search.php', queryParameters: {'s': query});
  }

  Future<Response> getMealById(String id) {
    return _dio.get('lookup.php', queryParameters: {'i': id});
  }

  Future<Response> getRandomMeal() {
    return _dio.get('random.php');
  }
}