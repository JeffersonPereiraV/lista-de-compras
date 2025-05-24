import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:soft_list/blocs/topic/topic_bloc.dart';
import 'package:soft_list/blocs/topic/topic_event.dart';
import 'package:soft_list/models/item.dart';

class ItemTile extends StatelessWidget {
  final Item item;
  final int topicIndex;
  final int itemIndex;
  final VoidCallback? onTap;

  const ItemTile({
    super.key,
    required this.item,
    required this.topicIndex,
    required this.itemIndex,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(item.name),
      subtitle: Text('R\$ ${item.price.toStringAsFixed(2)}'),
      leading: Checkbox(
        value: item.checked,
        onChanged: (value) {
          context.read<TopicBloc>().add(
            ToggleItemChecked(topicIndex, itemIndex),
          );
        },
      ),
      onTap: onTap ?? () => context.go('/edit-item/$topicIndex/$itemIndex'),
    );
  }
}
