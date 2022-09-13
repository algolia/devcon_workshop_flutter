import 'package:flutter/material.dart';
import 'package:algolia_devcon_workshop/provided/product.dart';
import 'package:algolia_devcon_workshop/provided/type_aliases.dart';

class HitsListView extends StatelessWidget {
  const HitsListView(
      {Key? key,
        required this.productsStream,
        required this.productWidget,
        this.scrollDirection = Axis.vertical})
      : super(key: key);

  final Stream<List<Product>> productsStream;
  final ProductWidgetBuilder productWidget;
  final Axis scrollDirection;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Product>>(
      stream: productsStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final products = snapshot.data ?? [];
          return ListView.separated(
              padding: const EdgeInsets.all(8),
              scrollDirection: scrollDirection,
              itemCount: products.length,
              itemBuilder: (BuildContext context, int index) {
                return productWidget(context, products[index]);
              },
              separatorBuilder: (context, index) => const SizedBox(width: 10));
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

