import '../models/topic.dart';

class Search {
  static List<Topic> searchTopics(
    List<Topic> topics,
    String query, {
    String? currency,
  }) {
    if (query.isEmpty && currency == null) return topics;
    return topics.where((topic) {
      final matchesQuery =
          query.isEmpty ||
          topic.name.toLowerCase().contains(query.toLowerCase());
      final matchesCurrency =
          currency == null || topic.items.any((item) => item.price > 0);
      return matchesQuery && matchesCurrency;
    }).toList();
  }

  static List<Topic> searchItems(
    List<Topic> topics,
    String query, {
    String? currency,
  }) {
    if (query.isEmpty && currency == null) return topics;

    return topics
        .map((topic) {
          final filteredItems =
              topic.items.where((item) {
                final matchesQuery =
                    query.isEmpty ||
                    item.name.toLowerCase().contains(query.toLowerCase()) ||
                    item.description.toLowerCase().contains(
                      query.toLowerCase(),
                    );
                final matchesCurrency = currency == null || item.price > 0;
                return matchesQuery && matchesCurrency;
              }).toList();
          return Topic(name: topic.name, items: filteredItems);
        })
        .where((topic) => topic.items.isNotEmpty)
        .toList();
  }
}
