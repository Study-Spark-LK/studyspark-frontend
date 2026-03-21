import 'package:flutter/material.dart';

class AIChatScreen extends StatefulWidget {
  const AIChatScreen({super.key});

  @override
  State<AIChatScreen> createState() => _AIChatScreenState();
}

class _AIChatScreenState extends State<AIChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<_ChatMessage> _messages = [
    const _ChatMessage(
      text:
          "Hi! I'm your AI study assistant. I can help you understand the lesson better. Feel free to ask me any questions!",
      isBot: true,
    ),
  ];

  void _sendMessage(String text) {
    if (text.trim().isEmpty) return;
    setState(() {
      _messages.add(_ChatMessage(text: text.trim(), isBot: false));
      _controller.clear();
    });
    // Canned bot response
    Future.delayed(const Duration(milliseconds: 600), () {
      if (!mounted) return;
      setState(() {
        _messages.add(const _ChatMessage(
          text:
              "Great question! AI-powered responses are coming soon. For now, use the flashcard quiz to test your knowledge on this topic.",
          isBot: true,
        ));
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E293B),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('AI Study Assistant',
                style: TextStyle(color: Colors.white, fontSize: 15)),
            Text(
              'Chat about this lesson',
              style: TextStyle(
                  color: Color(0xFF6B7A99), fontSize: 11),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // Messages
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, i) =>
                  _buildBubble(_messages[i]),
            ),
          ),

          // Suggested chips (only show at start)
          if (_messages.length <= 1)
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Wrap(
                spacing: 8,
                runSpacing: 4,
                children: [
                  _chip('Can you explain the main concept?'),
                  _chip('Give me an example'),
                  _chip('How does this work?'),
                ],
              ),
            ),

          // Input box
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    style: const TextStyle(color: Colors.white),
                    onSubmitted: _sendMessage,
                    decoration: InputDecoration(
                      hintText: 'Ask me anything about this lesson...',
                      hintStyle:
                          const TextStyle(color: Color(0xFF6B7A99)),
                      filled: true,
                      fillColor: const Color(0xFF1E293B),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF6C63FF),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.white),
                    onPressed: () => _sendMessage(_controller.text),
                  ),
                ),
              ],
            ),
          ),

          const Padding(
            padding: EdgeInsets.only(bottom: 12),
            child: Text(
              'Powered by AI · Personalized for your learning style',
              style:
                  TextStyle(color: Color(0xFF6B7A99), fontSize: 11),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBubble(_ChatMessage msg) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment:
            msg.isBot ? MainAxisAlignment.start : MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (msg.isBot) ...[
            const CircleAvatar(
              radius: 16,
              backgroundColor: Color(0xFF6C63FF),
              child: Icon(Icons.smart_toy, color: Colors.white, size: 16),
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: msg.isBot
                    ? const Color(0xFF1E293B)
                    : const Color(0xFF6C63FF),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                msg.text,
                style: TextStyle(
                  color: msg.isBot
                      ? Colors.white.withValues(alpha: 0.9)
                      : Colors.white,
                  fontSize: 14,
                  height: 1.4,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _chip(String text) {
    return GestureDetector(
      onTap: () => _sendMessage(text),
      child: Container(
        padding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: const Color(0xFF1E293B),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFF6C63FF).withValues(alpha: 0.4)),
        ),
        child: Text(
          text,
          style: const TextStyle(
              color: Color(0xFF6B7A99), fontSize: 12),
        ),
      ),
    );
  }
}

class _ChatMessage {
  final String text;
  final bool isBot;
  const _ChatMessage({required this.text, required this.isBot});
}
