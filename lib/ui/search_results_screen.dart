import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';

import '../data/product_repository.dart';
import '../model/product.dart';
import '../model/search_metadata.dart';
import 'filters_screen.dart';
import 'view/app_bar_view.dart';
import 'view/product_card_view.dart';
import 'view/search_results_header_view.dart';

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

class PagedHitsGridView extends StatelessWidget {
  const PagedHitsGridView(
      {Key? key,
      required this.pagingController,
      this.onHitClick,
      this.noItemsFound})
      : super(key: key);

  final PagingController<int, Product> pagingController;
  final Function(String)? onHitClick;
  final WidgetBuilder? noItemsFound;

  @override
  Widget build(BuildContext context) {
    return PagedGridView<int, Product>(
      shrinkWrap: true,
      pagingController: pagingController,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 0.9,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        crossAxisCount: 2,
      ),
      builderDelegate: PagedChildBuilderDelegate<Product>(
        noItemsFoundIndicatorBuilder: noItemsFound,
        itemBuilder: (context, item, index) => ProductCardView(
            product: item,
            imageAlignment: Alignment.bottomCenter,
            onTap: (objectID) => onHitClick?.call(objectID)),
      ),
    );
  }
}

class NoResultsView extends StatelessWidget {
  const NoResultsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Try the following:",
              style: Theme.of(context).textTheme.bodyText1),
          const SizedBox(height: 4),
          Text("• Check your spelling",
              style: Theme.of(context).textTheme.bodyText2),
          Text("• Searching again using more general terms",
              style: Theme.of(context).textTheme.bodyText2),
        ],
      ),
    );
  }
}
