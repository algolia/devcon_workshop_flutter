import 'package:algolia_helper_flutter/algolia_helper_flutter.dart';

import '../credentials.dart';
import '../model/product.dart';
import '../model/type_aliases.dart';

class ProductsRepository {
  // TODO(1.1): add `_shoesSearcher` searcher (query: shoes)
  // TODO(1.2): add `_seasonalProductsSearcher` searcher (rules: 'home-spring-summer-2021')

  // TODO(1.3): get 'shoes' products results
  ProductsStream getShoesProducts() => const Stream.empty();

  // TODO(1.4): get filtered products results
  ProductsStream getSeasonalProducts() => const Stream.empty();
}
