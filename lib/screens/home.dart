import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../models/app_state.dart';
import '../models/topic.dart';
import '../services/search.dart';
import '../widgets/topic_card.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  void _showFilterBottomSheet(BuildContext context, AppState appState) {
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
                  value: appState.selectedCurrency,
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
                    appState.updateSelectedCurrency(value);
                    Navigator.pop(context);
                  },
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    appState.updateSelectedCurrency(null);
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
    return Consumer<AppState>(
      builder: (context, appState, child) {
        final filteredTopics = Search.searchItems(
          Search.searchTopics(
            appState.topics,
            appState.topicSearchQuery,
            currency: appState.selectedCurrency,
          ),
          appState.itemSearchQuery,
          currency: appState.selectedCurrency,
        );

        double calculateTotalPrice(List<Topic> topics) {
          return topics.fold(
            0.0,
            (sum, topic) =>
                sum + topic.items.fold(0.0, (sum, item) => sum + item.price),
          );
        }

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
                  'Total: R\$ ${calculateTotalPrice(appState.topics).toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 14, color: Colors.white70),
                ),
              ],
            ),
            elevation: 2,
            backgroundColor: Colors.teal[900],
            actions: [
              IconButton(
                icon: const Icon(Icons.checklist, color: Colors.white),
                onPressed: () => appState.toggleAllItemsChecked(),
                tooltip:
                    appState.allChecked ? 'Desmarcar Todos' : 'Marcar Todos',
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
                  onChanged: (value) => appState.updateTopicSearchQuery(value),
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Buscar tópicos...',
                    hintStyle: const TextStyle(color: Colors.white70),
                    prefixIcon: const Icon(Icons.category, color: Colors.teal),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.filter_list, color: Colors.teal),
                      onPressed:
                          () => _showFilterBottomSheet(context, appState),
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
                  onChanged: (value) => appState.updateItemSearchQuery(value),
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
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 16,
                            ),
                          ),
                        )
                        : ListView.builder(
                          itemCount: filteredTopics.length,
                          itemBuilder: (context, topicIndex) {
                            final topic = filteredTopics[topicIndex];
                            return TopicCard(
                              topic: topic,
                              topicIndex: topicIndex,
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
                try {
                  await appState.addTopic(result['name'] as String);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Tópico "${result['name']}" adicionado'),
                    ),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Erro ao adicionar tópico: $e')),
                  );
                }
              }
            },
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
