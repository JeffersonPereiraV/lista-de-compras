import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:soft_list/blocs/topic/topic_bloc.dart';
import 'package:soft_list/blocs/topic/topic_event.dart';
import 'package:soft_list/blocs/topic/topic_state.dart';
import 'package:soft_list/models/item.dart';
import 'package:soft_list/models/topic.dart';
import 'package:soft_list/repositories/storage_repository.dart';

import 'topic_bloc_test.mocks.dart';

@GenerateMocks([StorageRepository])
void main() {
  late TopicBloc topicBloc;
  late MockStorageRepository mockStorageRepository;

  setUp(() {
    mockStorageRepository = MockStorageRepository();
    topicBloc = TopicBloc(mockStorageRepository);
  });

  tearDown(() {
    topicBloc.close();
  });

  group('TopicBloc Tests', () {
    final topic = Topic(
      name: 'Mercado',
      items: [Item(name: 'Maçã', price: 2.5)],
    );
    final topics = [topic];

    blocTest<TopicBloc, TopicState>(
      'emits [TopicLoading, TopicLoaded] when LoadTopics is added',
      build: () {
        when(
          mockStorageRepository.loadTopics(),
        ).thenAnswer((_) async => topics);
        return topicBloc;
      },
      act: (bloc) => bloc.add(LoadTopics()),
      expect: () => [TopicLoading(), TopicLoaded(topics)],
    );

    blocTest<TopicBloc, TopicState>(
      'emits [TopicLoading, TopicError] when LoadTopics fails',
      build: () {
        when(
          mockStorageRepository.loadTopics(),
        ).thenThrow(Exception('Load error'));
        return topicBloc;
      },
      act: (bloc) => bloc.add(LoadTopics()),
      expect:
          () => [
            TopicLoading(),
            TopicError('Failed to load topics: Exception: Load error'),
          ],
    );

    blocTest<TopicBloc, TopicState>(
      'emits TopicLoaded with new topic when AddTopic is added',
      build: () {
        when(mockStorageRepository.saveTopics(any)).thenAnswer((_) async {});
        return topicBloc;
      },
      seed: () => TopicLoaded([]),
      act: (bloc) => bloc.add(AddTopic('Mercado')),
      expect:
          () => [
            TopicLoaded([Topic(name: 'Mercado')]),
          ],
    );

    blocTest<TopicBloc, TopicState>(
      'emits TopicLoaded with new item when AddItem is added',
      build: () {
        when(mockStorageRepository.saveTopics(any)).thenAnswer((_) async {});
        return topicBloc;
      },
      seed: () => TopicLoaded([Topic(name: 'Mercado')]),
      act: (bloc) => bloc.add(AddItem(0, Item(name: 'Maçã', price: 2.5))),
      expect:
          () => [
            TopicLoaded([
              Topic(name: 'Mercado', items: [Item(name: 'Maçã', price: 2.5)]),
            ]),
          ],
    );

    blocTest<TopicBloc, TopicState>(
      'emits TopicLoaded with toggled item when ToggleItemChecked is added',
      build: () {
        when(mockStorageRepository.saveTopics(any)).thenAnswer((_) async {});
        return topicBloc;
      },
      seed:
          () => TopicLoaded([
            Topic(
              name: 'Mercado',
              items: [Item(name: 'Maçã', price: 2.5, checked: false)],
            ),
          ]),
      act: (bloc) => bloc.add(ToggleItemChecked(0, 0)),
      expect:
          () => [
            TopicLoaded([
              Topic(
                name: 'Mercado',
                items: [Item(name: 'Maçã', price: 2.5, checked: true)],
              ),
            ]),
          ],
    );

    blocTest<TopicBloc, TopicState>(
      'emits TopicLoaded with updated topic when UpdateTopic is added',
      build: () {
        when(mockStorageRepository.saveTopics(any)).thenAnswer((_) async {});
        return topicBloc;
      },
      seed: () => TopicLoaded([Topic(name: 'Mercado')]),
      act: (bloc) => bloc.add(UpdateTopic(0, Topic(name: 'Farmácia'))),
      expect:
          () => [
            TopicLoaded([Topic(name: 'Farmácia')]),
          ],
    );

    blocTest<TopicBloc, TopicState>(
      'emits TopicLoaded with removed topic when DeleteTopic is added',
      build: () {
        when(mockStorageRepository.saveTopics(any)).thenAnswer((_) async {});
        return topicBloc;
      },
      seed: () => TopicLoaded([Topic(name: 'Mercado')]),
      act: (bloc) => bloc.add(DeleteTopic(0)),
      expect: () => [TopicLoaded([])],
    );
  });
}
