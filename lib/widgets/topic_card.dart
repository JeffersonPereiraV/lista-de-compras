import 'package:flutter/material.dart';
import '../models/item.dart';
import '../models/topic.dart';
import 'item_tile.dart';
import '../screens/add_item.dart';

class TopicCard extends StatelessWidget {
  final Topic topic;
  final int topicIndex;
  final Function(int, int) onToggleItem;
  final Function(int) onDeleteTopic;
  final Function(int) onEditTopic;
  final Function(int, Item) onAddItem;
  final Function(int, int, Item) onEditItem;
  final Function(int, int) onDeleteItem;

  const TopicCard({
    required this.topic,
    required this.topicIndex,
    required this.onToggleItem,
    required this.onDeleteTopic,
    required this.onEditTopic,
    required this.onAddItem,
    required this.onEditItem,
    required this.onDeleteItem,
  });

  double _calculateTopicTotal() {
    return topic.items.fold(0.0, (sum, item) => sum + item.price);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      child: ExpansionTile(
        collapsedBackgroundColor: Colors.teal[900]!.withOpacity(0.2),
        backgroundColor: Colors.teal[900]!.withOpacity(0.1),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              topic.name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.teal[400],
              ),
            ),
            SizedBox(height: 4),
            Text(
              'Subtotal: R\$ ${_calculateTopicTotal().toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[400],
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.edit, color: Colors.deepOrange[400]),
              onPressed: () => onEditTopic(topicIndex),
            ),
            IconButton(
              icon: Icon(Icons.delete, color: Colors.red[900]),
              onPressed: () => onDeleteTopic(topicIndex),
            ),
          ],
        ),
        children: [
          for (int itemIndex = 0; itemIndex < topic.items.length; itemIndex++)
            ItemTile(
              item: topic.items[itemIndex],
              topicIndex: topicIndex,
              itemIndex: itemIndex,
              onToggle: onToggleItem,
              onEdit: onEditItem,
              onDelete: onDeleteItem,
            ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton.icon(
              icon: Icon(Icons.add),
              label: Text('Adicionar Item'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrange[800],
                foregroundColor: Colors.white,
              ),
              onPressed: () async {
                final result = await showDialog<Item>(
                  context: context,
                  builder: (_) => AddItem(),
                );
                if (result != null) {
                  onAddItem(topicIndex, result);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
