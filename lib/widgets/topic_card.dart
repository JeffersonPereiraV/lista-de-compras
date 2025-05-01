import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/item.dart';
import '../models/topic.dart';
import 'item_tile.dart';

class TopicCard extends StatelessWidget {
  final Topic topic;
  final int topicIndex;
  final Function(int, int) onToggleItem;
  final Function(int) onDeleteTopic;
  final Function(int, String) onEditTopic;
  final Function(int, Item) onAddItem;
  final Function(int, int, Item) onEditItem;
  final Function(int, int) onDeleteItem;

  const TopicCard({
    super.key,
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

  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Confirmar Exclusão'),
            content: Text('Deseja excluir o tópico "${topic.name}"?'),
            backgroundColor: Colors.grey[850],
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancelar'),
              ),
              ElevatedButton(
                onPressed: () {
                  onDeleteTopic(topicIndex);
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red[900],
                ),
                child: const Text('Excluir'),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
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
            const SizedBox(height: 4),
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
              onPressed: () async {
                final result = await context.push(
                  '/edit-topic/$topicIndex',
                  extra: topic.name,
                );
                if (result != null && result is Map && result['name'] != null) {
                  onEditTopic(topicIndex, result['name'] as String);
                }
              },
            ),
            IconButton(
              icon: Icon(Icons.delete, color: Colors.red[900]),
              onPressed: () => _confirmDelete(context),
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  icon: const Icon(Icons.add),
                  label: const Text('Adicionar Item'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepOrange[800],
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () async {
                    final result = await context.push('/add-item/$topicIndex');
                    if (result != null && result is Item) {
                      onAddItem(topicIndex, result);
                    }
                  },
                ),
                OutlinedButton.icon(
                  icon: const Icon(Icons.edit_note),
                  label: const Text('Editar Tópico'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.teal[400],
                    side: BorderSide(color: Colors.teal[400]!),
                  ),
                  onPressed: () async {
                    final result = await context.push(
                      '/edit-topic/$topicIndex',
                      extra: topic.name,
                    );
                    if (result != null &&
                        result is Map &&
                        result['name'] != null) {
                      onEditTopic(topicIndex, result['name'] as String);
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
