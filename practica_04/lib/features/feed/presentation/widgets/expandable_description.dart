import 'package:flutter/material.dart';

class ExpandableDescription extends StatefulWidget {
  final String text;
  final int maxLines;

  const ExpandableDescription({
    super.key,
    required this.text,
    this.maxLines = 3,
  });

  @override
  State<ExpandableDescription> createState() => _ExpandableDescriptionState();
}

class _ExpandableDescriptionState extends State<ExpandableDescription> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(
      color: Colors.white,
      fontWeight: FontWeight.w500,
    );

    return GestureDetector(
      onTap: () => setState(() => _expanded = !_expanded),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        child: Text(
          widget.text,
          key: ValueKey<bool>(_expanded),
          maxLines: _expanded ? null : widget.maxLines,
          overflow: _expanded ? TextOverflow.visible : TextOverflow.ellipsis,
          style: textStyle,
        ),
      ),
    );
  }
}
