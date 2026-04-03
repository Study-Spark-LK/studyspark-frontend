import 'package:flutter/material.dart';

// LibraryScreen is StatefulWidget because UI updates when user selects category
class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

// State class to manage dynamic data (category selection)
class _LibraryScreenState extends State<LibraryScreen> {

  // Variable to store selected category (default = "All")
  String selectedCategory = "All";

  // List of lesson data (stored as Map objects)
  final List<Map<String, dynamic>> lessons = [
    {
      "title": "Introduction to Photosynthesis",
      "category": "Biology",
      "duration": "15 min",
      "progress": 0.75, // 75% completed
    },
    {
      "title": "World War II Timeline",
      "category": "History",
      "duration": "20 min",
      "progress": 1.0, // 100% completed
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

    // Filter lessons depending on selected category
    List filteredLessons = selectedCategory == "All"
        ? lessons // show all lessons
        : lessons.where((l) => l["category"] == selectedCategory).toList();

    return Scaffold(
      backgroundColor: const Color(0xFF0E1116), // set dark background color

      // AppBar at the top
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("My Library"),
      ),

      // Main body layout
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // 🔍 Search bar (UI only, not functional)
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search lessons...",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.grey[900],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12), // rounded edges
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          // 🧠 Category buttons (horizontal scroll view)
          SizedBox(
            height: 50,
            child: ListView(
              scrollDirection: Axis.horizontal, // horizontal scrolling
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

          // Show number of lessons after filtering
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "${filteredLessons.length} lessons",
              style: const TextStyle(color: Colors.white),
            ),
          ),

          const SizedBox(height: 10),

          // 📚 List of lessons using ListView.builder
          Expanded(
            child: ListView.builder(
              itemCount: filteredLessons.length, // number of items
              itemBuilder: (context, index) {
                var lesson = filteredLessons[index];
                return lessonCard(lesson); // build each lesson card
              },
            ),
          ),
        ],
      ),
    );
  }

  // 🔘 Method to create category buttons
  Widget categoryButton(String category) {

    // Check if this button is currently selected
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

        // When button is pressed, update category using setState()
        onPressed: () {
          setState(() {
            selectedCategory = category; // update state
          });
        },

        child: Text(
          category,
          style: TextStyle(
            color: isSelected ? Colors.black : Colors.white,
          ),
        ),
      ),
    );
  }

  // 📄 Method to build each lesson card
  Widget lessonCard(Map lesson) {
    return Container(
      margin: const EdgeInsets.all(12), // outer spacing
      padding: const EdgeInsets.all(16), // inner spacing

      // Card design
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(16),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // Lesson title
          Text(
            lesson["title"],
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 5),

          // Display category and duration
          Text(
            "${lesson["category"]} • ${lesson["duration"]}",
            style: const TextStyle(color: Colors.grey),
          ),

          const SizedBox(height: 10),

          // Progress bar (value between 0 and 1)
          LinearProgressIndicator(
            value: lesson["progress"],
            backgroundColor: Colors.grey[800],
            color: Colors.white,
          ),

          const SizedBox(height: 5),

          // Show progress percentage
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