import 'package:algolia_helper_flutter/algolia_helper_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/product_repository.dart';
import '../data/suggestions_repository.dart';
import '../model/query_suggestion.dart';
import 'app_theme.dart';
import 'search_results_screen.dart';

class AutocompleteScreen extends StatelessWidget {
  const AutocompleteScreen({Key? key}) : super(key: key);

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

class SearchHeaderView extends StatelessWidget {
  const SearchHeaderView(
      {Key? key,
      required this.textEditingController,
      required this.onSubmitted})
      : super(key: key);

  final TextEditingController textEditingController;
  final void Function(String) onSubmitted;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            autofocus: true,
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: 'Search products, articles, faq, ...',
            ),
            controller: textEditingController,
            onSubmitted: onSubmitted,
          ),
        ),
        if (textEditingController.text.isNotEmpty)
          IconButton(
            onPressed: textEditingController.clear,
            icon: const Icon(Icons.clear),
            color: AppTheme.darkBlue,
          ),
      ],
    );
  }
}

class SuggestionRowView extends StatelessWidget {
  const SuggestionRowView({Key? key, required this.suggestion, this.onComplete})
      : super(key: key);

  final QuerySuggestion suggestion;
  final Function(String)? onComplete;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      const Icon(Icons.search),
      const SizedBox(
        width: 10,
      ),
      RichText(
          text: TextSpan(
              style: const TextStyle(color: Colors.black),
              children: suggestion.highlighted!.toInlineSpans())),
      const Spacer(),
      IconButton(
        onPressed: () => onComplete?.call(suggestion.query),
        icon: const Icon(Icons.north_west),
      )
    ]);
  }
}
