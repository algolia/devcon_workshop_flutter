import 'package:algolia_devcon_workshop/product_repository.dart';
import 'package:algolia_devcon_workshop/query_suggestion.dart';
import 'package:algolia_devcon_workshop/provided/search_header_view.dart';
import 'package:algolia_devcon_workshop/search_results.dart';
import 'package:algolia_devcon_workshop/provided/suggestion_row_view.dart';
import 'package:algolia_devcon_workshop/suggestions_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchAutocomplete extends StatelessWidget {
  const SearchAutocomplete({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _searchHeader(context),
          _suggestionsHeader(context),
          _suggestionsBody(context),
        ],
      ),
    );
  }

  Widget _searchHeader(BuildContext context) => SliverAppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: SearchHeaderView(
            textEditingController:
                context.read<SuggestionsRepository>().searchTextController,
            onSubmitted: (query) => _onSubmitSearch(context, query)),
      );

  Widget _suggestionsHeader(BuildContext context) {
    final suggestionsRepository = context.read<SuggestionsRepository>();
    return StreamBuilder<List<QuerySuggestion>>(
        stream: suggestionsRepository.suggestions,
        builder: (context, snapshot) {
          final suggestions = snapshot.data ?? [];
          if (suggestions.isEmpty) {
            return const SliverToBoxAdapter(
              child: SizedBox.shrink(),
            );
          }
          return const SliverPadding(
            padding: EdgeInsets.only(left: 15),
            sliver: SliverToBoxAdapter(
                child: Text(
              "Popular searches",
              style: TextStyle(fontWeight: FontWeight.bold),
            )),
          );
        });
  }

  Widget _suggestionsBody(BuildContext context) {
    final suggestionsRepository = context.read<SuggestionsRepository>();
    return StreamBuilder<List<QuerySuggestion>>(
        stream: suggestionsRepository.suggestions,
        builder: (context, snapshot) {
          final suggestions = snapshot.data ?? [];
          if (suggestions.isEmpty) {
            return const SliverToBoxAdapter(child: SizedBox.shrink());
          }
          return SliverPadding(
              padding: const EdgeInsets.only(left: 15),
              sliver: SliverFixedExtentList(
                  itemExtent: 44,
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      final suggestion = suggestions[index];
                      return InkWell(
                        child: SuggestionRowView(
                            suggestion: suggestion,
                            onComplete:
                                suggestionsRepository.completeSuggestion),
                        onTap: () {
                          _onSubmitSearch(context, suggestion.toString());
                        },
                      );
                    },
                    childCount: suggestions.length,
                  )));
        });
  }

  void _onSubmitSearch(BuildContext context, String query) {
    context.read<ProductRepository>().search(query);
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => const SearchResultsScreen(),
        ));
  }
}
