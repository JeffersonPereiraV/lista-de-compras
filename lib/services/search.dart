import '../models/topic.dart';

class Search {
  static List<Topic> searchTopics(
    List<Topic> topics,
    String query, {
    String? currency,
  }) {
    final lowerQuery = query.toLowerCase();
    return topics.where((topic) {
      final matchesName = topic.name.toLowerCase().contains(lowerQuery);
      final matchesCurrency =
          currency == null || topic.items.any((item) => true);
      return matchesName && matchesCurrency;
    }).toList();
  }

  static List<Topic> searchItems(
    List<Topic> topics,
    String query, {
    String? currency,
  }) {
    final lowerQuery = query.toLowerCase();
    return topics
        .map((topic) {
          final filteredItems =
              topic.items.where((item) {
                final matchesName = item.name.toLowerCase().contains(
                  lowerQuery,
                );
                final matchesDescription = item.description
                    .toLowerCase()
                    .contains(lowerQuery);
                return matchesName || matchesDescription;
              }).toList();
          return Topic(name: topic.name, items: filteredItems);
        })
        .where((topic) => topic.items.isNotEmpty)
        .toList();
  }
}
