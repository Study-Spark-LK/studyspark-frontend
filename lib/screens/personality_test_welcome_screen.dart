import 'package:flutter/material.dart';
import 'dart:math' as math;

class PersonalityTestWelcomeScreen extends StatelessWidget {
  const PersonalityTestWelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 40.0),
          child: Column(
            children: [
              const SizedBox(height: 40),
              
              // Title
              const Text(
                'Hello!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 42,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 1.0,
                ),
              ),
              const SizedBox(height: 16),
              
              // Subtitle
              const Text(
                'Welcome To Your First\nPersonality Test!!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  height: 1.5,
                ),
              ),
              
              const Spacer(),
              
              // Illustration/Image
              Center(
                child: Container(
                  width: 250,
                  height: 250,
                  decoration: BoxDecoration(
                    color: const Color(0xFF2A2A3E),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: CustomPaint(
                    size: const Size(220, 220),
                    painter: LearningIllustrationPainter(),
                  ),
                ),
              ),
              
              const Spacer(),
              
              // "Let's Start" text
              const Text(
                "Let's Start",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 24),
              
              // Start Now Button
              ElevatedButton(
                onPressed: () {
                  // Navigate to home screen (or personality test questions if you create that screen)
                  Navigator.of(context).pushReplacementNamed('/home'); // ← FIXED
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4FC3F7),
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 56),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Start Now',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

// Custom painter for a cute learning illustration
class LearningIllustrationPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;
    final strokePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    final center = Offset(size.width / 2, size.height / 2);

    // Draw book/notebook
    paint.color = const Color(0xFF6C63FF);
    final bookRect = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: Offset(center.dx, center.dy + 20),
        width: 120,
        height: 90,
      ),
      const Radius.circular(8),
    );
    canvas.drawRRect(bookRect, paint);

    // Book pages
    paint.color = Colors.white;
    canvas.drawRect(
      Rect.fromCenter(
        center: Offset(center.dx, center.dy + 20),
        width: 110,
        height: 75,
      ),
      paint,
    );

    // Book spine line
    strokePaint.color = const Color(0xFF6C63FF);
    canvas.drawLine(
      Offset(center.dx, center.dy - 17),
      Offset(center.dx, center.dy + 57),
      strokePaint,
    );

    // Lines on page (left side)
    strokePaint.strokeWidth = 1.5;
    strokePaint.color = Colors.grey[300]!;
    for (int i = 0; i < 4; i++) {
      final y = center.dy + i * 12;
      canvas.drawLine(
        Offset(center.dx - 40, y),
        Offset(center.dx - 10, y),
        strokePaint,
      );
    }

    // Lines on page (right side)
    for (int i = 0; i < 4; i++) {
      final y = center.dy + i * 12;
      canvas.drawLine(
        Offset(center.dx + 10, y),
        Offset(center.dx + 40, y),
        strokePaint,
      );
    }

    // Draw cute character (simple owl on book)
    // Owl body
    paint.color = const Color(0xFFFFD700);
    canvas.drawCircle(
      Offset(center.dx, center.dy - 40),
      35,
      paint,
    );

    // Owl eyes (white background)
    paint.color = Colors.white;
    canvas.drawCircle(Offset(center.dx - 12, center.dy - 45), 12, paint);
    canvas.drawCircle(Offset(center.dx + 12, center.dy - 45), 12, paint);

    // Owl pupils
    paint.color = const Color(0xFF1A1A2E);
    canvas.drawCircle(Offset(center.dx - 12, center.dy - 43), 6, paint);
    canvas.drawCircle(Offset(center.dx + 12, center.dy - 43), 6, paint);

    // Owl beak
    paint.color = const Color(0xFFFFA726);
    final beakPath = Path()
      ..moveTo(center.dx, center.dy - 35)
      ..lineTo(center.dx - 6, center.dy - 28)
      ..lineTo(center.dx + 6, center.dy - 28)
      ..close();
    canvas.drawPath(beakPath, paint);

    // Owl ears/tufts
    paint.color = const Color(0xFFFFD700);
    final leftEarPath = Path()
      ..moveTo(center.dx - 25, center.dy - 70)
      ..lineTo(center.dx - 15, center.dy - 55)
      ..lineTo(center.dx - 20, center.dy - 55)
      ..close();
    canvas.drawPath(leftEarPath, paint);

    final rightEarPath = Path()
      ..moveTo(center.dx + 25, center.dy - 70)
      ..lineTo(center.dx + 15, center.dy - 55)
      ..lineTo(center.dx + 20, center.dy - 55)
      ..close();
    canvas.drawPath(rightEarPath, paint);

    // Draw sparkles around
    paint.color = const Color(0xFF4FC3F7);
    _drawStar(canvas, Offset(center.dx - 70, center.dy - 60), 8, paint);
    _drawStar(canvas, Offset(center.dx + 70, center.dy - 50), 6, paint);
    _drawStar(canvas, Offset(center.dx + 60, center.dy + 30), 7, paint);
    _drawStar(canvas, Offset(center.dx - 65, center.dy + 20), 6, paint);

    paint.color = const Color(0xFFFFD700);
    _drawStar(canvas, Offset(center.dx - 60, center.dy - 30), 5, paint);
    _drawStar(canvas, Offset(center.dx + 65, center.dy - 20), 6, paint);
  }

  void _drawStar(Canvas canvas, Offset center, double size, Paint paint) {
    final path = Path();
    for (int i = 0; i < 5; i++) {
      final angle = (i * 4 * math.pi) / 5 - math.pi / 2;
      final x = center.dx + size * (i % 2 == 0 ? 1 : 0.4) * math.cos(angle);
      final y = center.dy + size * (i % 2 == 0 ? 1 : 0.4) * math.sin(angle);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}