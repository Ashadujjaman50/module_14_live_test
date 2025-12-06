import 'package:flutter/material.dart';

import 'home.dart';

class RecipeDetailScreen extends StatelessWidget {
  final Recipe recipe;

  const RecipeDetailScreen({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recipe.title, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              recipe.description,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),

            const Text(
              "Ingredients:",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            ...recipe.ingredients.map(
                  (item) => Text("- $item", style: const TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}
