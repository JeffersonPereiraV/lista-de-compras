import 'package:soft_list/models/topic.dart';

class SearchService {
  List<Topic> searchTopics(List<Topic> topics, String query) {
    if (query.isEmpty) return topics;

    final lowerQuery = query.toLowerCase();
    return topics
        .asMap()
        .entries
        .where((entry) {
          final topic = entry.value;
          final topicMatches = topic.name.toLowerCase().contains(lowerQuery);
          final itemMatches = topic.items.any(
            (item) => item.name.toLowerCase().contains(lowerQuery),
          );
          return topicMatches || itemMatches;
        })
        .map((entry) {
          final topic = entry.value;
          final topicMatches = topic.name.toLowerCase().contains(lowerQuery);
          final filteredItems =
              topic.items
                  .where((item) => item.name.toLowerCase().contains(lowerQuery))
                  .toList();
          return topicMatches
              ? topic
              : Topic(name: topic.name, items: filteredItems);
        })
        .where(
          (topic) =>
              topic.name.toLowerCase().contains(lowerQuery) ||
              topic.items.isNotEmpty,
        )
        .toList();
  }
}
