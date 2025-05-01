import 'package:go_router/go_router.dart';
import '../models/item.dart';
import '../screens/add_item.dart';
import '../screens/add_topic.dart';
import '../screens/edit_item.dart';
import '../screens/home.dart';
import '../screens/profile_form.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    routes: [
      GoRoute(path: '/', builder: (context, state) => const Home()),
      GoRoute(
        path: '/add-topic',
        builder: (context, state) => const AddTopic(),
      ),
      GoRoute(
        path: '/edit-topic/:topicIndex',
        builder: (context, state) {
          final topicIndex = int.parse(state.pathParameters['topicIndex']!);
          final name = state.extra as String?;
          return AddTopic(topicIndex: topicIndex, initialName: name);
        },
      ),
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
        path: '/profile',
        builder: (context, state) => const ProfileForm(),
      ),
    ],
  );
}
