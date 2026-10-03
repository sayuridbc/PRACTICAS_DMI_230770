import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:yes_no_app/data/yes_no_api.dart';
import 'package:yes_no_app/main.dart';
import 'package:yes_no_app/presentation/screens/messages/messages_screen.dart';
import 'package:yes_no_app/presentation/widgets/shared/message_field_box.dart';

void main() {
  test('replies follow the 40/40/20 ranges and use distinct GIFs', () async {
    const draws = [0, 39, 40, 79, 80, 99];
    const expectedReplies = ['Sí', 'Sí', 'No', 'No', 'Tal vez', 'Tal vez'];
    var drawIndex = 0;
    var requestNumber = 0;
    final api = YesNoApi(
      nextInt: (max) {
        expect(max, 100);
        return draws[drawIndex++];
      },
      client: MockClient((request) async {
        requestNumber++;
        return http.Response(
          jsonEncode({
            'answer': 'no',
            'image': 'https://example.com/$requestNumber.gif',
          }),
          200,
        );
      }),
    );
    addTearDown(api.close);

    final replies = <YesNoReply>[];
    for (final _ in draws) {
      replies.add(await api.getReply());
    }

    expect(replies.map((reply) => reply.text), expectedReplies);
    expect(
      replies.map((reply) => reply.imageUrl).toSet(),
      hasLength(draws.length),
    );
    expect(requestNumber, draws.length);
  });

  testWidgets('message entry opens the existing chat screen', (tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.byType(MessagesScreen), findsOneWidget);
    expect(find.text('Yess Connect'), findsOneWidget);
    expect(find.text('Mensajes'), findsOneWidget);

    await tester.tap(find.byTooltip('Abrir conversación'));
    await tester.pumpAndSettle();

    expect(find.text('Mi amor ♥️'), findsOneWidget);
    expect(find.byType(MessageFieldBox), findsOneWidget);
  });
}
