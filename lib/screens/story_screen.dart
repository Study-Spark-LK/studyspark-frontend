import 'package:flutter/material.dart';

class StoryScreen extends StatelessWidget {
  const StoryScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),

      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: const Color(0xFFFFF7E6),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFFFFC74D)),
        ),

        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(
              "Story Based Learning",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange),
            ),

            SizedBox(height: 12),

            Text(
              "Meet Lily, a young oak tree in a forest.\n\n"
              "Every morning Lily wakes up and begins her daily routine "
              "of making food through photosynthesis.\n\n"
              "Her leaves absorb sunlight while roots absorb water "
              "and stomata absorb carbon dioxide.\n\n"
              "Inside her leaves chlorophyll captures light energy "
              "and produces glucose.\n\n"
              "As a gift Lily releases oxygen into the air.",
              style: TextStyle(height: 1.5),
            )
          ],
        ),
      ),
    );
  }
}