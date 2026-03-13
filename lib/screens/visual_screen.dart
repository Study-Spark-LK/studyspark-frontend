import 'package:flutter/material.dart';

class VisualScreen extends StatelessWidget {
  const VisualScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF1A2332),
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Visual Learning",
              style: TextStyle(
                color: Colors.cyan,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 12),
            Text(
              "Photosynthesis Process\n\n"
              "Inputs:\n• Carbon dioxide\n• Water\n• Sunlight\n\n"
              "Outputs:\n• Glucose\n• Oxygen\n\n"
              "Equation:\n6CO₂ + 6H₂O → C₆H₁₂O₆ + 6O₂",
              style: TextStyle(color: Colors.white70),
            ),
          ],
        ),
      ),
    );
  }
}
