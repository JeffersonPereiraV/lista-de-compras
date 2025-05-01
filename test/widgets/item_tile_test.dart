import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:soft_list/models/app_state.dart';
import 'package:soft_list/models/item.dart';
import 'package:soft_list/widgets/item_tile.dart';

void main() {
  group('ItemTile Widget Tests', () {
    testWidgets('ItemTile toggles item checked state', (
      WidgetTester tester,
    ) async {
      final appState = AppState();
      await appState.addTopic('Mercado');
      await appState.addItem(0, Item(name: 'Maçã', price: 2.5));

      await tester.pumpWidget(
        ChangeNotifierProvider(
          create: (_) => appState,
          child: MaterialApp(
            home: Scaffold(
              body: ItemTile(
                topicIndex: 0,
                itemIndex: 0,
                item: Item(name: 'Maçã', price: 2.5),
              ),
            ),
          ),
        ),
      );

      expect(find.byType(Checkbox), findsOneWidget);
      expect(appState.topics[0].items[0].checked, false);

      await tester.tap(find.byType(Checkbox));
      await tester.pumpAndSettle();

      expect(appState.topics[0].items[0].checked, true);
    });

    testWidgets('ItemTile deletes item on swipe', (WidgetTester tester) async {
      final appState = AppState();
      await appState.addTopic('Mercado');
      await appState.addItem(0, Item(name: 'Maçã', price: 2.5));

      await tester.pumpWidget(
        ChangeNotifierProvider(
          create: (_) => appState,
          child: MaterialApp(
            home: Scaffold(
              body: ItemTile(
                topicIndex: 0,
                itemIndex: 0,
                item: Item(name: 'Maçã', price: 2.5),
              ),
            ),
          ),
        ),
      );

      expect(appState.topics[0].items.length, 1);

      await tester.drag(find.text('Maçã'), const Offset(-500, 0));
      await tester.pumpAndSettle();

      expect(appState.topics[0].items.length, 0);
    });
  });
}
