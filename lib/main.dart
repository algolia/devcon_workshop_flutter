import 'package:algolia_devcon_workshop/provided/app_theme.dart';
import 'package:algolia_devcon_workshop/suggestions_repository.dart';
import 'package:flutter/material.dart';
import 'package:algolia_devcon_workshop/home_page.dart';
import 'package:provider/provider.dart';
import 'product_repository.dart';

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
