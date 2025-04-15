import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'screens/home.dart';
import 'screens/add_item.dart';
import 'screens/edit_item.dart';
import 'screens/add_topic.dart';
import 'models/item.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final GoRouter _router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(path: '/', builder: (context, state) => const Home()),
      GoRoute(
        path: '/add-item/:topicIndex',
        builder: (context, state) {
          final topicIndex = int.parse(state.pathParameters['topicIndex']!);
          return AddItem(topicIndex: topicIndex);
        },
      ),
      GoRoute(
        path: '/edit-item/:topicIndex/:itemIndex',
        builder: (context, state) {
          final topicIndex = int.parse(state.pathParameters['topicIndex']!);
          final itemIndex = int.parse(state.pathParameters['itemIndex']!);
          final item = state.extra as Item;
          return EditItem(
            topicIndex: topicIndex,
            itemIndex: itemIndex,
            item: item,
          );
        },
      ),
      GoRoute(
        path: '/add-topic',
        builder: (context, state) => const AddTopic(),
      ),
      GoRoute(
        path: '/edit-topic/:topicIndex',
        builder: (context, state) {
          final topicIndex = int.parse(state.pathParameters['topicIndex']!);
          final topicName = state.extra as String;
          return AddTopic(topicIndex: topicIndex, initialName: topicName);
        },
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Lista de Compras',
      theme: ThemeData(
        primaryColor: Colors.teal[900],
        scaffoldBackgroundColor: Colors.grey[900],
        colorScheme: ColorScheme.dark(
          primary: Colors.teal[900]!,
          secondary: Colors.deepOrange[800]!,
          background: Colors.grey[900]!,
          surface: Colors.grey[850]!,
        ),
        cardTheme: CardTheme(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          color: Colors.grey[850],
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.teal[900],
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(foregroundColor: Colors.teal[400]),
        ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.white70),
          titleLarge: TextStyle(color: Colors.white),
        ),
      ),
      routerConfig: _router,
    );
  }
}
