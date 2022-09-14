import 'package:algolia_helper_flutter/algolia_helper_flutter.dart';

import 'product.dart';

class ProductsPage {
  const ProductsPage(this.items, this.nextPageKey);

  final List<Product> items;
  final int? nextPageKey;

  factory ProductsPage.fromResponse(SearchResponse response) {
    final items = response.hits.map(Product.fromJson).toList();
    final isLastPage = response.page >= response.nbPages;
    final nextPageKey = isLastPage ? null : response.page + 1;
    return ProductsPage(items, nextPageKey);
  }
}
