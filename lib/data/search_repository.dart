import 'package:algolia_helper_flutter/algolia_helper_flutter.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../credentials.dart';
import '../model/product.dart';
import '../model/search_metadata.dart';

class SearchRepository {
  final PagingController<int, Product> pagingController =
      PagingController(firstPageKey: 0);

  final _productsSearcher = HitsSearcher(
    applicationID: Credentials.applicationID,
    apiKey: Credentials.apiKey,
    indexName: Credentials.hitsIndex,
  );

  final _filterState = FilterState();

  late final _brandFacetList = FacetList(
      searcher: _productsSearcher,
      filterState: _filterState,
      attribute: 'brand');

  SearchRepository() {
    _productsSearcher.connectFilterState(_filterState);

    pagingController.addPageRequestListener((pageKey) {
      _productsSearcher.applyState((state) => state.copyWith(page: pageKey));
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
    _productsSearcher.query(query);
  }

  /// Get stream of latest search result
  Stream<SearchMetadata> get searchMetadata =>
      _productsSearcher.responses.map(SearchMetadata.fromResponse);

  /// Get stream of latest search page
  Stream<ProductsPage> get _searchPage =>
      _productsSearcher.responses.map(ProductsPage.fromResponse);

  /// Get the name of currently selected index
  Stream<String> get selectedIndexName =>
      _productsSearcher.state.map((state) => state.indexName);

  /// Update the name of the index to target
  void selectIndexName(String indexName) {
    pagingController.refresh();
    _productsSearcher
        .applyState((state) => state.copyWith(indexName: indexName));
  }

  /// Get stream of list of brand facets
  Stream<List<SelectableFacet>> get brandFacets => _brandFacetList.facets;

  /// Toggle selection of a brand facet
  void toggleBrand(String brand) {
    pagingController.refresh();
    _brandFacetList.toggle(brand);
  }

  /// Clear all filters
  void clearFilters() {
    pagingController.refresh();
    _filterState.clear();
  }
}
