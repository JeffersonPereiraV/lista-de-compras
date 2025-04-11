import 'package:flutter/material.dart';
import '../models/item.dart';
import '../models/topic.dart';
import '../services/storage.dart';
import '../services/search.dart';
import '../widgets/topic_card.dart';
import '../widgets/dialog.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Topic> topics = [];
  List<Topic> filteredTopics = [];
  bool allChecked = false;
  String topicSearchQuery = '';
  String itemSearchQuery = '';

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    topics = await Storage.loadTopics();
    _updateFilteredTopics();
  }

  Future<void> _saveData() async {
    await Storage.saveTopics(topics);
    _updateFilteredTopics();
  }

  void _updateFilteredTopics() {
    setState(() {
      final topicFiltered = Search.searchTopics(topics, topicSearchQuery);
      filteredTopics = Search.searchItems(topicFiltered, itemSearchQuery);
    });
  }

  void _addTopic(String name) {
    setState(() {
      topics.add(Topic(name: name, items: []));
      _saveData();
    });
  }

  void _editTopicName(int index) async {
    final controller = TextEditingController(text: topics[index].name);
    final result = await showDialog<String>(
      context: context,
      builder:
          (_) => CustomDialog(
            title: 'Editar Tópico',
            labelText: 'Nome do Tópico',
            controller: controller,
            onCancel: () => Navigator.pop(context),
            onSave: (value) => Navigator.pop(context, value),
          ),
    );

    if (result != null && result.isNotEmpty) {
      setState(() {
        topics[index].name = result;
        _saveData();
      });
    }
  }

  void _deleteTopic(int index) {
    setState(() {
      topics.removeAt(index);
      _saveData();
    });
  }

  void _toggleItemChecked(int topicIndex, int itemIndex) {
    setState(() {
      final item = topics[topicIndex].items[itemIndex];
      item.checked = !item.checked;
      _saveData();
    });
  }

  void _toggleAllItemsChecked() {
    setState(() {
      allChecked = !allChecked;
      for (var topic in topics) {
        for (var item in topic.items) {
          item.checked = allChecked;
        }
      }
      _saveData();
    });
  }

  void _addItem(int topicIndex, Item item) {
    setState(() {
      topics[topicIndex].items.add(item);
      _saveData();
    });
  }

  void _editItem(int topicIndex, int itemIndex, Item item) {
    setState(() {
      topics[topicIndex].items[itemIndex] = item;
      _saveData();
    });
  }

  void _deleteItem(int topicIndex, int itemIndex) {
    setState(() {
      topics[topicIndex].items.removeAt(itemIndex);
      _saveData();
    });
  }

  double _calculateTotalPrice() {
    return topics.fold(
      0.0,
      (sum, topic) =>
          sum + topic.items.fold(0.0, (sum, item) => sum + item.price),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Lista de Compras', style: TextStyle(color: Colors.white)),
            SizedBox(height: 4),
            Text(
              'Total: R\$ ${_calculateTotalPrice().toStringAsFixed(2)}',
              style: TextStyle(fontSize: 14, color: Colors.white70),
            ),
          ],
        ),
        elevation: 2,
        backgroundColor: Colors.teal[900],
        actions: [
          IconButton(
            icon: Icon(Icons.checklist, color: Colors.white),
            onPressed: _toggleAllItemsChecked,
            tooltip: allChecked ? 'Desmarcar Todos' : 'Marcar Todos',
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 4.0),
            child: TextField(
              onChanged: (value) {
                setState(() => topicSearchQuery = value);
                _updateFilteredTopics();
              },
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Buscar tópicos...',
                hintStyle: TextStyle(color: Colors.white70),
                prefixIcon: Icon(Icons.category, color: Colors.teal[400]),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.teal[400]!),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 8.0),
            child: TextField(
              onChanged: (value) {
                setState(() => itemSearchQuery = value);
                _updateFilteredTopics();
              },
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Buscar itens...',
                hintStyle: TextStyle(color: Colors.white70),
                prefixIcon: Icon(Icons.search, color: Colors.teal[400]),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.teal[400]!),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredTopics.length,
              itemBuilder: (context, topicIndex) {
                final topic = filteredTopics[topicIndex];
                return TopicCard(
                  topic: topic,
                  topicIndex: topicIndex,
                  onToggleItem: _toggleItemChecked,
                  onDeleteTopic: _deleteTopic,
                  onEditTopic: _editTopicName,
                  onAddItem: _addItem,
                  onEditItem: _editItem,
                  onDeleteItem: _deleteItem,
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepOrange[800],
        foregroundColor: Colors.white,
        onPressed: () async {
          final controller = TextEditingController();
          final result = await showDialog<String>(
            context: context,
            builder:
                (_) => CustomDialog(
                  title: 'Novo Tópico',
                  labelText: 'Nome do Tópico',
                  controller: controller,
                  onCancel: () => Navigator.pop(context),
                  onSave: (value) => Navigator.pop(context, value),
                ),
          );

          if (result != null && result.trim().isNotEmpty) {
            _addTopic(result.trim());
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
