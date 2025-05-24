import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:soft_list/blocs/topic/topic_bloc.dart';
import 'package:soft_list/models/topic.dart';
import 'package:soft_list/screens/home.dart';
import 'package:soft_list/widgets/topic_card.dart';

class MockTopicBloc extends Mock implements TopicBloc {}

void main() {
  late MockTopicBloc mockTopicBloc;

  setUp(() {
    mockTopicBloc = MockTopicBloc();
  });

  Widget buildTestableWidget(Widget widget) {
    return MaterialApp(
      home: BlocProvider<TopicBloc>.value(value: mockTopicBloc, child: widget),
    );
  }

  testWidgets('HomeScreen shows loading indicator when TopicLoading', (
    tester,
  ) async {
    when(mockTopicBloc.state).thenReturn(const TopicLoading());

    await tester.pumpWidget(buildTestableWidget(const HomeScreen()));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('HomeScreen shows topics when TopicLoaded', (tester) async {
    final topics = [Topic(name: 'Mercado', items: [])];
    when(mockTopicBloc.state).thenReturn(TopicLoaded(topics));

    await tester.pumpWidget(buildTestableWidget(const HomeScreen()));

    expect(find.byType(TopicCard), findsOneWidget);
    expect(find.text('Mercado'), findsOneWidget);
  });

  testWidgets('HomeScreen shows error snackbar when TopicError', (
    tester,
  ) async {
    when(mockTopicBloc.state).thenReturn(const TopicError('Error'));

    await tester.pumpWidget(buildTestableWidget(const HomeScreen()));
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Error'), findsOneWidget);
  });
}
