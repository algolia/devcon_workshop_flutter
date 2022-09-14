import 'package:flutter/widgets.dart';

import 'product.dart';

typedef ProductsStream = Stream<List<Product>>;
typedef ProductWidgetBuilder = Widget Function(
    BuildContext context, Product product);
