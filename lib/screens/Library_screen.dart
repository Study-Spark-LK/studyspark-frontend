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
    final filteredLessons = selectedCategory == "All"
        ? lessons
        : lessons.where((l) => l["category"] == selectedCategory).toList();

    return SafeArea(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Row(
                children: [
                  const Text(
                    'My Library',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Search bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                style: const TextStyle(color: Colors.white, fontSize: 14),
                decoration: InputDecoration(
                  hintText: 'Search lessons...',
                  hintStyle: const TextStyle(color: Color(0xFF6B7A99), fontSize: 14),
                  prefixIcon: const Icon(Icons.search_rounded,
                      color: Color(0xFF6B7A99), size: 20),
                  filled: true,
                  fillColor: const Color(0xFF161B27),
                  contentPadding: const EdgeInsets.symmetric(vertical: 14),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFF1E2A3A), width: 1),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFF1E2A3A), width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFF6C63FF), width: 1),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Category chips
            SizedBox(
              height: 36,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  _categoryChip("All"),
                  _categoryChip("Biology"),
                  _categoryChip("History"),
                  _categoryChip("Mathematics"),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Count label
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                '${filteredLessons.length} lesson${filteredLessons.length == 1 ? '' : 's'}',
                style: const TextStyle(color: Color(0xFF6B7A99), fontSize: 13),
              ),
            ),

            const SizedBox(height: 12),

            // List
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: filteredLessons.length,
                itemBuilder: (context, index) =>
                    _lessonCard(filteredLessons[index]),
              ),
            ),
          ],
        ),
      );
  }

  Widget _categoryChip(String category) {
    final isSelected = selectedCategory == category;
    return GestureDetector(
      onTap: () => setState(() => selectedCategory = category),
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF6C63FF)
              : const Color(0xFF161B27),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF6C63FF)
                : const Color(0xFF1E2A3A),
            width: 1,
          ),
        ),
        child: Text(
          category,
          style: TextStyle(
            color: isSelected ? Colors.white : const Color(0xFF6B7A99),
            fontSize: 12,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _lessonCard(Map lesson) {
    final progress = (lesson["progress"] as double);
    final pct = (progress * 100).toInt();
    final isComplete = progress >= 1.0;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF161B27),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF1E2A3A), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  lesson["title"],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: isComplete
                      ? const Color(0xFF43C59E).withValues(alpha: 0.15)
                      : const Color(0xFF6C63FF).withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  isComplete ? 'Done' : '$pct%',
                  style: TextStyle(
                    color: isComplete
                        ? const Color(0xFF43C59E)
                        : const Color(0xFF6C63FF),
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            '${lesson["category"]} • ${lesson["duration"]}',
            style: const TextStyle(color: Color(0xFF6B7A99), fontSize: 12),
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: const Color(0xFF1E2A3A),
              valueColor: AlwaysStoppedAnimation<Color>(
                isComplete ? const Color(0xFF43C59E) : const Color(0xFF6C63FF),
              ),
              minHeight: 5,
            ),
          ),
        ],
      ),
    );
  }

}

