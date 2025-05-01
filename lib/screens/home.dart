import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/item.dart';
import '../models/topic.dart';
import '../services/storage.dart';
import '../services/search.dart';
import '../widgets/topic_card.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Topic> topics = [];
  List<Topic> filteredTopics = [];
  bool allChecked = false;
  String topicSearchQuery = '';
  String itemSearchQuery = '';
  String? selectedCurrency;

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
      final topicFiltered = Search.searchTopics(
        topics,
        topicSearchQuery,
        currency: selectedCurrency,
      );
      filteredTopics = Search.searchItems(
        topicFiltered,
        itemSearchQuery,
        currency: selectedCurrency,
      );
    });
  }

  void _addTopic(String name) {
    setState(() {
      topics.add(Topic(name: name, items: []));
      _saveData();
    });
  }

  void _editTopicName(int index, String name) {
    setState(() {
      topics[index].name = name;
      _saveData();
    });
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

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.grey[850],
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder:
          (context) => Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Filtrar por Moeda',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 16),
                DropdownButton<String>(
                  value: selectedCurrency,
                  hint: const Text(
                    'Selecione a moeda',
                    style: TextStyle(color: Colors.white70),
                  ),
                  isExpanded: true,
                  dropdownColor: Colors.grey[850],
                  items: [
                    const DropdownMenuItem<String>(
                      value: null,
                      child: Text(
                        'Todas',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const DropdownMenuItem<String>(
                      value: 'BRL',
                      child: Text(
                        'Real (BRL)',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const DropdownMenuItem<String>(
                      value: 'USD',
                      child: Text(
                        'Dólar (USD)',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      selectedCurrency = value;
                      _updateFilteredTopics();
                    });
                    Navigator.pop(context);
                  },
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      selectedCurrency = null;
                      _updateFilteredTopics();
                    });
                    Navigator.pop(context);
                  },
                  child: const Text('Limpar Filtro'),
                ),
              ],
            ),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Lista de Compras',
              style: TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 4),
            Text(
              'Total: R\$ ${_calculateTotalPrice().toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 14, color: Colors.white70),
            ),
          ],
        ),
        elevation: 2,
        backgroundColor: Colors.teal[900],
        actions: [
          IconButton(
            icon: const Icon(Icons.checklist, color: Colors.white),
            onPressed: _toggleAllItemsChecked,
            tooltip: allChecked ? 'Desmarcar Todos' : 'Marcar Todos',
          ),
          IconButton(
            icon: const Icon(Icons.person, color: Colors.white),
            onPressed: () => context.push('/profile'),
            tooltip: 'Editar Perfil',
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
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Buscar tópicos...',
                hintStyle: const TextStyle(color: Colors.white70),
                prefixIcon: const Icon(Icons.category, color: Colors.teal),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.filter_list, color: Colors.teal),
                  onPressed: _showFilterBottomSheet,
                ),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  borderSide: BorderSide(color: Colors.teal),
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
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                hintText: 'Buscar itens...',
                hintStyle: TextStyle(color: Colors.white70),
                prefixIcon: Icon(Icons.search, color: Colors.teal),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  borderSide: BorderSide(color: Colors.teal),
                ),
              ),
            ),
          ),
          Expanded(
            child:
                filteredTopics.isEmpty
                    ? const Center(
                      child: Text(
                        'Nenhum resultado encontrado',
                        style: TextStyle(color: Colors.white70, fontSize: 16),
                      ),
                    )
                    : ListView.builder(
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
          final result = await context.push('/add-topic');
          if (result != null && result is Map && result['name'] != null) {
            _addTopic(result['name'] as String);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Tópico "${result['name']}" adicionado')),
            );
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
