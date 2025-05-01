import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../screens/home.dart';
import '../screens/add_item.dart';
import '../screens/edit_item.dart';
import '../screens/add_topic.dart';
import '../screens/profile_form.dart';
import '../models/item.dart';

class AppRoutes {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        pageBuilder:
            (context, state) => CustomTransitionPage(
              key: state.pageKey,
              child: const Home(),
              transitionsBuilder: (
                context,
                animation,
                secondaryAnimation,
                child,
              ) {
                const begin = Offset(1.0, 0.0);
                const end = Offset.zero;
                const curve = Curves.easeInOut;
                var tween = Tween(
                  begin: begin,
                  end: end,
                ).chain(CurveTween(curve: curve));
                return SlideTransition(
                  position: animation.drive(tween),
                  child: child,
                );
              },
            ),
      ),
      GoRoute(
        path: '/add-item/:topicIndex',
        pageBuilder: (context, state) {
          final topicIndex = int.parse(state.pathParameters['topicIndex']!);
          return CustomTransitionPage(
            key: state.pageKey,
            child: AddItem(topicIndex: topicIndex),
            transitionsBuilder: (
              context,
              animation,
              secondaryAnimation,
              child,
            ) {
              const begin = Offset(1.0, 0.0);
              const end = Offset.zero;
              const curve = Curves.easeInOut;
              var tween = Tween(
                begin: begin,
                end: end,
              ).chain(CurveTween(curve: curve));
              return SlideTransition(
                position: animation.drive(tween),
                child: child,
              );
            },
          );
        },
      ),
      GoRoute(
        path: '/edit-item/:topicIndex/:itemIndex',
        pageBuilder: (context, state) {
          final topicIndex = int.parse(state.pathParameters['topicIndex']!);
          final itemIndex = int.parse(state.pathParameters['itemIndex']!);
          final item = state.extra as Item;
          return CustomTransitionPage(
            key: state.pageKey,
            child: EditItem(
              topicIndex: topicIndex,
              itemIndex: itemIndex,
              item: item,
            ),
            transitionsBuilder: (
              context,
              animation,
              secondaryAnimation,
              child,
            ) {
              const begin = Offset(1.0, 0.0);
              const end = Offset.zero;
              const curve = Curves.easeInOut;
              var tween = Tween(
                begin: begin,
                end: end,
              ).chain(CurveTween(curve: curve));
              return SlideTransition(
                position: animation.drive(tween),
                child: child,
              );
            },
          );
        },
      ),
      GoRoute(
        path: '/add-topic',
        pageBuilder:
            (context, state) => CustomTransitionPage(
              key: state.pageKey,
              child: const AddTopic(),
              transitionsBuilder: (
                context,
                animation,
                secondaryAnimation,
                child,
              ) {
                const begin = Offset(1.0, 0.0);
                const end = Offset.zero;
                const curve = Curves.easeInOut;
                var tween = Tween(
                  begin: begin,
                  end: end,
                ).chain(CurveTween(curve: curve));
                return SlideTransition(
                  position: animation.drive(tween),
                  child: child,
                );
              },
            ),
      ),
      GoRoute(
        path: '/edit-topic/:topicIndex',
        pageBuilder: (context, state) {
          final topicIndex = int.parse(state.pathParameters['topicIndex']!);
          final topicName = state.extra as String;
          return CustomTransitionPage(
            key: state.pageKey,
            child: AddTopic(topicIndex: topicIndex, initialName: topicName),
            transitionsBuilder: (
              context,
              animation,
              secondaryAnimation,
              child,
            ) {
              const begin = Offset(1.0, 0.0);
              const end = Offset.zero;
              const curve = Curves.easeInOut;
              var tween = Tween(
                begin: begin,
                end: end,
              ).chain(CurveTween(curve: curve));
              return SlideTransition(
                position: animation.drive(tween),
                child: child,
              );
            },
          );
        },
      ),
      GoRoute(
        path: '/profile',
        pageBuilder:
            (context, state) => CustomTransitionPage(
              key: state.pageKey,
              child: const ProfileForm(),
              transitionsBuilder: (
                context,
                animation,
                secondaryAnimation,
                child,
              ) {
                const begin = Offset(1.0, 0.0);
                const end = Offset.zero;
                const curve = Curves.easeInOut;
                var tween = Tween(
                  begin: begin,
                  end: end,
                ).chain(CurveTween(curve: curve));
                return SlideTransition(
                  position: animation.drive(tween),
                  child: child,
                );
              },
            ),
      ),
    ],
  );
}
