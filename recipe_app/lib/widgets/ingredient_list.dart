import 'package:flutter/material.dart';

class IngredientList extends StatelessWidget {
  final List<Map<String, String>> ingredients; // [{measure: '1 cup', ingredient: 'Flour'}, ...]
  const IngredientList({super.key, required this.ingredients});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: ingredients.map((e) {
        final measure = e['measure'] ?? '';
        final ing = e['ingredient'] ?? '';
        return ListTile(
          dense: true,
          title: Text('$measure • $ing'),
        );
      }).toList(),
    );
  }
}