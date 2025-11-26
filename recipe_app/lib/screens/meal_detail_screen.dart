import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/meal_detail_provider.dart';
import '../providers/random_recipe_provider.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MealDetailProvider>(context);
    final meal = provider.meal;

    return Scaffold(
      appBar: AppBar(
        title: Text("Recipe"),
        // actions: [
        //   IconButton(
        //     icon: const Icon(Icons.shuffle),
        //     onPressed: () async {
        //       final randomProvider = Provider.of<RandomRecipeProvider>(context, listen: false);
        //       await randomProvider.loadRandomMeal();
        //       final meal = randomProvider.meal;
        //       if (meal != null && context.mounted) {
        //         Navigator.push(
        //           context,
        //           MaterialPageRoute(
        //             builder: (_) => MealDetailScreen(mealId: meal.id),
        //           ),
        //         );
        //       }
        //     },
        //   ),
        // ],
      ),
      body: provider.loading
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