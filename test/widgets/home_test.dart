import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:soft_list/models/app_state.dart';
import 'package:soft_list/models/item.dart';
import 'package:soft_list/screens/home.dart';
import 'package:soft_list/widgets/topic_card.dart';

void main() {
  group('Home Widget Tests', () {
    testWidgets('Home displays topics and updates on state change', (
      WidgetTester tester,
    ) async {
      final appState = AppState();
      final router = GoRouter(
        routes: [
          GoRoute(path: '/', builder: (context, state) => const Home()),
          GoRoute(
            path: '/add-topic',
            builder: (context, state) => const SizedBox(),
          ),
        ],
      );

      await tester.pumpWidget(
        ChangeNotifierProvider(
          create: (_) => appState,
          child: MaterialApp.router(
            routerConfig: router,
            theme: ThemeData(
              primarySwatch: Colors.teal,
              scaffoldBackgroundColor: Colors.grey[900],
              textTheme: const TextTheme(
                bodyMedium: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      );

      expect(find.text('Lista de Compras'), findsOneWidget);
      expect(find.text('Nenhum resultado encontrado'), findsOneWidget);
      expect(find.text('Total: BRL 0.00'), findsOneWidget);

      await appState.addTopic('Mercado');
      await tester.pumpAndSettle();

      expect(find.text('Mercado'), findsOneWidget);
      expect(find.byType(TopicCard), findsOneWidget);

      await appState.addItem(0, Item(name: 'Maçã', price: 2.5));
      await tester.pumpAndSettle();

      expect(find.text('Maçã'), findsOneWidget);
      expect(find.text('Total: BRL 2.50'), findsOneWidget);

      await tester.enterText(find.byType(TextField).first, 'Merc');
      await tester.pumpAndSettle();
      expect(find.text('Mercado'), findsOneWidget);

      await tester.enterText(find.byType(TextField).last, 'Maçã');
      await tester.pumpAndSettle();
      expect(find.text('Maçã'), findsOneWidget);
    });

    testWidgets('Home filter button opens BottomSheet', (
      WidgetTester tester,
    ) async {
      final appState = AppState();
      final router = GoRouter(
        routes: [GoRoute(path: '/', builder: (context, state) => const Home())],
      );

      await tester.pumpWidget(
        ChangeNotifierProvider(
          create: (_) => appState,
          child: MaterialApp.router(
            routerConfig: router,
            theme: ThemeData(primarySwatch: Colors.teal),
          ),
        ),
      );

      await tester.tap(find.byIcon(Icons.filter_list));
      await tester.pumpAndSettle();

      expect(find.text('Filtrar por Moeda'), findsOneWidget);
      expect(find.text('Todas'), findsOneWidget);
    });
  });
}
