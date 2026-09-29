import 'package:flutter/material.dart';

class MessageFieldBox extends StatefulWidget {
  final ValueChanged<String> onSubmitted;

  const MessageFieldBox({
    super.key,
    required this.onSubmitted,
  });

  @override
  State<MessageFieldBox> createState() => _MessageFieldBoxState();
}

class _MessageFieldBoxState extends State<MessageFieldBox> {
  final TextEditingController _textController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  void _submit() {
    final textValue = _textController.text.trim();
    if (textValue.isEmpty) return;

    widget.onSubmitted(textValue);
    _textController.clear();
    _focusNode.requestFocus();
  }

  @override
  void dispose() {
    _textController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final outlineInputBorder = UnderlineInputBorder(
      borderSide: const BorderSide(color: Colors.transparent),
      borderRadius: BorderRadius.circular(40),
    );

    final inputDecoration = InputDecoration(
      hintText: 'Escribe tu mensaje',
      enabledBorder: outlineInputBorder,
      focusedBorder: outlineInputBorder,
      filled: true,
      suffixIcon: IconButton(
        icon: const Icon(Icons.send_outlined),
        onPressed: _submit,
      ),
    );

    return TextFormField(
      onTapOutside: (_) => _focusNode.unfocus(),
      focusNode: _focusNode,
      controller: _textController,
      decoration: inputDecoration,
      onFieldSubmitted: (_) => _submit(),
    );
  }
}