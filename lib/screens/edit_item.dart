import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soft_list/blocs/topic/topic_bloc.dart';
import 'package:soft_list/blocs/topic/topic_event.dart';
import 'package:soft_list/blocs/topic/topic_state.dart';
import 'package:soft_list/models/item.dart';
import 'package:soft_list/models/topic.dart';

class EditItemScreen extends StatelessWidget {
  final int topicIndex;
  final int itemIndex;

  const EditItemScreen({
    super.key,
    required this.topicIndex,
    required this.itemIndex,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TopicBloc, TopicState>(
      builder: (context, state) {
        if (state is TopicLoaded) {
          final topic = state.topics[topicIndex];
          final item = topic.items[itemIndex];
          final TextEditingController nameController = TextEditingController(
            text: item.name,
          );
          final TextEditingController priceController = TextEditingController(
            text: item.price.toString(),
          );

          return Scaffold(
            appBar: AppBar(title: const Text('Editar Item')),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      labelText: 'Nome do Item',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: priceController,
                    decoration: const InputDecoration(
                      labelText: 'Preço',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      if (nameController.text.isNotEmpty &&
                          priceController.text.isNotEmpty) {
                        final updatedItem = Item(
                          name: nameController.text,
                          price: double.parse(priceController.text),
                          checked: item.checked,
                        );
                        final updatedItems = List<Item>.from(topic.items);
                        updatedItems[itemIndex] = updatedItem;
                        final updatedTopic = topic.copyWith(
                          items: updatedItems,
                        );
                        context.read<TopicBloc>().add(
                          UpdateTopic(topicIndex, updatedTopic),
                        );
                        Navigator.pop(context);
                      }
                    },
                    child: const Text('Salvar'),
                  ),
                ],
              ),
            ),
          );
        }
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      },
    );
  }
}
