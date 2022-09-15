import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/products_repository.dart';
import '../model/product.dart';
import 'app_theme.dart';
import 'autocomplete_screen.dart';
import 'view/app_bar_view.dart';
import 'view/product_card_view.dart';
import 'view/search_panel_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void _presentAutoComplete(BuildContext context) =>
      Navigator.of(context).push(PageRouteBuilder(
        pageBuilder: (_, __, ___) => const AutocompleteScreen(),
        fullscreenDialog: true,
      ));

  @override
  Widget build(BuildContext context) {
    final productRepository = context.read<ProductsRepository>();
    return Scaffold(
      appBar: AlgoliaAppBar(
        bottom: SearchPanelView(
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
                    ProductsView(
                        title: 'New in Shoes',
                        products: productRepository.getShoesProducts()),
                    ProductsView(
                        title: 'Spring/Summer 2021',
                        products: productRepository.getSeasonalProducts()),
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

class HomeBannerView extends StatelessWidget {
  const HomeBannerView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.centerStart,
      children: [
        Container(
          alignment: Alignment.center,
          child: ColorFiltered(
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.33), BlendMode.srcOver),
            child: Image.asset(
              'assets/images/banner.jpg',
              height: 128,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('New\nCollection'.toUpperCase(),
                  style: Theme.of(context).textTheme.headline4?.copyWith(
                      fontWeight: FontWeight.bold, color: Colors.white)),
              Text('Spring/Summer 2021'.toUpperCase(),
                  style: Theme.of(context).textTheme.subtitle2?.copyWith(
                      fontWeight: FontWeight.bold, color: Colors.white)),
            ],
          ),
        ),
      ],
    );
  }
}

class ProductsView extends StatelessWidget {
  const ProductsView({
    Key? key,
    required this.title,
    required this.products,
  }) : super(key: key);

  final String title;
  final Stream<List<Product>> products;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(title.toUpperCase(),
                style: Theme.of(context).textTheme.subtitle2),
            const Spacer(),
            TextButton(
              onPressed: () {},
              child: const Text(
                'See More',
                style: TextStyle(color: AppTheme.nebula),
              ),
            )
          ],
        ),
        Container(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            height: 200.0,
            child: StreamBuilder<List<Product>>(
              stream: products,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final products = snapshot.data ?? [];
                  return ListView.separated(
                      padding: const EdgeInsets.all(8),
                      scrollDirection: Axis.horizontal,
                      itemCount: products.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ProductCardView(product: products[index]);
                      },
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: 10));
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ))
      ],
    );
  }
}
