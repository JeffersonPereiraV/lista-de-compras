import 'package:flutter/foundation.dart';
import 'item.dart';
import 'topic.dart';
import 'user.dart';
import '../services/storage.dart';

class AppState extends ChangeNotifier {
  List<Topic> _topics = [];
  User _user = const User(name: 'Usuário', currency: 'BRL');
  String _topicSearchQuery = '';
  String _itemSearchQuery = '';
  String? _selectedCurrency;
  bool _allChecked = false;

  List<Topic> get topics => _topics;
  User get user => _user;
  String get topicSearchQuery => _topicSearchQuery;
  String get itemSearchQuery => _itemSearchQuery;
  String? get selectedCurrency => _selectedCurrency;
  bool get allChecked => _allChecked;

  Future<void> loadData() async {
    try {
      _topics = await Storage.loadTopics();
      _user = await Storage.loadUser();
      _updateAllChecked();
      notifyListeners();
    } catch (e) {
      throw Exception('Erro ao carregar dados: $e');
    }
  }

  void _updateAllChecked() {
    _allChecked =
        _topics.isNotEmpty &&
        _topics.every((topic) => topic.items.every((item) => item.checked));
  }

  Future<void> addTopic(String name) async {
    if (name.trim().isEmpty) {
      throw ArgumentError('O nome do tópico não pode ser vazio');
    }
    try {
      final newTopic = Topic(name: name, items: []);
      _topics = [..._topics, newTopic];
      await Storage.saveTopics(_topics);
      notifyListeners();
    } catch (e) {
      throw Exception('Erro ao adicionar tópico: $e');
    }
  }

  Future<void> editTopicName(int index, String name) async {
    if (index < 0 || index >= _topics.length) {
      throw RangeError('Índice de tópico inválido: $index');
    }
    if (name.trim().isEmpty) {
      throw ArgumentError('O nome do tópico não pode ser vazio');
    }
    try {
      final updatedTopic = _topics[index].copyWith(name: name);
      _topics = [
        ..._topics.take(index),
        updatedTopic,
        ..._topics.skip(index + 1),
      ];
      await Storage.saveTopics(_topics);
      notifyListeners();
    } catch (e) {
      throw Exception('Erro ao editar tópico: $e');
    }
  }

  Future<void> deleteTopic(int index) async {
    if (index < 0 || index >= _topics.length) {
      throw RangeError('Índice de tópico inválido: $index');
    }
    try {
      _topics = [..._topics.take(index), ..._topics.skip(index + 1)];
      await Storage.saveTopics(_topics);
      _updateAllChecked();
      notifyListeners();
    } catch (e) {
      throw Exception('Erro ao excluir tópico: $e');
    }
  }

  Future<void> addItem(int topicIndex, Item item) async {
    if (topicIndex < 0 || topicIndex >= _topics.length) {
      throw RangeError('Índice de tópico inválido: $topicIndex');
    }
    if (item.name.trim().isEmpty) {
      throw ArgumentError('O nome do item não pode ser vazio');
    }
    if (item.price < 0) {
      throw ArgumentError('O preço do item não pode ser negativo');
    }
    try {
      final topic = _topics[topicIndex];
      final newItems = [...topic.items, item];
      final updatedTopic = topic.copyWith(items: newItems);
      _topics = [
        ..._topics.take(topicIndex),
        updatedTopic,
        ..._topics.skip(topicIndex + 1),
      ];
      await Storage.saveTopics(_topics);
      _updateAllChecked();
      notifyListeners();
    } catch (e) {
      throw Exception('Erro ao adicionar item: $e');
    }
  }

