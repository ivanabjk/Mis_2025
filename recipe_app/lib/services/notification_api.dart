import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/main.dart';
import 'package:recipe_app/providers/random_recipe_provider.dart';
import 'package:recipe_app/screens/meal_detail_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationApi {
  final _firebaseMessaging = FirebaseMessaging.instance;
  RemoteMessage? pendingMessage;

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();

    final fCMToken = await _firebaseMessaging.getToken();
    print('Token: $fCMToken');

    await _initPushNotifications();
  }

  void handleMessage(RemoteMessage? message) async {
    if (message == null) return;

    // Only act when data.route == random_recipe
    if (message.data['route'] == 'random_recipe') {
      pendingMessage = message;
      final ctx = navigatorKey.currentContext;
      // if (ctx == null) {
      //   Future.delayed(const Duration(milliseconds: 500), () {
      //     handleMessage(message);
      //   });
      //   return;
      // }
      //
      // final randomProvider = Provider.of<RandomRecipeProvider>(ctx, listen: false);
      // await randomProvider.loadRandomMeal();
      // final meal = randomProvider.meal;
      // if (meal == null) return;
      //
      // navigatorKey.currentState?.push(
      //   MaterialPageRoute(builder: (_) => MealDetailScreen(mealId: meal.id)),
      // );
      return;
    }

    // Otherwise do nothing (or keep your old fallback if desired)
    // navigatorKey.currentState?.pushNamed('/notification_screen', arguments: message);
  }

  Future<void> _initPushNotifications() async {
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
  }
}