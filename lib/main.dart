import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app_theme.dart';
import 'home_page.dart';
import 'product_repository.dart';
import 'suggestions_repository.dart';

void main() {
  runApp(
    MultiProvider(providers: [
      Provider(create: (context) => ProductRepository()),
      Provider(create: (context) => SuggestionsRepository()),
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
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
