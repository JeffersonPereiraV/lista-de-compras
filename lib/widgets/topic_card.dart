import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:soft_list/blocs/topic/topic_bloc.dart';
import 'package:soft_list/blocs/topic/topic_event.dart';
import 'package:soft_list/models/topic.dart';
import 'package:soft_list/widgets/item_tile.dart';

class TopicCard extends StatelessWidget {
  final Topic topic;
  final int index;

  const TopicCard({super.key, required this.topic, required this.index});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: [
          ListTile(
            title: Text(topic.name),
            trailing: IconButton(
              icon: const Icon(Icons.add),
              onPressed: () => context.go('/add-item/$index'),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: topic.items.length,
            itemBuilder: (context, itemIndex) {
              return ItemTile(
                item: topic.items[itemIndex],
                topicIndex: index,
                itemIndex: itemIndex,
                onTap: () => context.go('/edit-item/$index/$itemIndex'),
              );
            },
          ),
        ],
      ),
    );
  }
}
