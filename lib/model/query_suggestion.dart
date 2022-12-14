import 'package:algolia_helper_flutter/algolia_helper_flutter.dart';

class QuerySuggestion {
  QuerySuggestion(this.query, this.highlighted);

  String query;
  HighlightedString? highlighted;

  static QuerySuggestion fromJson(Hit hit) {
    /// TODO(2.4): set inverted to true
    final highlighted = hit.getHighlightedString('query');
    return QuerySuggestion(hit["query"], highlighted);
  }

  @override
  String toString() {
    return query;
  }
}
