import 'package:flutter/material.dart';
import 'package:yes_no_app/presentation/screens/chat/chat_screen.dart';
import 'package:yes_no_app/presentation/widgets/shared/yess_connect_mark.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  void _openChat(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute<void>(builder: (_) => const ChatScreen()));
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        leadingWidth: 68,
        leading: const Padding(
          padding: EdgeInsets.only(left: 16),
          child: Center(child: YessConnectMark(size: 40)),
        ),
        title: const Text('Yess Connect'),
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 680),
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 28, 20, 24),
              children: [
                Text(
                  'Mensajes',
                  style: Theme.of(context).textTheme.headlineMedium
                      ?.copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 6),
                Text(
                  'Tus conversaciones, en un solo lugar.',
                  style: Theme.of(context).textTheme.bodyLarge
                      ?.copyWith(color: colors.onSurfaceVariant),
                ),
                const SizedBox(height: 24),
                _ConversationTile(onTap: () => _openChat(context)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ConversationTile extends StatefulWidget {
  const _ConversationTile({required this.onTap});

  final VoidCallback onTap;

  @override
  State<_ConversationTile> createState() => _ConversationTileState();
}

class _ConversationTileState extends State<_ConversationTile> {
  bool _isPressed = false;
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Semantics(
      button: true,
      label: 'Abrir conversación con Mi amor',
      child: Tooltip(
        message: 'Abrir conversación',
        child: AnimatedScale(
          scale: _isPressed ? 0.985 : 1,
          duration: const Duration(milliseconds: 140),
          curve: Curves.easeOut,
          child: Material(
            color: colors.surfaceContainerLow,
            borderRadius: BorderRadius.circular(20),
            child: InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: widget.onTap,
              onHover: (isHovered) => setState(() => _isHovered = isHovered),
              onTapDown: (_) => setState(() => _isPressed = true),
              onTapUp: (_) => setState(() => _isPressed = false),
              onTapCancel: () => setState(() => _isPressed = false),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: _isHovered
                        ? colors.primary.withValues(alpha: 0.5)
                        : colors.outlineVariant,
                  ),
                ),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 26,
                      backgroundImage: AssetImage('images/snoopy.jpg'),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Mi amor ♥️',
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Conversación automática',
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(color: colors.onSurfaceVariant),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    const YessConnectMark(size: 44),
                    const SizedBox(width: 4),
                    Icon(Icons.chevron_right, color: colors.onSurfaceVariant),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
