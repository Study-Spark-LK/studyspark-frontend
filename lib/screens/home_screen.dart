import 'package:flutter/material.dart';
import 'package:studyspark/api/api_client.dart';
import 'package:clerk_flutter/clerk_flutter.dart';

class UploadedLesson {
  final String title;
  final String subject;
  final String estimatedTime;
  final double progress;
  final String fileType; // 'pdf', 'video', 'doc', etc.

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

  @override
  void initState() {
    super.initState();

    fetchClerkToken = () async {
      return ClerkAuth.of(context).session?.lastActiveToken?.jwt;
    };
  }



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

  void testBackend() async {
    try {
      final response = await apiClient.profiles.getProfiles();
      print("response $response");
    } catch (e) {
      print('API Error: $e');
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

  List<UploadedLesson> get _lessons => LessonRepository.lessons;

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
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 24),
                      _buildWelcomeHeader(),
                      const SizedBox(height: 20),
                      _buildLearningStyleCard(),
                      const SizedBox(height: 24),
                      _buildStatsRow(),
                      const SizedBox(height: 28),
                      _buildSectionTitle('Continue Learning'),
                      const SizedBox(height: 16),
                      _lessons.isEmpty
                          ? _buildEmptyLearning()
                          : Column(
                              children: _lessons.map(_buildLessonCard).toList(),
                            ),
                      const SizedBox(height: 28),
                      _buildSectionTitle('Quick Actions'),
                      const SizedBox(height: 16),
                      _buildQuickActions(),
                      const SizedBox(height: 32),
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

  //Welcome Header
  Widget _buildWelcomeHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Welcome back,',
          style: TextStyle(
            color: Colors.white.withOpacity(0.65),
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          _userName,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.3,
          ),
        ),
      ],
    );
  }

  // Learning Style Card
  Widget _buildLearningStyleCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF1A2332),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.07), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: const Color(0xFF1E3A5F),
                  borderRadius: BorderRadius.circular(22),
                ),
                child: const Icon(
                  Icons.remove_red_eye_outlined,
                  color: Color(0xFF4FC3F7),
                  size: 22,
                ),
              ),
              const SizedBox(width: 14),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Your Learning Style',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.55),
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    _learningStyle,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 14),
            child: Divider(color: Colors.white.withOpacity(0.1), height: 1),
          ),
          Text(
            'Personalizing with your interests:',
            style: TextStyle(
              color: Colors.white.withOpacity(0.55),
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 10),
          _interests.isEmpty
              ? Text(
                  'No interests selected yet',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.35),
                    fontSize: 12,
                  ),
                )
              : Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _interests
                      .map(
                        (interest) => Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF0D1117),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.12),
                              width: 1,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                _getInterestIcon(interest),
                                size: 14,
                                color: const Color(0xFF4FC3F7),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                interest,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                      .toList(),
                ),
        ],
      ),
    );
  }

  IconData _getInterestIcon(String interest) {
    switch (interest.toLowerCase()) {
      case 'photography':
        return Icons.camera_alt_outlined;
      case 'gaming':
        return Icons.sports_esports_outlined;
      case 'cooking':
        return Icons.restaurant_outlined;
      case 'music':
        return Icons.music_note_outlined;
      case 'fitness':
        return Icons.fitness_center_outlined;
      case 'art & drawing':
        return Icons.palette_outlined;
      case 'reading':
        return Icons.menu_book_outlined;
      case 'sports':
        return Icons.sports_soccer_outlined;
      case 'gardening':
        return Icons.eco_outlined;
      case 'technology':
        return Icons.computer_outlined;
      case 'travel':
        return Icons.flight_outlined;
      case 'movies & tv':
        return Icons.movie_outlined;
      case 'writing':
        return Icons.edit_outlined;
      case 'finance':
        return Icons.attach_money_outlined;
      case 'crafts':
        return Icons.construction_outlined;
      case 'science':
        return Icons.science_outlined;
      default:
        return Icons.interests_outlined;
    }
  }

  //Stats Row
  //Stats Row
  Widget _buildStatsRow() {
    final completed = _lessons.where((l) => l.progress >= 1.0).length;
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            icon: Icons.circle_outlined,
            iconColor: const Color(0xFF4FC3F7),
            bgColor: const Color(0xFFD6F0FF),
            label: 'Lessons\nCompleted',
            value: '$completed',
            cardBg: const Color(0xFFB8E4FF),
            textColor: const Color(0xFF1A2332),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatCard(
            icon: Icons.trending_up_rounded,
            iconColor: const Color(0xFF4CAF50),
            bgColor: const Color(0xFFE8F5E9),
            label: 'Streak',
            value: '0d',
            cardBg: const Color(0xFFD4EDDA),
            textColor: const Color(0xFF1A2332),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatCard(
            icon: Icons.access_time_rounded,
            iconColor: const Color(0xFFFFB74D),
            bgColor: const Color(0xFFFFF3E0),
            label: 'Study Time',
            value: '0h 0m',
            cardBg: const Color(0xFFFFE0B2),
            textColor: const Color(0xFF1A2332),
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required Color iconColor,
    required Color bgColor,
    required String label,
    required String value,
    required Color cardBg,
    required Color textColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(17),
            ),
            child: Icon(icon, color: iconColor, size: 18),
          ),
          const SizedBox(height: 10),
          Text(
            label,
            style: TextStyle(
              color: textColor.withValues(alpha: 0.6),
              fontSize: 11,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: TextStyle(
              color: textColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  //Section Title
  Widget _buildSectionTitle(String title) => Text(title,
      style: const TextStyle(
          color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700));

  // Empty State
  Widget _buildEmptyLearning() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
      decoration: BoxDecoration(
        color: const Color(0xFF1A2332),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFF4FC3F7).withOpacity(0.15),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: const Color(0xFF4FC3F7).withOpacity(0.1),
              borderRadius: BorderRadius.circular(36),
              border: Border.all(
                color: const Color(0xFF4FC3F7).withOpacity(0.3),
                width: 2,
              ),
            ),
            child: const Icon(
              Icons.upload_file_outlined,
              color: Color(0xFF4FC3F7),
              size: 32,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'No content yet',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Upload your study materials — PDFs, notes,\nor documents — and they\'ll appear here.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white.withOpacity(0.5),
              fontSize: 13,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: 180,
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, '/upload');
                setState(() => _selectedIndex = 2);
              },
              icon: const Icon(Icons.add, size: 18),
              label: const Text('Upload Content',
                  style: TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w600)),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4FC3F7),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                elevation: 0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Lesson Card
  Widget _buildLessonCard(UploadedLesson lesson) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF1A2E44), Color(0xFF0F1E2E)],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFF4FC3F7).withOpacity(0.25),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  lesson.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: const Color(0xFF4FC3F7).withOpacity(0.15),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  lesson.fileType.toUpperCase(),
                  style: const TextStyle(
                    color: Color(0xFF4FC3F7),
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Text(
                lesson.subject,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.55),
                  fontSize: 13,
                ),
              ),
              Text(
                '  •  ',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.35),
                  fontSize: 13,
                ),
              ),
              const Icon(
                Icons.access_time_rounded,
                size: 13,
                color: Color(0xFF4FC3F7),
              ),
              const SizedBox(width: 4),
              Text(
                lesson.estimatedTime,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.55),
                  fontSize: 13,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Progress',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.55),
                  fontSize: 12,
                ),
              ),
              Text(
                lesson.progressLabel,
                style: const TextStyle(
                  color: Color(0xFF4FC3F7),
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: lesson.progress,
              backgroundColor: Colors.white.withOpacity(0.1),
              valueColor: const AlwaysStoppedAnimation<Color>(
                Color(0xFF4FC3F7),
              ),
              minHeight: 5,
            ),
          ),
        ],
      ),
    );
  }

  //Quick Actions
  //Quick Actions
  Widget _buildQuickActions() {
    final actions = [
      {'icon': Icons.menu_book_outlined, 'label': 'Library', 'index': 1},
      {'icon': Icons.upload_outlined, 'label': 'Upload', 'index': 2},
      {'icon': Icons.psychology_outlined, 'label': 'Practice', 'index': 3},
    ];

    return Row(
      children: List.generate(actions.length, (i) {
        final a = actions[i];
        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(right: i < actions.length - 1 ? 12 : 0),
            child: GestureDetector(
              onTap: () {
                if (a['index'] == 1) {
                  Navigator.pushNamed(context, '/library');
                }else if (a['index'] == 2) {
                  Navigator.pushNamed(context, '/upload');
                } else if (a['index'] == 3) {
                  Navigator.pushNamed(context, '/practice');
                } else {
                  setState(() => _selectedIndex = a['index'] as int);
                }
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 22),
                decoration: BoxDecoration(
                  color: const Color(0xFF1A2332),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: const Color(0xFF4FC3F7).withOpacity(0.2),
                    width: 1,
                  ),
                ),
                child: Column(
                  children: [
                    Icon(
                      a['icon'] as IconData,
                      color: const Color(0xFF4FC3F7),
                      size: 32,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      a['label'] as String,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  // Bottom Navigation
  // Bottom Navigation
  Widget _buildBottomNav() {
    final items = [
      {'icon': Icons.home_rounded, 'label': 'Home'},
      {'icon': Icons.menu_book_outlined, 'label': 'Library'},
      {'icon': Icons.upload_outlined, 'label': 'Upload'},
      {'icon': Icons.psychology_outlined, 'label': 'Practice'},
      {'icon': Icons.person_outline_rounded, 'label': 'Profile'},
    ];

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF0D1117),
        border: Border(
          top: BorderSide(color: Colors.white.withOpacity(0.08), width: 1),
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
                  if (index == 0) {
                    Navigator.pushNamed(context, '/home');
                  } else if (index == 1) {
                    Navigator.pushNamed(context, '/library');
                  }else if (index == 2) {
                    Navigator.pushNamed(context, '/upload');
                  } else if (index == 3) {
                    Navigator.pushNamed(context, '/practice');
                  } else if (index == 4) {
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
                            : Colors.white.withOpacity(0.4),
                        size: 26,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        items[index]['label'] as String,
                        style: TextStyle(
                          color: isSelected
                              ? const Color(0xFF4FC3F7)
                              : Colors.white.withOpacity(0.4),
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
