import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:soft_list/blocs/topic/topic_bloc.dart';
import 'package:soft_list/models/item.dart';
import 'package:soft_list/models/topic.dart';
import 'package:soft_list/widgets/topic_card.dart';

class MockTopicBloc extends Mock implements TopicBloc {}

void main() {
  late MockTopicBloc mockTopicBloc;

  setUp(() {
    mockTopicBloc = MockTopicBloc();
  });

  Widget buildTestableWidget(Widget widget) {
    return MaterialApp(
      home: BlocProvider<TopicBloc>.value(value: mockTopicBloc, child: widget),
    );
  }

  testWidgets('TopicCard displays topic name and items', (tester) async {
    final topic = Topic(
      name: 'Mercado',
      items: [Item(name: 'Maçã', price: 2.5)],
    );

    await tester.pumpWidget(
      buildTestableWidget(
        TopicCard(topic: topic, onItemTapped: (index) {}, onAddItem: () {}),
      ),
    );

    expect(find.text('Mercado'), findsOneWidget);
    expect(find.text('Maçã'), findsOneWidget);
    expect(find.text('R\$ 2.50'), findsOneWidget);
  });

  testWidgets('TopicCard triggers onItemTapped when item is tapped', (
    tester,
  ) async {
    final topic = Topic(
      name: 'Mercado',
      items: [Item(name: 'Maçã', price: 2.5)],
    );
    int tappedIndex = -1;

    await tester.pumpWidget(
      buildTestableWidget(
        TopicCard(
          topic: topic,
          onItemTapped: (index) => tappedIndex = index,
          onAddItem: () {},
        ),
      ),
    );

    await tester.tap(find.text('Maçã'));
    await tester.pump();

    expect(tappedIndex, 0);
  });

  testWidgets('TopicCard triggers onAddItem when add button is tapped', (
    tester,
  ) async {
    final topic = Topic(name: 'Mercado', items: []);
    bool addItemTapped = false;

    await tester.pumpWidget(
      buildTestableWidget(
        TopicCard(
          topic: topic,
          onItemTapped: (index) {},
          onAddItem: () => addItemTapped = true,
        ),
      ),
    );

    await tester.tap(find.text('Add Item'));
    await tester.pump();

    expect(addItemTapped, true);
  });
}
