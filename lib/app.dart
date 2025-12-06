import 'package:flutter/material.dart';
import 'package:module_14_live_test/ui/home.dart';

class JsonToListViewApp extends StatelessWidget {
  const JsonToListViewApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Json -to- Listview',
      home: RecipeListScreen(),
    );
  }
}
