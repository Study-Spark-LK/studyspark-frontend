import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isDarkMode = true;

  final String userName = 'Aloka';
  final String userEmail = 'aloka@gmail.com';
  final String learningStyle = 'Visual Learner';
  final String learningStyleDescription =
      'You learn best through images and diagrams';
  final List<String> hobbies = ['Photography', 'Gaming', 'Cooking'];

  final Map<String, int> learningModalities = {
    'Visual': 8,
    'Auditory': 5,
    'Analytical': 9,
    'Story-Driven': 7,
  };

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
          children: [
            // Top Navigation Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  const Expanded(
                    child: Center(
                      child: Text(
                        'My Profile',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 48), // Balance for back button
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Profile Section
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF0f1419),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  // Avatar
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: const Color(0xFF2dd4bf),
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.person,
                        size: 40,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  // User Name
                  Text(
                    userName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  // User Email
                  Text(
                    userEmail,
                    style: const TextStyle(
                      color: Color(0xFF8b92a0),
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Appearance Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Appearance',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0f1419),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Light Mode',
                          style: TextStyle(
                            color: Color(0xFF8b92a0),
                            fontSize: 14,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isDarkMode = !isDarkMode;
                            });
                          },
                          child: Container(
                            width: 50,
                            height: 28,
                            decoration: BoxDecoration(
                              color: isDarkMode
                                  ? const Color(0xFF2dd4bf)
                                  : const Color(0xFF404854),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Align(
                              alignment: isDarkMode
                                  ? Alignment.centerRight
                                  : Alignment.centerLeft,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4),
                                child: Container(
                                  width: 24,
                                  height: 24,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Learning Profile Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Learning Profile',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0f1419),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: const Color(0xFF2dd4bf),
                                shape: BoxShape.circle,
                              ),
                              child: const Center(
                                child: Icon(
                                  Icons.visibility,
                                  size: 24,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    learningStyle,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    learningStyleDescription,
                                    style: const TextStyle(
                                      color: Color(0xFF8b92a0),
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        // Learning Modalities Progress Bars
                        ..._buildLearningModalities(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Your Hobbies Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Your Hobbies',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0f1419),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: hobbies
                              .map((hobby) => _buildHobbyTag(hobby))
                              .toList(),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'We use your hobbies to create personalized learning content that connects with your interests',
                          style: TextStyle(
                            color: Color(0xFF8b92a0),
                            fontSize: 12,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Retake Learning Style Quiz Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFF0f1419),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFF2dd4bf)),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.refresh,
                      color: Color(0xFF2dd4bf),
                      size: 20,
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Text(
                        'Retake Learning Style Quiz',
                        style: TextStyle(
                          color: Color(0xFF2dd4bf),
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios,
                      color: Color(0xFF2dd4bf),
                      size: 16,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Sign Out Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFF0f1419),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFff6b6b)),
                ),
                child: Center(
                  child: GestureDetector(
                    onTap: () {
                      // Handle sign out logic
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          backgroundColor: const Color(0xFF1a1f2e),
                          title: const Text(
                            'Sign Out',
                            style: TextStyle(color: Colors.white),
                          ),
                          content: const Text(
                            'Are you sure you want to sign out?',
                            style: TextStyle(color: Color(0xFF8b92a0)),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Cancel',
                                  style: TextStyle(color: Color(0xFF2dd4bf))),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                // Navigate to login screen
                              },
                              child: const Text('Sign Out',
                                  style: TextStyle(color: Color(0xFFff6b6b))),
                            ),
                          ],
                        ),
                      );
                    },
                    child: const Text(
                      'Sign Out',
                      style: TextStyle(
                        color: Color(0xFFff6b6b),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      );
  }

  List<Widget> _buildLearningModalities() {
    return learningModalities.entries.map((entry) {
      final String modality = entry.key;
      final int score = entry.value;
      final double percentage = score / 10;

      Color? iconColor;
      IconData icon;

      switch (modality) {
        case 'Visual':
          icon = Icons.visibility;
          iconColor = const Color(0xFF2dd4bf);
          break;
        case 'Auditory':
          icon = Icons.volume_up;
          iconColor = const Color(0xFFffd60a);
          break;
        case 'Analytical':
          icon = Icons.analytics;
          iconColor = const Color(0xFF8466ff);
          break;
        case 'Story-Driven':
          icon = Icons.menu_book;
          iconColor = const Color(0xFFff6b6b);
          break;
        default:
          icon = Icons.help;
          iconColor = Colors.grey;
      }

      return Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Row(
          children: [
            Icon(
              icon,
              size: 20,
              color: iconColor,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    modality,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: percentage,
                      minHeight: 6,
                      backgroundColor: const Color(0xFF404854),
                      valueColor: AlwaysStoppedAnimation<Color>(iconColor!),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Text(
              '$score/15',
              style: const TextStyle(
                color: Color(0xFF8b92a0),
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      );
    }).toList();
  }

  Widget _buildHobbyTag(String hobby) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFF2dd4bf).withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFF2dd4bf),
          width: 1,
        ),
      ),
      child: Text(
        hobby,
        style: const TextStyle(
          color: Color(0xFF2dd4bf),
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
