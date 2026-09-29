import 'package:flutter/material.dart';
import 'package:yes_no_app/domain/chat_message.dart';
import 'package:yes_no_app/presentation/widgets/chat/her_message_bubble.dart';
import 'package:yes_no_app/presentation/widgets/chat/my_message_bubble.dart';
import 'package:yes_no_app/presentation/widgets/shared/message_field_box.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ScrollController _scrollController = ScrollController();

  final List<ChatMessage> _messages = [
    ChatMessage(
      text: 'Holi como estas',
      isUser: false,
      sentAt: DateTime.now().subtract(const Duration(minutes: 2)),
    ),
    ChatMessage(
      text: 'holii muy bien',
      isUser: true,
      sentAt: DateTime.now().subtract(const Duration(minutes: 1)),
    ),
  ];

  void _sendMessage(String text) {
    final userMessage = ChatMessage(
      text: text,
      isUser: true,
      sentAt: DateTime.now(),
    );

    setState(() {
      _messages.add(userMessage);
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });

    Future.delayed(const Duration(milliseconds: 350), () {
      if (!mounted) return;

      final reply = ChatReplyGenerator.generateReply();
      final responseMessage = ChatMessage(
        text: reply,
        isUser: false,
        sentAt: DateTime.now(),
      );

      setState(() {
        _messages.add(responseMessage);
      });

      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_scrollController.hasClients) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.all(4.0),
          child: CircleAvatar(
            backgroundImage: AssetImage(
              'images/snoopy.jpg',
            ),
          ),
        ),
        title: const Text('Mi amor ♥️'),
        centerTitle: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: _messages.length,
                  itemBuilder: (context, index) {
                    final message = _messages[index];
                    return message.isUser
                        ? MyMessageBubble(message: message)
                        : HerMessageBubble(message: message);
                  },
                ),
              ),
              MessageFieldBox(onSubmitted: _sendMessage),
            ],
          ),
        ),
      ),
    );
  }
}