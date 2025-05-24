import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:soft_list/blocs/topic/topic_bloc.dart';
import 'package:soft_list/models/item.dart';
import 'package:soft_list/widgets/item_tile.dart';

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

  testWidgets('ItemTile displays item name, price, and checkbox', (
    tester,
  ) async {
    const item = Item(name: 'Maçã', price: 2.5, checked: false);

    await tester.pumpWidget(
      buildTestableWidget(ItemTile(item: item, onTap: () {})),
    );

    expect(find.text('Maçã'), findsOneWidget);
    expect(find.text('R\$ 2.50'), findsOneWidget);
    expect(find.byType(Checkbox), findsOneWidget);
    expect(tester.widget<Checkbox>(find.byType(Checkbox)).value, false);
  });

  testWidgets('ItemTile triggers onTap when tapped', (tester) async {
    const item = Item(name: 'Maçã', price: 2.5, checked: false);
    bool wasTapped = false;

    await tester.pumpWidget(
      buildTestableWidget(ItemTile(item: item, onTap: () => wasTapped = true)),
    );

    await tester.tap(find.byType(ListTile));
    await tester.pump();

    expect(wasTapped, true);
  });

  testWidgets('ItemTile triggers onTap when checkbox is tapped', (
    tester,
  ) async {
    const item = Item(name: 'Maçã', price: 2.5, checked: false);
    bool wasTapped = false;

    await tester.pumpWidget(
      buildTestableWidget(ItemTile(item: item, onTap: () => wasTapped = true)),
    );

    await tester.tap(find.byType(Checkbox));
    await tester.pump();

    expect(wasTapped, true);
  });
}
