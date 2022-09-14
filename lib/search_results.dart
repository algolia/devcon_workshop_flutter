import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app_bar_view.dart';
import 'filters_screen.dart';
import 'no_results_view.dart';
import 'paged_hits_grid_view.dart';
import 'product_repository.dart';
import 'search_metadata.dart';
import 'search_results_header_view.dart';

class SearchResultsScreen extends StatefulWidget {
  const SearchResultsScreen({Key? key}) : super(key: key);

  @override
  State<SearchResultsScreen> createState() => SearchResultsScreenState();
}

class SearchResultsScreenState extends State<SearchResultsScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final productRepository = context.read<ProductRepository>();
    return Scaffold(
      key: _key,
      appBar: const AlgoliaAppBar(),
      body: Column(
        children: [
          StreamBuilder<SearchMetadata>(
              stream: productRepository.searchMetadata,
              builder: (context, snapshot) {
                return SearchResultsHeaderView(
                    query: snapshot.data?.query ?? '',
                    resultsCount: snapshot.data?.nbHits ?? 0,
                    filtersButtonTapped: _key.currentState?.openEndDrawer,
                    backButtonTapped: () {
                      productRepository.clearFilters();
                      Navigator.pop(context);
                    });
              }),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
              child: PagedHitsGridView(
                  pagingController: productRepository.pagingController,
                  onHitClick: (objectID) {},
                  noItemsFound: (_) => const NoResultsView()),
            ),
          ),
        ],
      ),
      endDrawer: const Drawer(
        child: FiltersScreen(),
      ),
    );
  }
}
