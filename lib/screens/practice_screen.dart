import 'package:flutter/material.dart';

class PracticeScreen extends StatefulWidget {
  const PracticeScreen({super.key});

  @override
  State<PracticeScreen> createState() => _PracticeScreenState();
}

class _PracticeScreenState extends State<PracticeScreen> {
  final List<String> categories = ['All', 'Biology', 'Mathematics', 'History'];
  String selectedCategory = 'All';

  final modules = [
    {
      'title': 'Photosynthesis Fundamentals',
      'questions': '10 questions',
      'time': '8 min',
      'difficulty': 'Easy',
      'score': 90,
      'progress': 0.9,
    },
    {
      'title': 'Cell Structure & Function',
      'questions': '15 questions',
      'time': '12 min',
      'difficulty': 'Medium',
      'score': 80,
      'progress': 0.8,
    },
    {
      'title': 'Cellular Respiration',
      'questions': '12 questions',
      'time': '10 min',
      'difficulty': 'Medium',
      'score': 76,
      'progress': 0.75,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1117),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 16,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 4),
                      const Text(
                        'Practice & Quizzes',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildStatsRow(),
                      const SizedBox(height: 18),
                      _buildCategoryChips(),
                      const SizedBox(height: 14),
                      ...modules
                          .map((module) => _buildModuleCard(module))
                          .toList(),
                      const SizedBox(height: 90),
                    ],
                  ),
                ),
              ),
            ),
            _buildBottomNav(),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsRow() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF1D293D),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.08)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildStatTile('4', 'Completed', Icons.check_circle_outline),
          _buildStatTile('47', 'Questions', Icons.list_alt),
          _buildStatTile('85', 'Avg Score', Icons.bar_chart),
        ],
      ),
    );
  }

  Widget _buildStatTile(String value, String title, IconData icon) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: const Color(0xFF4FC3F7), size: 16),
              const SizedBox(width: 6),
              Text(
                title,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChips() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: categories.map((item) {
          final selected = selectedCategory == item;
          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: GestureDetector(
              onTap: () => setState(() => selectedCategory = item),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: selected
                      ? const Color(0xFF4FC3F7)
                      : const Color(0xFF1B273A),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: selected
                        ? Colors.transparent
                        : Colors.white.withOpacity(0.15),
                  ),
                ),
                child: Text(
                  item,
                  style: TextStyle(
                    color: selected
                        ? Colors.black
                        : Colors.white.withOpacity(0.85),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildModuleCard(Map<String, dynamic> module) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF131A28),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white.withOpacity(0.09)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  module['title'],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF4FC3F7),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.play_arrow, color: Colors.black),
                  iconSize: 20,
                  padding: const EdgeInsets.all(4),
                  constraints: const BoxConstraints(
                    minWidth: 32,
                    minHeight: 32,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Text(
                module['questions'],
                style: TextStyle(
                  color: Colors.white.withOpacity(0.6),
                  fontSize: 12,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '•',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.6),
                  fontSize: 12,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                module['time'],
                style: TextStyle(
                  color: Colors.white.withOpacity(0.6),
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: module['difficulty'] == 'Easy'
                      ? const Color(0xFFCEEBCF)
                      : const Color(0xFFF4C973),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  module['difficulty'],
                  style: TextStyle(
                    color: module['difficulty'] == 'Easy'
                        ? const Color(0xFF1B4F20)
                        : const Color(0xFF4B2B00),
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const Spacer(),
              Text(
                'Best Score ${module['score']}%',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.75),
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: module['progress'],
              minHeight: 6,
              backgroundColor: Colors.white.withOpacity(0.1),
              valueColor: const AlwaysStoppedAnimation<Color>(
                Color(0xFF4FC3F7),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNav() {
    final items = [
      {'icon': Icons.home, 'label': 'Home', 'route': '/home'},
      {'icon': Icons.menu_book_outlined, 'label': 'Library', 'route': '/home'},
      {'icon': Icons.upload_outlined, 'label': 'Upload', 'route': '/home'},
      {
        'icon': Icons.psychology_outlined,
        'label': 'Practice',
        'route': '/practice',
      },
      {
        'icon': Icons.person_outline_rounded,
        'label': 'Profile',
        'route': '/profile',
      },
    ];

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF0C121E),
        border: Border(
          top: BorderSide(color: Colors.white.withOpacity(0.08), width: 1),
        ),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: items.map((item) {
              final selected = item['label'] == 'Practice';
              return GestureDetector(
                onTap: () {
                  final route = item['route'] as String;
                  if (route == '/home') {
                    Navigator.pushReplacementNamed(context, '/home');
                  } else {
                    Navigator.pushReplacementNamed(context, route);
                  }
                },
                behavior: HitTestBehavior.opaque,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      item['icon'] as IconData,
                      color: selected
                          ? const Color(0xFF4FC3F7)
                          : Colors.white.withOpacity(0.45),
                      size: 22,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item['label'] as String,
                      style: TextStyle(
                        color: selected
                            ? const Color(0xFF4FC3F7)
                            : Colors.white.withOpacity(0.45),
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
