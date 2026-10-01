import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:yes_no_app/data/yes_no_api.dart';
import 'package:yes_no_app/main.dart';
import 'package:yes_no_app/presentation/widgets/shared/message_field_box.dart';

void main() {
  test(
    'API provides a translated reply and a distinct GIF per request',
    () async {
      var requestNumber = 0;
      final api = YesNoApi(
        client: MockClient((request) async {
          requestNumber++;
          return http.Response(
            jsonEncode({
              'answer': 'yes',
              'image': 'https://example.com/$requestNumber.gif',
            }),
            200,
          );
        }),
      );
      addTearDown(api.close);

      final firstReply = await api.getReply();
      final secondReply = await api.getReply();

      expect(firstReply.text, 'Sí');
      expect(firstReply.imageUrl, isNot(secondReply.imageUrl));
      expect(requestNumber, 2);
    },
  );

  testWidgets('app builds the chat screen with the input box', (tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Mi amor ♥️'), findsOneWidget);
    expect(find.byType(MessageFieldBox), findsOneWidget);
  });
}
