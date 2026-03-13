import 'package:flutter/material.dart';

class AnalyticalScreen extends StatelessWidget {
  const AnalyticalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFE8F0FE),
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(
              "Structured Analysis",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue),
            ),

            SizedBox(height: 12),

            Text(
              "1. Definition\n"
              "Photosynthesis converts light energy into chemical energy.\n\n"

              "2. Location\n"
              "Occurs inside chloroplasts.\n\n"

              "3. Equation\n"
              "6CO₂ + 6H₂O → C₆H₁₂O₆ + 6O₂\n\n"

              "4. Stages\n"
              "• Light-dependent reactions\n"
              "• Calvin Cycle\n\n"

              "5. Products\n"
              "• Glucose\n"
              "• Oxygen",
            )
          ],
        ),
      ),
    );
  }
}