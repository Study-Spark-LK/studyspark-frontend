import 'package:flutter/material.dart';

// VisualScreen is a StatelessWidget because the content is fixed (no dynamic changes)
class VisualScreen extends StatelessWidget {
  const VisualScreen({super.key});

  @override
  Widget build(BuildContext context) {

    // SingleChildScrollView allows vertical scrolling when content is large
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16), // outer padding

      child: Container(
        padding: const EdgeInsets.all(16), // inner padding

        // Styling the container using BoxDecoration
        decoration: BoxDecoration(
          color: const Color(0xFF1A2332), // dark blue background
          borderRadius: BorderRadius.circular(16), // rounded corners
        ),

        // Column used to arrange elements vertically
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start, // align to left
          children: [

            // 📊 Title text
            Text(
              "Visual Learning",
              style: TextStyle(
                color: Colors.cyan,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 12), // spacing

            // 📖 Main content text (structured with line breaks)
            Text(
              // \n used for new lines
              "Photosynthesis Process\n\n"
              "Inputs:\n• Carbon dioxide\n• Water\n• Sunlight\n\n"
              "Outputs:\n• Glucose\n• Oxygen\n\n"
              "Equation:\n6CO₂ + 6H₂O → C₆H₁₂O₆ + 6O₂",
              style: TextStyle(
                color: Colors.white70, // light text color
              ),
            ),
          ],
        ),
      ),
    );
  }
}