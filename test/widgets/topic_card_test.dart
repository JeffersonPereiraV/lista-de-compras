import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:soft_list/models/app_state.dart';
import 'package:soft_list/models/item.dart';
import 'package:soft_list/models/topic.dart';
import 'package:soft_list/widgets/topic_card.dart';

void main() {
  group('TopicCard Widget Tests', () {
    testWidgets('TopicCard displays topic and items', (
      WidgetTester tester,
    ) async {
      final appState = AppState();
      final topic = Topic(
        name: 'Mercado',
        items: [Item(name: 'Maçã', price: 2.5)],
      );
      await appState.addTopic('Mercado');
      await appState.addItem(0, Item(name: 'Maçã', price: 2.5));

      await tester.pumpWidget(
        ChangeNotifierProvider(
          create: (_) => appState,
          child: MaterialApp(
            home: Scaffold(body: TopicCard(topic: topic, topicIndex: 0)),
          ),
        ),
      );

      expect(find.text('Mercado'), findsOneWidget);
      expect(find.text('Maçã'), findsOneWidget);
      expect(find.text('BRL 2.50'), findsOneWidget);
    });

    testWidgets('TopicCard navigates to add item on FAB tap', (
      WidgetTester tester,
    ) async {
      final appState = AppState();
      final topic = Topic(name: 'Mercado', items: []);
      final router = GoRouter(
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => TopicCard(topic: topic, topicIndex: 0),
          ),
          GoRoute(
            path: '/add-item/0',
            builder: (context, state) => const SizedBox(),
          ),
        ],
      );

      await tester.pumpWidget(
        ChangeNotifierProvider(
          create: (_) => appState,
          child: MaterialApp.router(routerConfig: router),
        ),
      );

      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();

      expect(find.byType(SizedBox), findsOneWidget);
    });
  });
}
