import 'package:algolia_devcon_workshop/data/search_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'ui/app_theme.dart';
import 'ui/home_screen.dart';
import 'data/products_repository.dart';
import 'data/suggestions_repository.dart';

void main() {
  runApp(
    MultiProvider(providers: [
      Provider(create: (context) => ProductsRepository()),
      Provider(create: (context) => SuggestionsRepository()),
      Provider(create: (context) => SearchRepository()),
    ], child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.buildLightTheme(),
      home: const HomeScreen(),
    );
  }
}
