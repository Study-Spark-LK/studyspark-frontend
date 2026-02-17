import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  // This will later come from shared preferences or passed via route args
  // For now pulling from route arguments, fallback to 'User'
  String _userName = 'User';
  String _learningStyle = 'Visual Learner';
  List<String> _interests = ['Photography', 'Gaming', 'Cooking'];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Try to get name passed as argument from questionnaire
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

  final List<Map<String, dynamic>> _continueLearning = [
    {
      'title': 'Introduction to Photosynthesis',
      'subject': 'Biology',
      'time': '15 min',
      'progress': 0.75,
      'progressLabel': '75%',
    },
    {
      'title': 'Quadratic Equations',
      'subject': 'Mathematics',
      'time': '25 min',
      'progress': 0.30,
      'progressLabel': '30%',
    },
    {
      'title': 'Nervous System',
      'subject': 'Biology',
      'time': '35 min',
      'progress': 0.45,
      'progressLabel': '45%',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1117),
      body: SafeArea(
        child: Column(
          children: [
            // Scrollable body
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 24),

                      // ── Welcome Header ──
                      _buildWelcomeHeader(),
                      const SizedBox(height: 20),

                      // ── Learning Style Card ──
                      _buildLearningStyleCard(),
                      const SizedBox(height: 24),

                      // ── Stats Row ──
                      _buildStatsRow(),
                      const SizedBox(height: 28),

                      // ── Continue Learning ──
                      _buildSectionTitle('Continue Learning'),
                      const SizedBox(height: 16),
                      ..._continueLearning
                          .map((lesson) => _buildLessonCard(lesson))
                          .toList(),
                      const SizedBox(height: 28),

                      // ── Quick Actions ──
                      _buildSectionTitle('Quick Actions'),
                      const SizedBox(height: 16),
                      _buildQuickActions(),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            ),

            // ── Bottom Navigation ──
            _buildBottomNav(),
          ],
        ),
      ),
    );
  }

  // ─────────────────────────────────────────────
  // Welcome Header
  // ─────────────────────────────────────────────
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

  // ─────────────────────────────────────────────
  // Learning Style Card
  // ─────────────────────────────────────────────
  Widget _buildLearningStyleCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF1A2332),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withOpacity(0.07),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Learning style row
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

          // Divider
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 14),
            child: Divider(
              color: Colors.white.withOpacity(0.1),
              height: 1,
            ),
          ),

          // Personalizing row
          Text(
            'Personalizing with your interests:',
            style: TextStyle(
              color: Colors.white.withOpacity(0.55),
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 10),

          // Interest chips
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _interests.map((interest) {
              return Container(
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
              );
            }).toList(),
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

  // ─────────────────────────────────────────────
  // Stats Row
  // ─────────────────────────────────────────────
  Widget _buildStatsRow() {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            icon: Icons.circle_outlined,
            iconColor: const Color(0xFF4FC3F7),
            bgColor: const Color(0xFFD6F0FF),
            label: 'Lessons\nCompleted',
            value: '6',
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
            value: '5d',
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
            value: '8h 30m',
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
              color: textColor.withOpacity(0.65),
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

  // ─────────────────────────────────────────────
  // Section Title
  // ─────────────────────────────────────────────
  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  // ─────────────────────────────────────────────
  // Lesson Card
  // ─────────────────────────────────────────────
  Widget _buildLessonCard(Map<String, dynamic> lesson) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF1A2E44),
            Color(0xFF0F1E2E),
          ],
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
          // Title
          Text(
            lesson['title'],
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 6),

          // Subject & time
          Row(
            children: [
              Text(
                lesson['subject'],
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
                lesson['time'],
                style: TextStyle(
                  color: Colors.white.withOpacity(0.55),
                  fontSize: 13,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Progress row
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
                lesson['progressLabel'],
                style: const TextStyle(
                  color: Color(0xFF4FC3F7),
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Progress bar
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: lesson['progress'],
              backgroundColor: Colors.white.withOpacity(0.1),
              valueColor:
                  const AlwaysStoppedAnimation<Color>(Color(0xFF4FC3F7)),
              minHeight: 5,
            ),
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────
  // Quick Actions
  // ─────────────────────────────────────────────
  Widget _buildQuickActions() {
    final actions = [
      {
        'icon': Icons.menu_book_outlined,
        'label': 'Library',
        'route': '/library',
      },
      {
        'icon': Icons.upload_outlined,
        'label': 'Upload',
        'route': '/upload',
      },
      {
        'icon': Icons.psychology_outlined,
        'label': 'Practice',
        'route': '/practice',
      },
    ];

    return Row(
      children: actions.map((action) {
        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(
              right: action == actions.last ? 0 : 12,
            ),
            child: GestureDetector(
              onTap: () {
                // Navigate to respective screens when built
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
                      action['icon'] as IconData,
                      color: const Color(0xFF4FC3F7),
                      size: 32,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      action['label'] as String,
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
      }).toList(),
    );
  }

  // ─────────────────────────────────────────────
  // Bottom Navigation
  // ─────────────────────────────────────────────
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
          top: BorderSide(
            color: Colors.white.withOpacity(0.08),
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
                onTap: () => setState(() => _selectedIndex = index),
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