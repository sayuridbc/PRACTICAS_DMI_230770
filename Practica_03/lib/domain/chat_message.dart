class ChatMessage {
  final String text;
  final bool isUser;
  final DateTime sentAt;
  final String? imageUrl;

  const ChatMessage({
    required this.text,
    required this.isUser,
    required this.sentAt,
    this.imageUrl,
  });

  String get formattedTime {
    final hour = sentAt.hour.toString().padLeft(2, '0');
    final minute = sentAt.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }
}
