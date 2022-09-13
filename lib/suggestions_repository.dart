import 'package:algolia_devcon_workshop/provided/credentials.dart';
import 'package:algolia_devcon_workshop/query_suggestion.dart';
import 'package:algolia_helper_flutter/algolia_helper_flutter.dart';
import 'package:flutter/material.dart';

class SuggestionsRepository {
  final searchTextController = TextEditingController();

  // TODO(2.1): add suggestions searcher

  SuggestionsRepository() {
    searchTextController.addListener(() {
      // TODO(2.2): run search request on text change
    });
  }

  /// Get query suggestions stream
  // TODO(2.3): get search suggestions stream
  Stream<List<QuerySuggestion>> get suggestions => const Stream.empty();

  /// Replace textController input field with suggestion
  void completeSuggestion(String suggestion) {
    searchTextController.value = TextEditingValue(
      text: suggestion,
      selection: TextSelection.fromPosition(
        TextPosition(offset: suggestion.length),
      ),
    );
  }
}
