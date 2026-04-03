import 'package:flutter/material.dart';

// AudioScreen is a StatelessWidget because there is no dynamic data change
class AudioScreen extends StatelessWidget {
  const AudioScreen({super.key});

  @override
  Widget build(BuildContext context) {

    // Main container for the whole screen
    return Container(
      padding: const EdgeInsets.all(16), // space inside container
      color: const Color(0xFF0D1117), // dark background color

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // align content to left
        children: [

          // 🎧 Title Text
          const Text(
            "Audio Explanation",
            style: TextStyle(
              fontSize: 20,
              color: Colors.cyan,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 20), // space

          // ▶️ Audio Player UI Container
          Container(
            padding: const EdgeInsets.all(16),

            // Styling for audio box
            decoration: BoxDecoration(
              color: const Color(0xFF1A2332), // slightly lighter background
              borderRadius: BorderRadius.circular(12), // rounded corners
            ),

            // Row to place icon and text horizontally
            child: const Row(
              children: [

                // Play button icon
                Icon(
                  Icons.play_circle_fill,
                  color: Colors.cyan,
                  size: 40,
                ),

                SizedBox(width: 12), // space between icon and text

                // Text label for button
                Text(
                  "Play Audio Lesson",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),

              ],
            ),
          ),

          const SizedBox(height: 20), // space

          // 📖 Description text
          const Text(
            "Listen to the explanation of photosynthesis and how plants create energy using sunlight.",
            style: TextStyle(
              color: Colors.white70,
              height: 1.5, // line spacing
            ),
          ),
        ],
      ),
    );
  }
}