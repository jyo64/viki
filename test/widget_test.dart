import 'package:flutter_test/flutter_test.dart';

import 'package:viki/main.dart';

void main() {
  testWidgets('Main menu renders', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Viki'), findsOneWidget);
  });
}
