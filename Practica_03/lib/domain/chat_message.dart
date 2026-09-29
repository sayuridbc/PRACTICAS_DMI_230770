import 'dart:math';

class ChatMessage {
  final String text;
  final bool isUser;
  final DateTime sentAt;

  const ChatMessage({
    required this.text,
    required this.isUser,
    required this.sentAt,
  });

  String get formattedTime {
    final hour = sentAt.hour.toString().padLeft(2, '0');
    final minute = sentAt.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }
}

class ChatReplyGenerator {
  ChatReplyGenerator._();

  static final Random _random = Random();

  static String generateReply() {
    final randomValue = _random.nextInt(100);

    if (randomValue < 40) return 'Sí';
    if (randomValue < 80) return 'No';
    return 'Tal vez';
  }
}
