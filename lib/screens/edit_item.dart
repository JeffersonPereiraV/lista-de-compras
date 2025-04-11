import 'package:flutter/material.dart';
import '../models/item.dart';

class EditItem extends StatefulWidget {
  final Item item;

  EditItem({required this.item});

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

    if (name.isEmpty) return;

    Navigator.pop(
      context,
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
    return AlertDialog(
      backgroundColor: Colors.grey[850],
      title: Text('Editar Item', style: TextStyle(color: Colors.teal[400])),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: nameController,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              labelText: 'Nome',
              labelStyle: TextStyle(color: Colors.white70),
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.teal[400]!),
              ),
            ),
          ),
          SizedBox(height: 8),
          TextField(
            controller: descriptionController,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              labelText: 'Descrição',
              labelStyle: TextStyle(color: Colors.white70),
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.teal[400]!),
              ),
            ),
          ),
          SizedBox(height: 8),
          TextField(
            controller: priceController,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              labelText: 'Preço',
              labelStyle: TextStyle(color: Colors.white70),
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.teal[400]!),
              ),
            ),
            keyboardType: TextInputType.numberWithOptions(decimal: true),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancelar'),
        ),
        ElevatedButton(onPressed: _submit, child: Text('Salvar')),
      ],
    );
  }
}
