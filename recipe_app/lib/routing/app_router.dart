import 'package:go_router/go_router.dart';
import '../screens/categories_screen.dart';
import '../screens/meals_by_category_screen.dart';
import '../screens/meal_detail_screen.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        name: 'categories',
        builder: (context, state) => const CategoriesScreen(),
      ),
      GoRoute(
        path: '/category/:name',
        name: 'meals_by_category',
        builder: (context, state) {
          final name = state.pathParameters['name']!;
          return MealsByCategoryScreen(categoryName: name);
        },
      ),
      GoRoute(
        path: '/meal/:id',
        name: 'meal_detail',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return MealDetailScreen(mealId: id);
        },
      ),
    ],
  );
}