import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'questionnaire_screen.dart';

class QuestionnaireWelcomeScreen extends StatelessWidget {
  const QuestionnaireWelcomeScreen({super.key});

  @override

  // Build method to construct the UI of the questionnaire welcome screen
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1117),
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          // Layer 1 — decorative background circles
          Positioned(
            top: -80,
            right: -80,
            child: Container(
              width: 250,
              height: 250,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [Color(0x206C63FF), Colors.transparent],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -60,
            left: -60,
            child: Container(
              width: 200,
              height: 200,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [Color(0x154FC3F7), Colors.transparent],
                ),
              ),
            ),
          ),

          // Layer 2 — main content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // TOP SECTION
                  Padding(
                    padding: const EdgeInsets.only(top: 48),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Discover Your',
                          style: TextStyle(
                            color: Color(0xFF6B7A99),
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Learning Style',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.w700,
                            letterSpacing: -1,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Container(
                          width: 48,
                          height: 4,
                          decoration: const BoxDecoration(
                            color: Color(0xFF6C63FF),
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // MIDDLE SECTION
                  Center(
                    child: Container(
                      width: 280,
                      height: 280,
                      decoration: BoxDecoration(
                        color: const Color(0xFF161B27),
                        borderRadius: BorderRadius.circular(32),
                        border: Border.all(
                          color: const Color(0xFF1E2A3A),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomPaint(
                            size: const Size(160, 160),
                            painter: LearningIllustrationPainter(),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            '8 Quick Questions',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 6),
                          const Text(
                            'We will personalise your\nlearning experience',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF6B7A99),
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // BOTTOM SECTION
                  Padding(
                    padding: const EdgeInsets.only(bottom: 40),
                    child: Column(
                      children: [
                        // Feature chips row
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _FeatureChip(
                              icon: Icons.speed,
                              label: 'Quick',
                            ),
                            _FeatureChip(
                              icon: Icons.psychology,
                              label: 'Smart',
                            ),
                            _FeatureChip(
                              icon: Icons.star_outline,
                              label: 'Personal',
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        // Start Assessment button
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const PersonalityTestQuestionnaireScreen(),
                              ),
                            );
                          },
                          child: Container(
                            width: double.infinity,
                            height: 56,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFF6C63FF), Color(0xFF4FC3F7)],
                              ),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Start Assessment',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(width: 8),
                                Icon(
                                  Icons.arrow_forward,
                                  color: Colors.white,
                                  size: 18,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FeatureChip extends StatelessWidget {
  const _FeatureChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF161B27),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFF1E2A3A)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: const Color(0xFF6C63FF), size: 14),
          const SizedBox(width: 4),
          Text(
            label,
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
        ],
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

    // Sparkles
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