  Future<void> editItem(int topicIndex, int itemIndex, Item item) async {
    if (topicIndex < 0 || topicIndex >= _topics.length) {
      throw RangeError('Índice de tópico inválido: $topicIndex');
    }
    if (itemIndex < 0 || itemIndex >= _topics[topicIndex].items.length) {
      throw RangeError('Índice de item inválido: $itemIndex');
    }
    if (item.name.trim().isEmpty) {
      throw ArgumentError('O nome do item não pode ser vazio');
    }
    if (item.price < 0) {
      throw ArgumentError('O preço do item não pode ser negativo');
    }
    try {
      final topic = _topics[topicIndex];
      final newItems = [
        ...topic.items.take(itemIndex),
        item,
        ...topic.items.skip(itemIndex + 1),
      ];
      final updatedTopic = topic.copyWith(items: newItems);
      _topics = [
        ..._topics.take(topicIndex),
        updatedTopic,
        ..._topics.skip(topicIndex + 1),
      ];
      await Storage.saveTopics(_topics);
      _updateAllChecked();
      notifyListeners();
    } catch (e) {
      throw Exception('Erro ao editar item: $e');
    }
  }

  Future<void> deleteItem(int topicIndex, int itemIndex) async {
    if (topicIndex < 0 || topicIndex >= _topics.length) {
      throw RangeError('Índice de tópico inválido: $topicIndex');
    }
    if (itemIndex < 0 || itemIndex >= _topics[topicIndex].items.length) {
      throw RangeError('Índice de item inválido: $itemIndex');
    }
    try {
      final topic = _topics[topicIndex];
      final newItems = [
        ...topic.items.take(itemIndex),
        ...topic.items.skip(itemIndex + 1),
      ];
      final updatedTopic = topic.copyWith(items: newItems);
      _topics = [
        ..._topics.take(topicIndex),
        updatedTopic,
        ..._topics.skip(topicIndex + 1),
      ];
      await Storage.saveTopics(_topics);
      _updateAllChecked();
      notifyListeners();
    } catch (e) {
      throw Exception('Erro ao excluir item: $e');
    }
  }

  Future<void> toggleItemChecked(int topicIndex, int itemIndex) async {
    if (topicIndex < 0 || topicIndex >= _topics.length) {
      throw RangeError('Índice de tópico inválido: $topicIndex');
    }
    if (itemIndex < 0 || itemIndex >= _topics[topicIndex].items.length) {
      throw RangeError('Índice de item inválido: $itemIndex');
    }
    try {
      final topic = _topics[topicIndex];
      final item = topic.items[itemIndex];
      final updatedItem = item.copyWith(checked: !item.checked);
      final newItems = [
        ...topic.items.take(itemIndex),
        updatedItem,
        ...topic.items.skip(itemIndex + 1),
      ];
      final updatedTopic = topic.copyWith(items: newItems);
      _topics = [
        ..._topics.take(topicIndex),
        updatedTopic,
        ..._topics.skip(topicIndex + 1),
      ];
      await Storage.saveTopics(_topics);
      _updateAllChecked();
      notifyListeners();
    } catch (e) {
      throw Exception('Erro ao marcar/desmarcar item: $e');
    }
  }

  Future<void> toggleAllItemsChecked() async {
    try {
      _allChecked = !_allChecked;
      _topics =
          _topics.map((topic) {
            final newItems =
                topic.items
                    .map((item) => item.copyWith(checked: _allChecked))
                    .toList();
            return topic.copyWith(items: newItems);
          }).toList();
      await Storage.saveTopics(_topics);
      notifyListeners();
    } catch (e) {
      throw Exception('Erro ao marcar/desmarcar todos os itens: $e');
    }
  }

  Future<void> updateUser(String name, String currency) async {
    if (name.trim().isEmpty) {
      throw ArgumentError('O nome do usuário não pode ser vazio');
    }
    if (!['BRL', 'USD', 'EUR'].contains(currency)) {
      throw ArgumentError('Moeda inválida: $currency');
    }
    try {
      _user = User(name: name, currency: currency);
      await Storage.saveUser(_user);
      notifyListeners();
    } catch (e) {
      throw Exception('Erro ao atualizar usuário: $e');
    }
  }

  void updateTopicSearchQuery(String query) {
    _topicSearchQuery = query;
    notifyListeners();
  }

  void updateItemSearchQuery(String query) {
    _itemSearchQuery = query;
    notifyListeners();
  }

  void updateSelectedCurrency(String? currency) {
    if (currency != null && !['BRL', 'USD'].contains(currency)) {
      throw ArgumentError('Moeda inválida para filtro: $currency');
    }
    _selectedCurrency = currency;
    notifyListeners();
  }
}
