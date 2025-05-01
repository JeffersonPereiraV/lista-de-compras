import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/item.dart';

class ItemTile extends StatelessWidget {
  final Item item;
  final int topicIndex;
  final int itemIndex;
  final Function(int, int) onToggle;
  final Function(int, int, Item) onEdit;
  final Function(int, int) onDelete;

  const ItemTile({
    super.key,
    required this.item,
    required this.topicIndex,
    required this.itemIndex,
    required this.onToggle,
    required this.onEdit,
    required this.onDelete,
  });

  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Confirmar Exclusão'),
            content: Text('Deseja excluir o item "${item.name}"?'),
            backgroundColor: Colors.grey[850],
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancelar'),
              ),
              ElevatedButton(
                onPressed: () {
                  onDelete(topicIndex, itemIndex);
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
    return Dismissible(
      key: Key('${topicIndex}_$itemIndex'),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red[900],
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 16),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      confirmDismiss: (direction) async {
        _confirmDelete(context);
        return false;
      },
      child: ListTile(
        leading: Checkbox(
          value: item.checked,
          activeColor: Colors.teal[400],
          checkColor: Colors.grey[900],
          onChanged: (_) => onToggle(topicIndex, itemIndex),
        ),
        title: Text(
          item.name,
          style: TextStyle(
            decoration: item.checked ? TextDecoration.lineThrough : null,
            color: item.checked ? Colors.grey[600] : Colors.white,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (item.description.isNotEmpty)
              Text(item.description, style: TextStyle(color: Colors.grey[500])),
            Text(
              'R\$ ${item.price.toStringAsFixed(2)}',
              style: TextStyle(
                color: Colors.teal[400],
                fontWeight: FontWeight.w500,
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
                  '/edit-item/$topicIndex/$itemIndex',
                  extra: item,
                );
                if (result != null && result is Item) {
                  onEdit(topicIndex, itemIndex, result);
                }
              },
            ),
            IconButton(
              icon: Icon(Icons.delete, color: Colors.red[900]),
              onPressed: () => _confirmDelete(context),
            ),
          ],
        ),
        onLongPress: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Item "${item.name}" selecionado')),
          );
        },
      ),
    );
  }
}
