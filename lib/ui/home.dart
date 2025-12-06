import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class RecipeListScreen extends StatefulWidget {
  const RecipeListScreen({super.key});

  @override
  State<RecipeListScreen> createState() => _RecipeListScreenState();
}

class _RecipeListScreenState extends State<RecipeListScreen> {
  late Future<List<Recipe>> recipeFuture;

  @override
  void initState() {
    super.initState();
    recipeFuture = loadRecipes();
  }

  Future<List<Recipe>> loadRecipes() async {
    final jsonString =
    await rootBundle.loadString("assets/recipes.json");
    final jsonData = jsonDecode(jsonString);

    return parseRecipes(jsonData);
  }

  List<Recipe> parseRecipes(Map<String, dynamic> jsonData) {
    final list = jsonData["recipes"] as List;
    return list.map((item) => Recipe.fromJson(item)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Food Recipes", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
        backgroundColor: Colors.blue,
      ),
      body: FutureBuilder<List<Recipe>>(
        future: recipeFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text("Error loading recipes"));
          }

          final recipes = snapshot.data ?? [];

          return ListView.builder(
            itemCount: recipes.length,
            itemBuilder: (context, index) {
              final recipe = recipes[index];

              return Container(
                margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.orange.shade100,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.restaurant_menu,
                      color: Colors.orange,
                      size: 26,
                    ),
                  ),

                  title: Text(
                    recipe.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(recipe.description),
                ),
              );

            },
          );
        },
      ),
    );
  }
}


class Recipe {
  final String title;
  final String description;
  final List<String> ingredients;

  Recipe({
    required this.title,
    required this.description,
    required this.ingredients,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      title: json["title"] ?? "",
      description: json["description"] ?? "",
      ingredients: List<String>.from(json["ingredients"] ?? []),
    );
  }
}
