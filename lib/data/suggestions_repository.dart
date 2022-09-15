import 'package:algolia_devcon_workshop/credentials.dart';
import 'package:algolia_helper_flutter/algolia_helper_flutter.dart';
import 'package:flutter/material.dart';

import '../model/query_suggestion.dart';

class SuggestionsRepository {
  final searchTextController = TextEditingController();

  final _suggestionsSearcher = HitsSearcher(
    applicationID: Credentials.applicationID,
    apiKey: Credentials.apiKey,
    indexName: Credentials.suggestionsIndex,
  );

  SuggestionsRepository() {
    searchTextController.addListener(() {
      _suggestionsSearcher.query(searchTextController.text);
    });
  }

  /// Get query suggestions stream
  Stream<List<QuerySuggestion>> get suggestions =>
      _suggestionsSearcher.responses.map((response) =>
          response.hits.map(QuerySuggestion.fromJson).toList());

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
