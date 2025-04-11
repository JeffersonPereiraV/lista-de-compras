import '../models/topic.dart';

class Search {
  static List<Topic> searchTopics(List<Topic> topics, String query) {
    if (query.isEmpty) return topics;
    return topics
        .where(
          (topic) => topic.name.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();
  }

  static List<Topic> searchItems(List<Topic> topics, String query) {
    if (query.isEmpty) return topics;

    return topics
        .map((topic) {
          final filteredItems =
              topic.items
                  .where(
                    (item) =>
                        item.name.toLowerCase().contains(query.toLowerCase()) ||
                        item.description.toLowerCase().contains(
                          query.toLowerCase(),
                        ),
                  )
                  .toList();
          return Topic(name: topic.name, items: filteredItems);
        })
        .where((topic) => topic.items.isNotEmpty)
        .toList();
  }
}
