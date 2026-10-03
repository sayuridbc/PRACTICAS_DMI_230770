import 'package:flutter/material.dart';

class YessConnectMark extends StatelessWidget {
  const YessConnectMark({super.key, this.size = 44});

  final double size;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return SizedBox.square(
      dimension: size,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: colors.primary,
          borderRadius: BorderRadius.circular(size * 0.32),
        ),
        child: CustomPaint(
          painter: _YessConnectPainter(
            foreground: colors.onPrimary,
            accent: const Color(0xFFFFC857),
          ),
        ),
      ),
    );
  }
}

class _YessConnectPainter extends CustomPainter {
  const _YessConnectPainter({required this.foreground, required this.accent});

  final Color foreground;
  final Color accent;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.save();
    canvas.scale(size.width / 100, size.height / 100);

    final bubble = Path()
      ..moveTo(31, 18)
      ..lineTo(68, 18)
      ..cubicTo(79, 18, 86, 26, 86, 37)
      ..lineTo(86, 51)
      ..cubicTo(86, 62, 78, 70, 67, 70)
      ..lineTo(44, 70)
      ..lineTo(28, 82)
      ..lineTo(31, 69)
      ..cubicTo(21, 67, 14, 60, 14, 50)
      ..lineTo(14, 38)
      ..cubicTo(14, 26, 21, 18, 31, 18)
      ..close();

    final outline = Paint()
      ..color = foreground
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    canvas.drawPath(bubble, outline);

    final link = Paint()
      ..color = foreground
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(const Offset(38, 45), const Offset(62, 45), link);
    canvas.drawCircle(const Offset(36, 45), 6, Paint()..color = foreground);
    canvas.drawCircle(const Offset(64, 45), 6, Paint()..color = foreground);

    final sparkle = Paint()
      ..color = accent
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(const Offset(76, 12), const Offset(76, 25), sparkle);
    canvas.drawLine(
      const Offset(69.5, 18.5),
      const Offset(82.5, 18.5),
      sparkle,
    );

    canvas.restore();
  }

  @override
  bool shouldRepaint(_YessConnectPainter oldDelegate) =>
      foreground != oldDelegate.foreground || accent != oldDelegate.accent;
}
