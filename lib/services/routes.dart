import 'package:go_router/go_router.dart';
import 'package:soft_list/screens/add_item.dart';
import 'package:soft_list/screens/add_topic.dart';
import 'package:soft_list/screens/edit_item.dart';
import 'package:soft_list/screens/home.dart';
import 'package:soft_list/screens/profile_form.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
    GoRoute(
      path: '/add-topic',
      builder: (context, state) => const AddTopicScreen(),
    ),
    GoRoute(
      path: '/add-item/:topicIndex',
      builder: (context, state) {
        final topicIndex = int.parse(state.pathParameters['topicIndex']!);
        return AddItemScreen(topicIndex: topicIndex);
      },
    ),
    GoRoute(
      path: '/edit-item/:topicIndex/:itemIndex',
      builder: (context, state) {
        final topicIndex = int.parse(state.pathParameters['topicIndex']!);
        final itemIndex = int.parse(state.pathParameters['itemIndex']!);
        return EditItemScreen(topicIndex: topicIndex, itemIndex: itemIndex);
      },
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) => const ProfileFormScreen(),
    ),
  ],
);
