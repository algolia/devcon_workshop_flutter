import 'package:algolia_helper_flutter/algolia_helper_flutter.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../credentials.dart';
import '../model/product.dart';
import '../model/search_metadata.dart';

class SearchRepository {
  final PagingController<int, Product> pagingController =
      PagingController(firstPageKey: 0);

  // TODO(3.1): add `_productsSearcher` searcher

  // TODO(4.3): add filter state
  // TODO(4.4): add brand facet list

  SearchRepository() {
    // TODO(4.5): connect hits searcher and filter state

    pagingController.addPageRequestListener((pageKey) {
      // TODO(3.5): request a new page
    });

    _searchPage.listen((page) {
      pagingController.appendPage(page.items, page.nextPageKey);
    }).onError((error) {
      pagingController.error = error;
    });
  }

  /// Get products list by query.
  void search(String query) {
    pagingController.refresh();
    // TODO(3.2): run search with 'query'
  }

  /// Get stream of latest search result
  // TODO(3.3): get products search metadata stream
  Stream<SearchMetadata> get searchMetadata => const Stream.empty();

  /// Get stream of latest search page
  // TODO(3.4): get products search results as pages stream
  Stream<ProductsPage> get _searchPage => const Stream.empty();

  /// Get the name of currently selected index
  // TODO(4.1): stream of selected index name
  Stream<String> get selectedIndexName => const Stream.empty();

  /// Update the name of the index to target
  void selectIndexName(String indexName) {
    pagingController.refresh();
    // TODO(4.2): update search state with new index
  }

  /// Get stream of list of brand facets
  // TODO(4.6): stream of brand facets
  Stream<List<SelectableFacet>> get brandFacets => const Stream.empty();

  /// Toggle selection of a brand facet
  void toggleBrand(String brand) {
    pagingController.refresh();
    // TODO(4.7): toggle facet list with 'brand'
  }

  /// Clear all filters
  void clearFilters() {
    pagingController.refresh();
    // TODO(4.8): clear all filters
  }
}
