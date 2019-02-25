import 'package:flutter/material.dart';

import 'package:simple_recipes/ui/screens/login.dart';
import 'package:simple_recipes/ui/theme.dart';
import 'package:simple_recipes/ui/screens/home.dart';

class RecipesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Recipies',
      theme: buildTheme(),
      routes: {
        // If you're using navigation routes, Flutter needs a base route.
        // We're going to change this route once we're ready with
        // implementation of HomeScreen.
        '/': (context) => HomeScreen(),
        '/login': (context) => LoginScreen(),
      },
    );
  }
}
