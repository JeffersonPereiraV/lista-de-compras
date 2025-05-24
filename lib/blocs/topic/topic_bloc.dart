import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soft_list/models/item.dart';
import 'package:soft_list/models/topic.dart';
import 'package:soft_list/repositories/storage_repository.dart';
import 'topic_event.dart';
import 'topic_state.dart';

class TopicBloc extends Bloc<TopicEvent, TopicState> {
  final StorageRepository storageRepository;

  TopicBloc(this.storageRepository) : super(TopicInitial()) {
    on<LoadTopics>(_onLoadTopics);
    on<AddTopic>(_onAddTopic);
    on<AddItem>(_onAddItem);
    on<UpdateTopic>(_onUpdateTopic);
    on<ToggleItemChecked>(_onToggleItemChecked);
    on<DeleteTopic>(_onDeleteTopic);
  }

  Future<void> _onLoadTopics(LoadTopics event, Emitter<TopicState> emit) async {
    emit(TopicLoading());
    try {
      final topics = await storageRepository.loadTopics();
      emit(TopicLoaded(topics));
    } catch (e) {
      emit(TopicError('Failed to load topics: $e'));
    }
  }

  Future<void> _onAddTopic(AddTopic event, Emitter<TopicState> emit) async {
    if (state is TopicLoaded) {
      final currentTopics = (state as TopicLoaded).topics;
      final newTopic = Topic(name: event.name, items: []);
      final updatedTopics = [...currentTopics, newTopic];
      await storageRepository.saveTopics(updatedTopics);
      emit(TopicLoaded(updatedTopics));
    }
  }

  Future<void> _onAddItem(AddItem event, Emitter<TopicState> emit) async {
    if (state is TopicLoaded) {
      final currentTopics = (state as TopicLoaded).topics;
      final topic = currentTopics[event.topicIndex];
      final updatedItems = [...topic.items, event.item];
      final updatedTopic = topic.copyWith(items: updatedItems);
      final updatedTopics = List<Topic>.from(currentTopics)
        ..[event.topicIndex] = updatedTopic;
      await storageRepository.saveTopics(updatedTopics);
      emit(TopicLoaded(updatedTopics));
    }
  }

  Future<void> _onUpdateTopic(
    UpdateTopic event,
    Emitter<TopicState> emit,
  ) async {
    if (state is TopicLoaded) {
      final currentTopics = (state as TopicLoaded).topics;
      final updatedTopics = List<Topic>.from(currentTopics)
        ..[event.topicIndex] = event.topic;
      await storageRepository.saveTopics(updatedTopics);
      emit(TopicLoaded(updatedTopics));
    }
  }

  Future<void> _onToggleItemChecked(
    ToggleItemChecked event,
    Emitter<TopicState> emit,
  ) async {
    if (state is TopicLoaded) {
      final currentTopics = (state as TopicLoaded).topics;
      final topic = currentTopics[event.topicIndex];
      final item = topic.items[event.itemIndex];
      final updatedItem = item.copyWith(checked: !item.checked);
      final updatedItems = List<Item>.from(topic.items)
        ..[event.itemIndex] = updatedItem;
      final updatedTopic = topic.copyWith(items: updatedItems);
      final updatedTopics = List<Topic>.from(currentTopics)
        ..[event.topicIndex] = updatedTopic;
      await storageRepository.saveTopics(updatedTopics);
      emit(TopicLoaded(updatedTopics));
    }
  }

  Future<void> _onDeleteTopic(
    DeleteTopic event,
    Emitter<TopicState> emit,
  ) async {
    if (state is TopicLoaded) {
      final currentTopics = (state as TopicLoaded).topics;
      final updatedTopics = List<Topic>.from(currentTopics)
        ..removeAt(event.topicIndex);
      await storageRepository.saveTopics(updatedTopics);
      emit(TopicLoaded(updatedTopics));
    }
  }
}
