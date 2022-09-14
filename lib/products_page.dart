import 'product.dart';

class ProductsPage {
  const ProductsPage(this.items, this.nextPageKey);

  final List<Product> items;
  final int? nextPageKey;
}
