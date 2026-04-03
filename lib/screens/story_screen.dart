import 'package:flutter/material.dart';

// StoryScreen is a StatelessWidget because content does not change dynamically
class StoryScreen extends StatelessWidget {
  const StoryScreen({super.key});

  @override
  Widget build(BuildContext context) {

    // Scroll view allows content to scroll if it overflows the screen
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16), // outer spacing

      child: Container(
        padding: const EdgeInsets.all(18), // inner spacing

        // Styling the container
        decoration: BoxDecoration(
          color: const Color(0xFFFFF7E6), // light yellow background
          borderRadius: BorderRadius.circular(14), // rounded corners
          border: Border.all(
            color: const Color(0xFFFFC74D), // border color
          ),
        ),

        // Column arranges elements vertically
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start, // align left
          children: [

            // 📖 Title text
            Text(
              "Story Based Learning",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.orange,
              ),
            ),

            SizedBox(height: 12), // spacing

            // 📚 Story content (multi-line text)
            Text(
              // \n used for line breaks
              "Meet Lily, a young oak tree in a forest.\n\n"
              "Every morning Lily wakes up and begins her daily routine "
              "of making food through photosynthesis.\n\n"
              "Her leaves absorb sunlight while roots absorb water "
              "and stomata absorb carbon dioxide.\n\n"
              "Inside her leaves chlorophyll captures light energy "
              "and produces glucose.\n\n"
              "As a gift Lily releases oxygen into the air.",
              
              style: TextStyle(
                height: 1.5, // line spacing for readability
              ),
            )
          ],
        ),
      ),
    );
  }
}