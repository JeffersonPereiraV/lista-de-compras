import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/item.dart';

class EditItem extends StatefulWidget {
  final int topicIndex;
  final int itemIndex;
  final Item item;

  const EditItem({
    super.key,
    required this.topicIndex,
    required this.itemIndex,
    required this.item,
  });

  @override
  _EditItemState createState() => _EditItemState();
}

class _EditItemState extends State<EditItem> {
  late TextEditingController nameController;
  late TextEditingController descriptionController;
  late TextEditingController priceController;

  @override
  void initState() {
    nameController = TextEditingController(text: widget.item.name);
    descriptionController = TextEditingController(
      text: widget.item.description,
    );
    priceController = TextEditingController(
      text: widget.item.price.toStringAsFixed(2),
    );
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    super.dispose();
  }

  void _submit() {
    final name = nameController.text.trim();
    final description = descriptionController.text.trim();
    final price = double.tryParse(priceController.text) ?? 0.0;

    if (name.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('O nome é obrigatório')));
      return;
    }

    context.pop(
      Item(
        name: name,
        description: description,
        price: price,
        checked: widget.item.checked,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Item'),
        backgroundColor: Colors.teal[900],
      ),
      backgroundColor: Colors.grey[900],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Nome',
                labelStyle: const TextStyle(color: Colors.white70),
                border: const OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.teal[400]!),
                ),
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: descriptionController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Descrição',
                labelStyle: const TextStyle(color: Colors.white70),
                border: const OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.teal[400]!),
                ),
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: priceController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Preço',
                labelStyle: const TextStyle(color: Colors.white70),
                border: const OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.teal[400]!),
                ),
              ),
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => context.pop(),
                  child: const Text('Cancelar'),
                ),
                ElevatedButton(onPressed: _submit, child: const Text('Salvar')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
