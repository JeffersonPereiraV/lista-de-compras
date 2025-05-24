import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:soft_list/blocs/topic/topic_bloc.dart';
import 'package:soft_list/blocs/topic/topic_state.dart';
import 'package:soft_list/widgets/topic_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Soft List'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () => context.go('/profile'),
          ),
        ],
      ),
      body: BlocBuilder<TopicBloc, TopicState>(
        builder: (context, state) {
          if (state is TopicLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TopicLoaded) {
            return ListView.builder(
              itemCount: state.topics.length,
              itemBuilder: (context, index) {
                return TopicCard(topic: state.topics[index], index: index);
              },
            );
          } else if (state is TopicError) {
            return Center(child: Text(state.message));
          }
          return const Center(child: Text('Nenhum tópico carregado'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.go('/add-topic'),
        child: const Icon(Icons.add),
      ),
    );
  }
}
