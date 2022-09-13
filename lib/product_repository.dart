import 'package:algolia_devcon_workshop/products_page.dart';
import 'package:algolia_devcon_workshop/provided/credentials.dart';
import 'package:algolia_devcon_workshop/provided/product.dart';
import 'package:algolia_devcon_workshop/provided/type_aliases.dart';
import 'package:algolia_devcon_workshop/search_metadata.dart';
import 'package:algolia_helper_flutter/algolia_helper_flutter.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class ProductRepository {
  final PagingController<int, Product> pagingController =
      PagingController(firstPageKey: 0);

  // TODO(1.1): add shoes searcher (query: shoes)
  // TODO(1.2): seasonal products searcher (rules: 'home-spring-summer-2021')

  // TODO(3.1): add hits searcher

  // TODO(4.1): add filter state
  // TODO(4.2): add brand facet list

  ProductRepository() {
    // TODO(4.3): apply disjunctive facets (brand) to hits searcher
    // TODO(4.4): connect hits searcher and filter state

    pagingController.addPageRequestListener((pageKey) {
      // TODO(3.2): request a new page
    });

    _searchPage.listen((page) {
      pagingController.appendPage(page.items, page.nextPageKey);
    }).onError((error) {
      pagingController.error = error;
    });
  }

  // TODO(1.3): get 'shoes' products results
  ProductsStream getShoesProducts() => const Stream.empty();

  // TODO(1.4): get filtered products results
  ProductsStream getSeasonalProducts() => const Stream.empty();

  /// Get products list by query.
  void search(String query) {
    pagingController.refresh();
    // TODO(3.3): run search with 'query'
  }

  /// Get stream of latest search page
  // TODO(3.4): get products search results as pages stream
  Stream<ProductsPage> get _searchPage => const Stream.empty();

  /// Get stream of latest search result
  // TODO(3.5): get products search metadata stream
  Stream<SearchMetadata> get searchMetadata => const Stream.empty();

  /// Get the name of currently selected index
  // TODO(4.5): stream of selected index name
  Stream<String> get selectedIndexName => const Stream.empty();

  /// Update the name of the index to target
  void selectIndexName(String indexName) {
    pagingController.refresh();
    // TODO(4.6): update search state with new index
  }

  /// Get stream of list of brand facets
  // TODO(4.7): stream of brand facets
  Stream<List<SelectableFacet>> get brandFacets => const Stream.empty();

  /// Toggle selection of a brand facet
  void toggleBrand(String brand) {
    pagingController.refresh();
    // TODO(4.8): toggle facet list with 'brand'
  }

  /// Clear all filters
  void clearFilters() {
    pagingController.refresh();
    // TODO(4.9): clear all filters
  }
}
