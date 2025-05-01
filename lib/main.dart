import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'services/routes.dart';
import 'models/app_state.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AppState()..loadData()),
      ],
      child: MaterialApp.router(
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
        routerConfig: AppRoutes.router,
      ),
    );
  }
}
