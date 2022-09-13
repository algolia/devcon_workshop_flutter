import 'package:algolia_devcon_workshop/provided/product.dart';
import 'package:flutter/widgets.dart';

typedef ProductsStream = Stream<List<Product>>;
typedef ProductWidgetBuilder = Widget Function(
    BuildContext context, Product product);