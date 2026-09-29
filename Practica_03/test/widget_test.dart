import 'package:flutter_test/flutter_test.dart';

import 'package:yes_no_app/domain/chat_message.dart';
import 'package:yes_no_app/main.dart';
import 'package:yes_no_app/presentation/widgets/shared/message_field_box.dart';

void main() {
  test('chat reply generator uses the required distribution', () {
    final results = List.generate(500, (_) => ChatReplyGenerator.generateReply());

    final yesCount = results.where((value) => value == 'Sí').length;
    final noCount = results.where((value) => value == 'No').length;
    final maybeCount = results.where((value) => value == 'Tal vez').length;

    expect(yesCount, inInclusiveRange(180, 220));
    expect(noCount, inInclusiveRange(180, 220));
    expect(maybeCount, inInclusiveRange(60, 140));
  });

  testWidgets('app builds the chat screen with the input box', (tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Mi amor ♥️'), findsOneWidget);
    expect(find.byType(MessageFieldBox), findsOneWidget);
  });
}
