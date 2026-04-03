import 'package:flutter/material.dart';

// AnalyticalScreen is a StatelessWidget
// because the content is static (no dynamic changes or user interaction)
class AnalyticalScreen extends StatelessWidget {
  const AnalyticalScreen({super.key});

  @override
  Widget build(BuildContext context) {

    // SingleChildScrollView allows scrolling when content overflows screen
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16), // outer spacing

      child: Container(
        padding: const EdgeInsets.all(16), // inner spacing

        // BoxDecoration used to style the container
        decoration: BoxDecoration(
          color: const Color(0xFFE8F0FE), // light blue background
          borderRadius: BorderRadius.circular(16), // rounded corners
        ),

        // Column to arrange text vertically
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start, // align text to left
          children: [

            // Title of the section
            Text(
              "Structured Analysis",
              style: TextStyle(
                fontSize: 18, // font size
                fontWeight: FontWeight.bold, // bold text
                color: Colors.blue, // text color
              ),
            ),

            // Space between title and content
            SizedBox(height: 12),

            // Main content text (multi-line string)
            Text(
              // \n used for new lines
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