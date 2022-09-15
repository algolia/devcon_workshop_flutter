import 'package:algolia_devcon_workshop/model/product.dart';
import 'package:algolia_helper_flutter/algolia_helper_flutter.dart';

import '../credentials.dart';
import '../model/type_aliases.dart';

class ProductsRepository {
  final _shoesSearcher = HitsSearcher.create(
    applicationID: Credentials.applicationID,
    apiKey: Credentials.apiKey,
    state: const SearchState(
      indexName: Credentials.hitsIndex,
      query: 'shoes',
    ),
  );

  final _seasonalProductsSearcher = HitsSearcher.create(
    applicationID: Credentials.applicationID,
    apiKey: Credentials.apiKey,
    state: const SearchState(
      indexName: Credentials.hitsIndex,
      ruleContexts: ['home-spring-summer-2021'],
    ),
  );

  ProductsStream getShoesProducts() => _shoesSearcher.responses
      .map((response) => response.hits.map(Product.fromJson).toList());

  ProductsStream getSeasonalProducts() => _seasonalProductsSearcher.responses
      .map((response) => response.hits.map(Product.fromJson).toList());
}
