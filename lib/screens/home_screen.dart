import 'package:flutter/material.dart';

class UploadedLesson {
  final String title;
  final String subject;
  final String estimatedTime;
  final double progress;
  final String fileType;

  const UploadedLesson({
    required this.title,
    required this.subject,
    required this.estimatedTime,
    required this.progress,
    required this.fileType,
  });

  String get progressLabel => '${(progress * 100).round()}%';
}

class LessonRepository {
  static final List<UploadedLesson> lessons = [];

  static void addLesson(UploadedLesson lesson) => lessons.add(lesson);

  static void updateProgress(String title, double progress) {
    final i = lessons.indexWhere((l) => l.title == title);
    if (i != -1) {
      final old = lessons[i];
      lessons[i] = UploadedLesson(
        title: old.title,
        subject: old.subject,
        estimatedTime: old.estimatedTime,
        progress: progress,
        fileType: old.fileType,
      );
    }
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  String _userName = 'User';
  String _learningStyle = 'Visual Learner';
  List<String> _interests = [];

  List<UploadedLesson> get _lessons => LessonRepository.lessons;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments;

    if (args != null && args is Map<String, dynamic>) {
      setState(() {
        _userName = args['name'] ?? 'User';
        _learningStyle = _determineLearningStyle(args['learningPreference']);
        final interests = args['interests'] as List<dynamic>?;
        if (interests != null && interests.isNotEmpty) {
          _interests = interests.cast<String>().take(3).toList();
        }
      });
    }
  }

  String _determineLearningStyle(String? pref) {
    switch (pref) {
      case 'visual':
        return 'Visual Learner';
      case 'auditory':
        return 'Auditory Learner';
      case 'reading':
        return 'Reading/Writing Learner';
      case 'kinesthetic':
        return 'Kinesthetic Learner';
      default:
        return 'Visual Learner';
    }
  }

  @override
  Widget build(BuildContext context) {
    final completed = _lessons.where((l) => l.progress >= 1.0).length;

    return Scaffold(
      backgroundColor: const Color(0xFF0D1117),

      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24),

                    Text(
                      'Welcome back,',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.6),
                        fontSize: 16,
                      ),
                    ),

                    Text(
                      _userName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 20),

                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1A2332),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Your Learning Style",
                            style: TextStyle(color: Colors.white70),
                          ),

                          Text(
                            _learningStyle,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 10),

                          Wrap(
                            spacing: 8,
                            children: _interests
                                .map(
                                  (i) => Chip(
                                    label: Text(i),
                                    backgroundColor: const Color(0xFF0D1117),
                                    labelStyle: const TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    Text(
                      "Lessons Completed: $completed",
                      style: const TextStyle(color: Colors.white),
                    ),

                    const SizedBox(height: 24),

                    _lessons.isEmpty
                        ? const Text(
                            "No lessons uploaded yet",
                            style: TextStyle(color: Colors.white70),
                          )
                        : Column(
                            children: _lessons.map(_buildLessonCard).toList(),
                          ),

                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),

            _buildBottomNav(),
          ],
        ),
      ),
    );
  }

  Widget _buildLessonCard(UploadedLesson lesson) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1A2332),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            lesson.title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          LinearProgressIndicator(value: lesson.progress),

          Text(
            lesson.progressLabel,
            style: const TextStyle(color: Colors.white70),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNav() {
    final items = [
      {'icon': Icons.home, 'label': 'Home'},
      {'icon': Icons.menu_book, 'label': 'Library'},
      {'icon': Icons.upload, 'label': 'Upload'},
      {'icon': Icons.psychology, 'label': 'Progress'},
      {'icon': Icons.person, 'label': 'Profile'},
    ];

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF0D1117),
        border: Border(
          top: BorderSide(
            color: Colors.white.withValues(alpha: 0.08),
            width: 1,
          ),
        ),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 64,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(items.length, (index) {
              final isSelected = _selectedIndex == index;
              return GestureDetector(
                onTap: () {
                  setState(() => _selectedIndex = index);
                  if (index == 4) {
                    Navigator.pushNamed(context, '/profile');
                  }
                },
                behavior: HitTestBehavior.opaque,
                child: SizedBox(
                  width: 64,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        items[index]['icon'] as IconData,
                        color: isSelected
                            ? const Color(0xFF4FC3F7)
                            : Colors.white.withValues(alpha: 0.4),
                        size: 26,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        items[index]['label'] as String,
                        style: TextStyle(
                          color: isSelected
                              ? const Color(0xFF4FC3F7)
                              : Colors.white.withValues(alpha: 0.4),
                          fontSize: 10,
                          fontWeight: isSelected
                              ? FontWeight.w600
                              : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
