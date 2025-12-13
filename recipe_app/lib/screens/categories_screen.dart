import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/widgets/my_drawer.dart';
import '../providers/categories_provider.dart';
import '../providers/random_recipe_provider.dart';
import '../widgets/category_card.dart';
import '../widgets/search_bar.dart';
import 'meal_detail_screen.dart';
import 'meals_by_category_screen.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<CategoriesProvider>(context, listen: false).loadCategories());
  }

  @override
  Widget build(BuildContext context) {
    final categoriesProvider = Provider.of<CategoriesProvider>(context);
    final randomProvider = Provider.of<RandomRecipeProvider>(context);

    final categories = categoriesProvider.search(_searchQuery);
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Menu'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.shuffle),
            onPressed: () async {
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
      drawer: MyDrawer(),
      body: categoriesProvider.loading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Intro text
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35.0, vertical: 12),
              child: Text(
                "Select your favorite food category.",
                style: TextStyle(fontSize: 18),
              ),
            ),

            // Search bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: AppSearchBar(
                hint: 'Search categories...',
                onChanged: (value) {
                  setState(() => _searchQuery = value);
                },
              ),
            ),
            const SizedBox(height: 16),

            // Horizontal scrollable cards (take remaining space)
            SizedBox(
              height: screenHeight * 0.6,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemCount: categories.length,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemBuilder: (context, index) {
                  final c = categories[index];
                  return SizedBox(
                    width: screenWidth * 0.85,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: CategoryCard(
                        name: c.name,
                        imageUrl: c.thumbnail,
                        description: c.description,
                        height: screenHeight * 0.6, // reduced height
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => MealsByCategoryScreen(
                                  categoryName: c.name),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            ),


          ],
        ),
      ),
    );
  }
}