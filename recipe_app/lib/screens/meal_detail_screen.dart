import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/models/meal_summary.dart';
import '../providers/favorites_provider.dart';
import '../providers/meal_detail_provider.dart';
import '../widgets/ingredient_list.dart';
import 'package:url_launcher/url_launcher.dart';

class MealDetailScreen extends StatefulWidget {
  final String mealId;
  const MealDetailScreen({super.key, required this.mealId});

  @override
  State<MealDetailScreen> createState() => _MealDetailScreenState();
}

class _MealDetailScreenState extends State<MealDetailScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<MealDetailProvider>(context, listen: false)
            .loadMeal(widget.mealId));
    Future.microtask(() =>
        Provider.of<FavoritesProvider>(context, listen: false)
            .loadFavorites());

  }

  @override
  Widget build(BuildContext context) {
    final mealProvider = Provider.of<MealDetailProvider>(context);
    final favorites = Provider.of<FavoritesProvider>(context);

    final meal = mealProvider.meal;
    final isFav = meal != null && favorites.isFavorite(meal.id);

    return Scaffold(
      appBar: AppBar(
        title: Text("Recipe"),
        actions: [
          if (meal != null)
            IconButton(
              icon: Icon(
                isFav ? Icons.favorite : Icons.favorite_border,
                color: Colors.red,
              ),
              onPressed: () async {
                final summary = MealSummary(id: meal.id, name: meal.name, thumbnail: meal.thumbnail);
                await favorites.toggleFavorite(summary);
                if (mounted) setState(() {});
              },
            ),
        ],
      ),
      body: mealProvider.loading
          ? const Center(child: CircularProgressIndicator())
          : meal == null
          ? const Center(child: Text('Recipe not found'))
          : SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(meal.thumbnail),
            ),
            const SizedBox(height: 16),

            // Title
            Text(
              meal.name,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),

            // Category + Area
            Row(
              children: [
                Chip(label: Text(meal.category)),
                const SizedBox(width: 8),
                Chip(label: Text(meal.area)),
              ],
            ),
            const SizedBox(height: 16),

            // Instructions
            Text(
              'Instructions',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(meal.instructions),
            const SizedBox(height: 16),

            // Ingredients
            Text(
              'Ingredients',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            IngredientList(ingredients: meal.ingredients),
            const SizedBox(height: 16),

            // YouTube link
            if (meal.youtube.isNotEmpty)
              ElevatedButton.icon(
                icon: const Icon(Icons.play_circle_fill),
                label: const Text('Watch on YouTube'),
                onPressed: () async {
                  final uri = Uri.parse(meal.youtube);
                  if (await canLaunchUrl(uri)) {
                    await launchUrl(uri,
                        mode: LaunchMode.externalApplication);
                  }
                },
              ),
          ],
        ),
      ),
    );
  }
}