import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/auth/auth_gate.dart';
import 'package:recipe_app/providers/categories_provider.dart';
import 'package:recipe_app/providers/favorites_provider.dart';
import 'package:recipe_app/providers/meal_detail_provider.dart';
import 'package:recipe_app/providers/meals_provider.dart';
import 'package:recipe_app/providers/random_recipe_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:recipe_app/services/notification_api.dart';
import 'firebase_options.dart';

final navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await NotificationApi().initNotifications();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CategoriesProvider()),
        ChangeNotifierProvider(create: (_) => MealsProvider()),
        ChangeNotifierProvider(create: (_) => MealDetailProvider()),
        ChangeNotifierProvider(create: (_) => RandomRecipeProvider()),
        ChangeNotifierProvider(create: (_) => FavoritesProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthGate(),
      navigatorKey: navigatorKey,
    );
  }
}
