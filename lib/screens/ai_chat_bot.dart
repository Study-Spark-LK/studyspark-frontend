import 'package:flutter/material.dart';

class AIChatScreen extends StatelessWidget {
  const AIChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E293B),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("AI Study Assistant"),
            Text(
              "Chat about this lesson",
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
      body: Column(
        children: [

          /// Chat message
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  backgroundColor: Colors.cyan,
                  child: Icon(Icons.smart_toy, color: Colors.white),
                ),
                const SizedBox(width: 10),
                Container(
                  padding: const EdgeInsets.all(14),
                  width: MediaQuery.of(context).size.width * 0.65,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Text(
                    "Hi user 👋 I'm your AI study assistant. I can help you understand the lesson in this topic better. Feel free to ask me any questions!",
                  ),
                )
              ],
            ),
          ),

          const Spacer(),

          /// Suggested questions
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Suggested questions:",
                style: TextStyle(color: Colors.white70),
              ),
            ),
          ),

          const SizedBox(height: 10),

          Wrap(
            spacing: 8,
            children: [
              suggestionChip("Can you explain the main concept?"),
              suggestionChip("Give me an example"),
              suggestionChip("How does this work?"),
              suggestionChip("What's the formula?"),
            ],
          ),

          const SizedBox(height: 15),

          /// Input box
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Ask me anything about this lesson...",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.teal,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.white),
                    onPressed: () {},
                  ),
                )
              ],
            ),
          ),

          const Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: Column(
              children: [
                Text(
                  "⚙ Powered by AI - Personalized for your learning style",
                  style: TextStyle(color: Colors.white54, fontSize: 12),
                ),
                SizedBox(height: 4),
                Text(
                  "🔒 5 messages remaining",
                  style: TextStyle(color: Colors.white54, fontSize: 12),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  static Widget suggestionChip(String text) {
    return Chip(
      backgroundColor: Colors.white,
      label: Text(text),
    );
  }
}