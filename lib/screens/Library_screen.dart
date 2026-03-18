import 'package:flutter/material.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  String selectedCategory = "All";

  final List<Map<String, dynamic>> lessons = [
    {
      "title": "Introduction to Photosynthesis",
      "category": "Biology",
      "duration": "15 min",
      "progress": 0.75,
    },
    {
      "title": "World War II Timeline",
      "category": "History",
      "duration": "20 min",
      "progress": 1.0,
    },
    {
      "title": "Quadratic Equations",
      "category": "Mathematics",
      "duration": "25 min",
      "progress": 0.30,
    },
    {
      "title": "Cellular Respiration",
      "category": "Biology",
      "duration": "16 min",
      "progress": 0.60,
    },
  ];

  @override
  Widget build(BuildContext context) {
    List filteredLessons = selectedCategory == "All"
        ? lessons
        : lessons.where((l) => l["category"] == selectedCategory).toList();

    return Scaffold(
      backgroundColor: const Color(0xFF0E1116),

      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("My Library"),
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🔍 Search Bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search lessons...",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.grey[900],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          // 🧠 Category Buttons
          SizedBox(
            height: 50,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              children: [
                categoryButton("All"),
                categoryButton("Biology"),
                categoryButton("History"),
                categoryButton("Mathematics"),
              ],
            ),
          ),

          const SizedBox(height: 10),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "${filteredLessons.length} lessons",
              style: const TextStyle(color: Colors.white),
            ),
          ),

          const SizedBox(height: 10),

          // 📚 Lesson List
          Expanded(
            child: ListView.builder(
              itemCount: filteredLessons.length,
              itemBuilder: (context, index) {
                var lesson = filteredLessons[index];
                return lessonCard(lesson);
              },
            ),
          ),
        ],
      ),
    );
  }

  // 🔘 Category Button
  Widget categoryButton(String category) {
    bool isSelected = selectedCategory == category;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected ? Colors.cyan : Colors.grey[800],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        onPressed: () {
          setState(() {
            selectedCategory = category;
          });
        },
        child: Text(
          category,
          style: TextStyle(color: isSelected ? Colors.black : Colors.white),
        ),
      ),
    );
  }

  // 📄 Lesson Card
  Widget lessonCard(Map lesson) {
    return Container(
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            lesson["title"],
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            "${lesson["category"]} • ${lesson["duration"]}",
            style: const TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 10),
          LinearProgressIndicator(
            value: lesson["progress"],
            backgroundColor: Colors.grey[800],
            color: Colors.white,
          ),
          const SizedBox(height: 5),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              "${(lesson["progress"] * 100).toInt()}%",
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
