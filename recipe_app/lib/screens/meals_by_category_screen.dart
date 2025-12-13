import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/providers/favorites_provider.dart';
import '../providers/meals_provider.dart';
import '../providers/random_recipe_provider.dart';
import '../widgets/meal_card.dart';
import '../widgets/search_bar.dart';
import 'meal_detail_screen.dart';

class MealsByCategoryScreen extends StatefulWidget {
  final String categoryName;
  const MealsByCategoryScreen({super.key, required this.categoryName});

  @override
  State<MealsByCategoryScreen> createState() => _MealsByCategoryScreenState();
}

class _MealsByCategoryScreenState extends State<MealsByCategoryScreen> {
  String _searchQuery = '';
  List<dynamic> _searchResults = [];

  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<MealsProvider>(context, listen: false)
            .loadMeals(widget.categoryName));
    Future.microtask(() =>
        Provider.of<FavoritesProvider>(context, listen: false).loadFavorites());
  }

  Future<void> _performSearch(String query) async {
    setState(() => _searchQuery = query);
    if (query.isEmpty) {
      setState(() => _searchResults = []);
      return;
    }
    final provider = Provider.of<MealsProvider>(context, listen: false);
    final results = await provider.searchMeals(query, widget.categoryName);
    setState(() => _searchResults = results);
  }

  @override
  Widget build(BuildContext context) {
    final mealsProvider = Provider.of<MealsProvider>(context);
    final favoritesProvider = Provider.of<FavoritesProvider>(context);
    final meals = _searchQuery.isEmpty ? mealsProvider.meals : _searchResults;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoryName),
        actions: [
          IconButton(
            icon: const Icon(Icons.shuffle),
            onPressed: () async {
              final randomProvider = Provider.of<RandomRecipeProvider>(context, listen: false);
              await randomProvider.loadRandomMeal();
              final meal = randomProvider.meal;
              if (meal != null && context.mounted) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => MealDetailScreen(mealId: meal.id),
                  ),
                );
              }
            },
          ),
        ],
      ),
      body: mealsProvider.loading
          ? const Center(child: CircularProgressIndicator())
          : Column(
        children: [
          AppSearchBar(
            hint: 'Search meals...',
            onChanged: _performSearch,
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // 2 columns
                childAspectRatio: 0.75,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: meals.length,
              itemBuilder: (context, index) {
                final meal = meals[index];
                final isFav = favoritesProvider.isFavorite(meal.id);

                return MealCard(
                  name: meal.name,
                  imageUrl: meal.thumbnail,
                  isFavorite: isFav,
                  onFavoriteToggle: () async{
                    await favoritesProvider.toggleFavorite(meal);
                    if (mounted) setState(() {});
                  },
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => MealDetailScreen(mealId: meal.id),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}