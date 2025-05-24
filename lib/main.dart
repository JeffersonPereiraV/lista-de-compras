import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soft_list/blocs/topic/topic_bloc.dart';
import 'package:soft_list/blocs/topic/topic_event.dart';
import 'package:soft_list/blocs/user/user_bloc.dart';
import 'package:soft_list/blocs/user/user_event.dart';
import 'package:soft_list/repositories/storage_repository.dart';
import 'package:soft_list/services/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final storageRepository = StorageRepository();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TopicBloc(storageRepository)..add(LoadTopics()),
        ),
        BlocProvider(
          create: (context) => UserBloc(storageRepository)..add(LoadUser()),
        ),
      ],
      child: MaterialApp.router(
        title: 'Soft List',
        theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
        routerConfig: router,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
