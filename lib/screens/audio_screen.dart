import 'package:flutter/material.dart';

class AudioScreen extends StatelessWidget {
  const AudioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: const Color(0xFF0D1117),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          const Text(
            "Audio Explanation",
            style: TextStyle(
              fontSize: 20,
              color: Colors.cyan,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 20),

          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF1A2332),
              borderRadius: BorderRadius.circular(12),
            ),

            child: const Row(
              children: [

                Icon(
                  Icons.play_circle_fill,
                  color: Colors.cyan,
                  size: 40,
                ),

                SizedBox(width: 12),

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

          const SizedBox(height: 20),

          const Text(
            "Listen to the explanation of photosynthesis and how plants create energy using sunlight.",
            style: TextStyle(
              color: Colors.white70,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}