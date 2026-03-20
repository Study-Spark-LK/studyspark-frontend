import 'package:flutter/material.dart';

class OutputresultScreen extends StatefulWidget {
  const OutputresultScreen({super.key});

  @override
  State<OutputresultScreen> createState() => _OutputresultScreenState();
}

class _OutputresultScreenState extends State<OutputresultScreen> {
  int selectedType = 0;

  final types = ["Visual", "Audio", "Analytical", "Story"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1117),

      appBar: AppBar(
        backgroundColor: const Color(0xFF1A2332),
        title: const Text("Upload Learning Material"),
        leading: const BackButton(),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// SUBJECT
            const Text(
              "Biology",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),

            const SizedBox(height: 12),

            /// TYPE SELECTOR
            Row(
              children: List.generate(types.length, (index) {
                return Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() => selectedType = index);
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: selectedType == index
                            ? const Color(0xFF4FC3F7)
                            : const Color(0xFF1A2332),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          types[index],
                          style: TextStyle(
                            color: selectedType == index
                                ? Colors.black
                                : Colors.white70,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),

            const SizedBox(height: 20),

            /// HOBBY CONNECTION CARD
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF1A2332),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Connected to your hobby: Photography",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    "This lesson includes examples related to Photography to help you learn better!",
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            /// CONTENT PREVIEW
            _buildContent(),

            const SizedBox(height: 20),

            /// UPLOAD BUTTON
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Take Quiz")),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4FC3F7),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  "Take Quiz",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ================= CONTENT =================

  Widget _buildContent() {
    switch (selectedType) {
      case 0:
        return _visual();
      case 1:
        return _audio();
      case 2:
        return _analytical();
      case 3:
        return _story();
      default:
        return Container();
    }
  }

  Widget _visual() {
    return _infoCard("Visual Infographic", [
      _step("Location", "Chloroplasts in plant cells", 1),
      _step("Inputs", "CO₂ + H₂O + Light Energy", 2),
      _step("Outputs", "Glucose (C₆H₁₂O₆) + O₂", 3),
      _step("Formula", "6CO₂ + 6H₂O + Light → C₆H₁₂O₆ + 6O₂", 4),
    ]);
  }

  Widget _audio() {
    return _infoCard("Audio Material", [
      const Row(
        children: [
          Icon(Icons.play_circle_fill, color: Color(0xFF4FC3F7), size: 40),
          SizedBox(width: 10),
          Text("Audio Preview", style: TextStyle(color: Colors.white)),
        ],
      ),
    ]);
  }

  Widget _analytical() {
    return _infoCard("Analytical Content", const [
      Text(
        "Photosynthesis converts light energy into chemical energy.",
        style: TextStyle(color: Colors.white70),
      ),
    ]);
  }

  Widget _story() {
    return _infoCard("Story Based Learning", const [
      Text(
        "Imagine leaves as solar panels converting sunlight into food...",
        style: TextStyle(color: Colors.white70),
      ),
    ]);
  }

  // ================= COMMON =================

  Widget _infoCard(String title, List<Widget> children) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1A2332),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFF4FC3F7),
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          ...children,
        ],
      ),
    );
  }

  Widget _step(String title, String value, int number) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF0D1117),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: const Color(0xFF4FC3F7),
            child: Text("$number"),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(color: Colors.white54)),
              Text(value, style: const TextStyle(color: Colors.white)),
            ],
          ),
        ],
      ),
    );
  }
}