import 'package:equatable/equatable.dart';
import 'package:soft_list/models/item.dart';
import 'package:soft_list/models/topic.dart';

abstract class TopicEvent extends Equatable {
  const TopicEvent();

  @override
  List<Object?> get props => [];
}

class LoadTopics extends TopicEvent {}

class AddTopic extends TopicEvent {
  final String name;

  const AddTopic(this.name);

  @override
  List<Object?> get props => [name];
}

class AddItem extends TopicEvent {
  final int topicIndex;
  final Item item;

  const AddItem(this.topicIndex, this.item);

  @override
  List<Object?> get props => [topicIndex, item];
}

class UpdateTopic extends TopicEvent {
  final int topicIndex;
  final Topic topic;

  const UpdateTopic(this.topicIndex, this.topic);

  @override
  List<Object?> get props => [topicIndex, topic];
}

class ToggleItemChecked extends TopicEvent {
  final int topicIndex;
  final int itemIndex;

  const ToggleItemChecked(this.topicIndex, this.itemIndex);

  @override
  List<Object?> get props => [topicIndex, itemIndex];
}

class DeleteTopic extends TopicEvent {
  final int topicIndex;

  const DeleteTopic(this.topicIndex);

  @override
  List<Object?> get props => [topicIndex];
}
