import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/favorites_provider.dart';
import 'meal_detail_screen.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<FavoritesProvider>(context, listen: false)
            .loadFavorites());
  }

  @override
  Widget build(BuildContext context) {
    final favorites = Provider.of<FavoritesProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Favorites')),
      body: favorites.loading
          ? const Center(child: CircularProgressIndicator())
          : favorites.favorites.isEmpty
          ? const Center(child: Text('No favorites yet'))
          : ListView.separated(
        itemCount: favorites.favorites.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final m = favorites.favorites[index];
          return ListTile(
            leading: Image.network(m.thumbnail, width: 56, fit: BoxFit.cover),
            title: Text(m.name, maxLines: 1, overflow: TextOverflow.ellipsis),
            trailing: IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () => favorites.removeFavorite(m.id),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => MealDetailScreen(mealId: m.id),
                ),
              );
            },
          );
        },
      ),
    );
  }
}