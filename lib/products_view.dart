import 'package:flutter/material.dart';

import 'hits_list_view.dart';
import 'product.dart';
import 'section_header.dart';
import 'type_aliases.dart';

class ProductsView extends StatelessWidget {
  const ProductsView({
    Key? key,
    required this.title,
    required this.productsStream,
    required this.productWidget,
  }) : super(key: key);

  final String title;
  final Stream<List<Product>> productsStream;
  final ProductWidgetBuilder productWidget;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(title: title),
        Container(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            height: 200.0,
            child: HitsListView(
                productsStream: productsStream,
                productWidget: productWidget,
                scrollDirection: Axis.horizontal))
      ],
    );
  }
}
