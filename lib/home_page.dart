import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app_bar_view.dart';
import 'home_banner_view.dart';
import 'product.dart';
import 'product_card_view.dart';
import 'product_repository.dart';
import 'products_view.dart';
import 'search_autocomplete.dart';
import 'search_panel.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _presentAutoComplete(BuildContext context) =>
      Navigator.of(context).push(PageRouteBuilder(
        pageBuilder: (_, __, ___) => const SearchAutocomplete(),
        fullscreenDialog: true,
      ));

  Widget productsView(String title, Stream<List<Product>> productsStream) =>
      ProductsView(
          title: title,
          productsStream: productsStream,
          productWidget: (context, product) =>
              ProductCardView(product: product));

  @override
  Widget build(BuildContext context) {
    final productRepository = context.read<ProductRepository>();
    return Scaffold(
      appBar: AlgoliaAppBar(
        bottom: SearchPanel(
          onSearch: () {
            _presentAutoComplete(context);
          },
        ),
      ),
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const HomeBannerView(),
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
                child: Column(
                  children: [
                    productsView(
                        'New in Shoes', productRepository.getShoesProducts()),
                    productsView('Spring/Summer 2021',
                        productRepository.getSeasonalProducts()),
                  ],
                ),
              ),
            ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
