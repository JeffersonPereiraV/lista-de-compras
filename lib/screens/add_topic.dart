import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AddTopic extends StatefulWidget {
  final int? topicIndex;
  final String? initialName;

  const AddTopic({super.key, this.topicIndex, this.initialName});

  @override
  _AddTopicState createState() => _AddTopicState();
}

class _AddTopicState extends State<AddTopic> {
  late TextEditingController nameController;

  @override
  void initState() {
    nameController = TextEditingController(text: widget.initialName ?? '');
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  void _submit() {
    final name = nameController.text.trim();
    if (name.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('O nome é obrigatório')));
      return;
    }

    context.pop({'name': name, 'index': widget.topicIndex});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.initialName != null ? 'Editar Tópico' : 'Novo Tópico',
        ),
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
                labelText: 'Nome do Tópico',
                labelStyle: const TextStyle(color: Colors.white70),
                border: const OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.teal[400]!),
                ),
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
