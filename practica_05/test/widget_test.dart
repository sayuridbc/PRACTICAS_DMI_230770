import 'package:flutter_test/flutter_test.dart';
import 'package:practica_05/main.dart';

void main() {
  testWidgets('app loads the home screen', (WidgetTester tester) async {
    await tester.pumpWidget(const MainApp());

    expect(find.text('Flutter + Material 3'), findsOneWidget);
    expect(find.text('Botones'), findsOneWidget);
    expect(find.text('Tarjetas'), findsOneWidget);
  });
}
