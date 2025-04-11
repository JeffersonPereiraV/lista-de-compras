import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final String labelText;
  final TextEditingController controller;
  final VoidCallback onCancel;
  final Function(String) onSave;

  const CustomDialog({
    required this.title,
    required this.labelText,
    required this.controller,
    required this.onCancel,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title, style: TextStyle(color: Colors.teal[400])),
      backgroundColor: Colors.grey[850],
      content: TextField(
        controller: controller,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(color: Colors.white70),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.teal[400]!),
          ),
        ),
      ),
      actions: [
        TextButton(child: Text('Cancelar'), onPressed: onCancel),
        ElevatedButton(
          child: Text('Salvar'),
          onPressed: () => onSave(controller.text.trim()),
        ),
      ],
    );
  }
}
