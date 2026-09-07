import 'package:flutter_test/flutter_test.dart';

import 'package:todo_list_getx/app/my_app.dart';

void main() {
  testWidgets('App renders home view', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('To-Do List'), findsOneWidget);
    expect(find.text('No tasks yet'), findsOneWidget);
  });
}
