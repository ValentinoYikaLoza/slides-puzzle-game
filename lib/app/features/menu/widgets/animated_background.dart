import 'package:flutter/material.dart';

class AnimatedBackground extends StatelessWidget {
  const AnimatedBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.blue.shade50,
            Colors.green.shade50
          ], // Light pastel gradient
        ),
      ),
      child: AnimatedContainer(
        duration: const Duration(seconds: 10),
        curve: Curves.linear,
        onEnd: () {
          // Restart the animation
        },
        child: CustomPaint(
          painter: BackgroundPainter(),
        ),
      ),
    );
  }
}

class BackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue.shade300.withOpacity(0.1)
      ..style = PaintingStyle.fill;

    // Draw puzzle piece shapes
    for (int i = 0; i < 10; i++) {
      final x = size.width * (i / 10);
      final y = size.height * (i / 10);
      canvas.drawCircle(Offset(x, y), 500, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}