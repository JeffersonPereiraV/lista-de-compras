import 'package:flutter/foundation.dart';
import 'item.dart';
import 'topic.dart';
import 'user.dart';
import '../services/storage.dart';

class AppState extends ChangeNotifier {
  List<Topic> _topics;
  User _user;
  String _topicSearchQuery;
  String _itemSearchQuery;
  String? _selectedCurrency;
  bool _allChecked;

  AppState({
    List<Topic> topics = const [],
    User? user,
    String topicSearchQuery = '',
    String itemSearchQuery = '',
    String? selectedCurrency,
    bool allChecked = false,
  }) : _topics = List.unmodifiable(topics),
       _user = user ?? User(name: '', currency: 'BRL'),
       _topicSearchQuery = topicSearchQuery,
       _itemSearchQuery = itemSearchQuery,
       _selectedCurrency = selectedCurrency,
       _allChecked = allChecked;

  List<Topic> get topics => _topics;
  User get user => _user;
  String get topicSearchQuery => _topicSearchQuery;
  String get itemSearchQuery => _itemSearchQuery;
  String? get selectedCurrency => _selectedCurrency;
  bool get allChecked => _allChecked;

  Future<void> addTopic(String name) async {
    final newTopic = Topic(name: name, items: []);
    _topics = List.unmodifiable([..._topics, newTopic]);
    await Storage.saveTopics(_topics);
    notifyListeners();
  }

  Future<void> editTopicName(int index, String name) async {
    final updatedTopic = _topics[index].copyWith(name: name);
    final newTopics = List<Topic>.from(_topics);
    newTopics[index] = updatedTopic;
    _topics = List.unmodifiable(newTopics);
    await Storage.saveTopics(_topics);
    notifyListeners();
  }

  Future<void> deleteTopic(int index) async {
    final newTopics = List<Topic>.from(_topics)..removeAt(index);
    _topics = List.unmodifiable(newTopics);
    await Storage.saveTopics(_topics);
    notifyListeners();
  }

  Future<void> addItem(int topicIndex, Item item) async {
    final topic = _topics[topicIndex];
    final newItems = List<Item>.from(topic.items)..add(item);
    final updatedTopic = topic.copyWith(items: newItems);
    final newTopics = List<Topic>.from(_topics);
    newTopics[topicIndex] = updatedTopic;
    _topics = List.unmodifiable(newTopics);
    await Storage.saveTopics(_topics);
    notifyListeners();
  }

  Future<void> editItem(int topicIndex, int itemIndex, Item item) async {
    final topic = _topics[topicIndex];
    final newItems = List<Item>.from(topic.items);
    newItems[itemIndex] = item;
    final updatedTopic = topic.copyWith(items: newItems);
    final newTopics = List<Topic>.from(_topics);
    newTopics[topicIndex] = updatedTopic;
    _topics = List.unmodifiable(newTopics);
    await Storage.saveTopics(_topics);
    notifyListeners();
  }

  Future<void> deleteItem(int topicIndex, int itemIndex) async {
    final topic = _topics[topicIndex];
    final newItems = List<Item>.from(topic.items)..removeAt(itemIndex);
    final updatedTopic = topic.copyWith(items: newItems);
    final newTopics = List<Topic>.from(_topics);
    newTopics[topicIndex] = updatedTopic;
    _topics = List.unmodifiable(newTopics);
    await Storage.saveTopics(_topics);
    notifyListeners();
  }

  Future<void> toggleItemChecked(int topicIndex, int itemIndex) async {
    final topic = _topics[topicIndex];
    final item = topic.items[itemIndex];
    final updatedItem = item.copyWith(checked: !item.checked);
    final newItems = List<Item>.from(topic.items);
    newItems[itemIndex] = updatedItem;
    final updatedTopic = topic.copyWith(items: newItems);
    final newTopics = List<Topic>.from(_topics);
    newTopics[topicIndex] = updatedTopic;
    _topics = List.unmodifiable(newTopics);
    await Storage.saveTopics(_topics);
    notifyListeners();
  }

  Future<void> toggleAllItemsChecked() async {
    _allChecked = !_allChecked;
    final newTopics =
        _topics.map((topic) {
          final newItems =
              topic.items
                  .map((item) => item.copyWith(checked: _allChecked))
                  .toList();
          return topic.copyWith(items: newItems);
        }).toList();
    _topics = List.unmodifiable(newTopics);
    await Storage.saveTopics(_topics);
    notifyListeners();
  }

  Future<void> updateUser(String name, String currency) async {
    _user = User(name: name, currency: currency);
    await Storage.saveUser(_user);
    notifyListeners();
  }

  void updateTopicSearchQuery(String query) {
    if (query.length > 100) {
      throw ArgumentError(
        'A consulta de pesquisa de tópicos não pode exceder 100 caracteres',
      );
    }
    _topicSearchQuery = query;
    notifyListeners();
  }

  void updateItemSearchQuery(String query) {
    if (query.length > 100) {
      throw ArgumentError(
        'A consulta de pesquisa de itens não pode exceder 100 caracteres',
      );
    }
    _itemSearchQuery = query;
    notifyListeners();
  }

  void updateSelectedCurrency(String? currency) {
    if (currency != null && !['BRL', 'USD', 'EUR'].contains(currency)) {
      throw ArgumentError('Moeda inválida: $currency');
    }
    _selectedCurrency = currency;
    notifyListeners();
  }

  Future<void> loadData() async {
    _topics = List.unmodifiable(await Storage.loadTopics());
    _user = await Storage.loadUser();
    notifyListeners();
  }
}
