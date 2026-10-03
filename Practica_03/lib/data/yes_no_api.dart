import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;

class YesNoReply {
  final String text;
  final String imageUrl;

  const YesNoReply({required this.text, required this.imageUrl});
}

class YesNoApi {
  YesNoApi({http.Client? client, int Function(int max)? nextInt})
    : _client = client ?? http.Client(),
      _nextInt = nextInt ?? Random().nextInt;

  final http.Client _client;
  final int Function(int max) _nextInt;
  static const _endpoint = 'https://yesno.wtf/api';
  static const _maxAttempts = 10;
  static final Set<String> _usedImageUrls = {};

  void close() => _client.close();

  Future<YesNoReply> getReply() async {
    for (var attempt = 0; attempt < _maxAttempts; attempt++) {
      final requestUri = Uri.parse(_endpoint).replace(
        queryParameters: {
          'request': DateTime.now().microsecondsSinceEpoch.toString(),
        },
      );
      final response = await _client
          .get(requestUri)
          .timeout(const Duration(seconds: 10));

      if (response.statusCode != 200) {
        throw Exception('La API respondió con código ${response.statusCode}.');
      }

      final data = jsonDecode(response.body) as Map<String, dynamic>;
      final imageUrl = data['image'] as String?;

      if (imageUrl == null) {
        throw const FormatException('La respuesta de la API está incompleta.');
      }

      if (_usedImageUrls.add(imageUrl)) {
        return YesNoReply(
          text: switch (_nextInt(100)) {
            < 40 => 'Sí',
            < 80 => 'No',
            _ => 'Tal vez',
          },
          imageUrl: imageUrl,
        );
      }
    }

    throw Exception('No se encontró un GIF nuevo. Intenta de nuevo.');
  }
}
