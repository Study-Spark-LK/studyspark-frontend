import 'package:flutter/material.dart';
import '../api/api_client.dart';
import '../api/models/profiles_request_body.dart';
import 'package:studyspark/api/models/qna.dart';
import 'package:clerk_flutter/clerk_flutter.dart';
import 'dart:convert';

class PersonalityTestQuestionnaireScreen extends StatefulWidget {
  const PersonalityTestQuestionnaireScreen({super.key});

  @override
  State<PersonalityTestQuestionnaireScreen> createState() =>
      _PersonalityTestQuestionnaireScreenState();
}

class _PersonalityTestQuestionnaireScreenState
    extends State<PersonalityTestQuestionnaireScreen> {
  int currentStep = 0;
  final int totalSteps = 8;

  @override
  void initState() {
    super.initState();

    fetchClerkToken = () async {
      return ClerkAuth.of(context).session?.lastActiveToken?.jwt;
    };
  }

  // Store answers for each question
  Map<String, dynamic> answers = {
    'question1': null,
    'question2': null,
    'question3': null,
    'question4': null,
    'question5': null,
    'question6': null,
    'question7': null,
    'interests': <String>[],
  };

  final Map<String, String> _questionTexts = {
    'learningPreference': 'When learning something new, I prefer to:',
    'informationRetention': 'I remember information best when:',
    'interestCreation': 'A topic becomes interesting to me when:',
    'interests': 'Mark your interests to create personalized learning content',
    'contentConsumption': 'Content consumption preferences',
  };

  final TextEditingController _customInterestController =
      TextEditingController();

  @override
  void dispose() {
    _customInterestController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(child: _buildCurrentStep()),
            _buildNavigationButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  if (currentStep > 0) {
                    setState(() => currentStep--);
                  } else {
                    Navigator.pop(context);
                  }
                },
              ),
              const Spacer(),
              Text(
                'Step ${currentStep + 1} of $totalSteps',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              const SizedBox(width: 48),
            ],
          ),
          const SizedBox(height: 16),
          LinearProgressIndicator(
            value: (currentStep + 1) / totalSteps,
            backgroundColor: const Color(0xFF2A2A3E),
            valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF4FC3F7)),
            minHeight: 8,
          ),
        ],
      ),
    );
  }

  Widget _buildCurrentStep() {
    switch (currentStep) {
      case 0:
        return _buildQuestion1();
      case 1:
        return _buildQuestion2();
      case 2:
        return _buildQuestion3();
      case 3:
        return _buildQuestion4();
      case 4:
        return _buildQuestion5();
      case 5:
        return _buildQuestion6();
      case 6:
        return _buildQuestion7();
      case 7:
        return _buildQuestion8();
      default:
        return Container();
    }
  }

  // Question 1
  Widget _buildQuestion1() {
    return _buildSingleSelectQuestion(
      questionNumber: '1 of 7',
      questionText: 'I prefer a presenter or teacher who uses:',
      options: [
        {
          'text':
              'Question and answer, talk, group discussion, or guest speakers',
          'value': 'auditory',
        },
        {
          'text': 'Demonstrations, models, or practical sessions',
          'value': 'kinesthetic',
        },
        {'text': 'Diagrams, charts, maps, or graphs', 'value': 'visual'},
        {'text': 'Handouts, books, or readings', 'value': 'reading'},
      ],
      selectedValue: answers['question1'],
      onSelect: (value) => setState(() => answers['question1'] = value),
    );
  }

  // Question 2
  Widget _buildQuestion2() {
    return _buildSingleSelectQuestion(
      questionNumber: '2 of 7',
      questionText:
          'I am assembling a piece of furniture that came in parts. I would:',
      options: [
        {'text': 'Follow the step-by-step diagrams', 'value': 'visual'},
        {
          'text': 'Follow the step-by-step written instructions',
          'value': 'reading',
        },
        {
          'text': 'Lay the parts out to see how they fit together',
          'value': 'kinesthetic',
        },
        {'text': 'Ask for advice from someone else', 'value': 'auditory'},
      ],
      selectedValue: answers['question2'],
      onSelect: (value) => setState(() => answers['question2'] = value),
    );
  }

  // Question 3
  Widget _buildQuestion3() {
    return _buildSingleSelectQuestion(
      questionNumber: '3 of 7',
      questionText: 'When I am learning, I:',
      options: [
        {'text': 'Use examples and applications', 'value': 'kinesthetic'},
        {'text': 'Read books, articles, and handouts', 'value': 'reading'},
        {'text': 'Like to talk things through', 'value': 'auditory'},
        {'text': 'See patterns in things', 'value': 'visual'},
      ],
      selectedValue: answers['question3'],
      onSelect: (value) => setState(() => answers['question3'] = value),
    );
  }

  // Question 4
  Widget _buildQuestion4() {
    return _buildSingleSelectQuestion(
      questionNumber: '4 of 7',
      questionText:
          'A website has a video showing how to make a special graph or chart. I would learn most from:',
      options: [
        {'text': 'Reading the words', 'value': 'reading'},
        {'text': 'Seeing the diagrams', 'value': 'visual'},
        {'text': 'Listening', 'value': 'auditory'},
        {'text': 'Watching the actions', 'value': 'kinesthetic'},
      ],
      selectedValue: answers['question4'],
      onSelect: (value) => setState(() => answers['question4'] = value),
    );
  }

  // Question 5
  Widget _buildQuestion5() {
    return _buildSingleSelectQuestion(
      questionNumber: '5 of 7',
      questionText:
          'I want to learn how to play a new board game or card game. I would:',
      options: [
        {
          'text': 'Watch others play the game before joining in',
          'value': 'visual',
        },
        {'text': 'Read the instructions', 'value': 'reading'},
        {
          'text': 'Listen to somebody explaining it and ask questions',
          'value': 'auditory',
        },
        {
          'text':
              'Use the diagrams that explain the stages, moves, and strategies',
          'value': 'kinesthetic',
        },
      ],
      selectedValue: answers['question5'],
      onSelect: (value) => setState(() => answers['question5'] = value),
    );
  }

  // Question 6
  Widget _buildQuestion6() {
    return _buildSingleSelectQuestion(
      questionNumber: '6 of 7',
      questionText: 'I want to learn how to take better photos. I would:',
      options: [
        {
          'text':
              'Use examples of good and poor photos showing how to improve them',
          'value': 'kinesthetic',
        },
        {
          'text': 'Use diagrams showing the camera and what each part does',
          'value': 'visual',
        },
        {
          'text': 'Ask questions and talk about the camera and its features',
          'value': 'auditory',
        },
        {
          'text': 'Use the written instructions about what to do',
          'value': 'reading',
        },
      ],
      selectedValue: answers['question6'],
      onSelect: (value) => setState(() => answers['question6'] = value),
    );
  }

  // Question 7
  Widget _buildQuestion7() {
    return _buildSingleSelectQuestion(
      questionNumber: '7 of 7',
      questionText:
          'I want to learn to do something new on a computer. I would:',
      options: [
        {
          'text': 'Talk with people who know about the program',
          'value': 'auditory',
        },
        {
          'text': 'Read the written instructions that came with the program',
          'value': 'reading',
        },
        {'text': 'Follow the diagrams in a book', 'value': 'visual'},
        {
          'text': 'Start using it and learn by trial and error',
          'value': 'kinesthetic',
        },
      ],
      selectedValue: answers['question7'],
      onSelect: (value) => setState(() => answers['question7'] = value),
    );
  }

  // Question 8: Hobby selection
  Widget _buildQuestion8() {
    final interests = [
      'Photography',
      'Gaming',
      'Cooking',
      'Music',
      'Fitness',
      'Art & Drawing',
      'Reading',
      'Sports',
      'Gardening',
      'Technology',
      'Travel',
      'Movies & TV',
      'Writing',
      'Finance',
      'Crafts',
      'Science',
      'Dancing',
    ];

    return _buildMultiSelectQuestion(
      stepLabel: 'Step 3 of 3',
      questionText:
          "We'll use your interests to create personalized\nlearning content",
      options: interests,
      selectedValues: answers['interests'] as List<String>,
      onToggle: (value) {
        setState(() {
          List<String> current = List<String>.from(answers['interests']);
          if (current.contains(value)) {
            current.remove(value);
          } else {
            current.add(value);
          }
          answers['interests'] = current;
        });
      },
      showCustomInput: true,
      customInputHint: 'Type a hobby...',
      onAddCustom: (customValue) {
        if (customValue.isNotEmpty) {
          setState(() {
            List<String> current = List<String>.from(answers['interests']);
            if (!current.contains(customValue)) {
              current.add(customValue);
              answers['interests'] = current;
            }
            _customInterestController.clear();
          });
        }
      },
    );
  }

  Widget _buildSingleSelectQuestion({
    required String questionNumber,
    required String questionText,
    required List<Map<String, String>> options,
    required String? selectedValue,
    required Function(String) onSelect,
  }) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Question $questionNumber',
            style: const TextStyle(color: Colors.white60, fontSize: 14),
          ),
          const SizedBox(height: 12),
          Text(
            questionText,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 32),
          ...options.map((option) {
            final isSelected = selectedValue == option['value'];
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _buildOptionButton(
                text: option['text']!,
                isSelected: isSelected,
                onTap: () => onSelect(option['value']!),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildMultiSelectQuestion({
    required String stepLabel,
    required String questionText,
    required List<String> options,
    required List<String> selectedValues,
    required Function(String) onToggle,
    bool showCustomInput = false,
    String? customInputHint,
    Function(String)? onAddCustom,
  }) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            stepLabel,
            style: const TextStyle(color: Colors.white60, fontSize: 14),
          ),
          const SizedBox(height: 12),
          Text(
            questionText,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600,
              height: 1.3,
            ),
          ),
          if (selectedValues.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(
              'Selected: ${selectedValues.length}',
              style: const TextStyle(
                color: Color(0xFF4FC3F7),
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: selectedValues.map((hobby) {
                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF4FC3F7),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        hobby,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 6),
                      GestureDetector(
                        onTap: () => onToggle(hobby),
                        child: const Icon(
                          Icons.close,
                          size: 16,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
          const SizedBox(height: 20),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: options.map((option) {
              final isSelected = selectedValues.contains(option);
              return _buildInterestChip(
                text: option,
                isSelected: isSelected,
                onTap: () => onToggle(option),
              );
            }).toList(),
          ),
          if (showCustomInput) ...[
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _customInterestController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: customInputHint ?? 'Type here',
                      hintStyle: const TextStyle(color: Colors.white38),
                      filled: true,
                      fillColor: const Color(0xFF2A2A3E),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: () {
                    if (onAddCustom != null) {
                      onAddCustom(_customInterestController.text.trim());
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2A2A3E),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 14,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Add'),
                ),
              ],
            ),
          ],
          const SizedBox(height: 24),
          Center(
            child: TextButton(
              onPressed: _showContinueLaterDialog,
              style: TextButton.styleFrom(
                backgroundColor: const Color(0xFF4FC3F7),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 12,
                ),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.bookmark_outline, size: 18),
                  SizedBox(width: 8),
                  Text('Continue Later', style: TextStyle(fontSize: 14)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOptionButton({
    required String text,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF4FC3F7) : const Color(0xFF2A2A3E),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? const Color(0xFF4FC3F7) : Colors.transparent,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.white70,
                  fontSize: 15,
                ),
              ),
            ),
            if (isSelected)
              const Icon(Icons.check_circle, color: Colors.white, size: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildInterestChip({
    required String text,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF4FC3F7) : const Color(0xFF2A2A3E),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isSelected ? const Color(0xFF4FC3F7) : Colors.transparent,
            width: 2,
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.white70,
            fontSize: 14,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildNavigationButtons() {
    final bool canProceed = _canProceedToNext();

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: Color(0xFF1A1A2E),
        border: Border(top: BorderSide(color: Color(0xFF2A2A3E), width: 1)),
      ),
      child: Row(
        children: [
          if (currentStep > 0)
            Expanded(
              child: OutlinedButton(
                onPressed: () => setState(() => currentStep--),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white,
                  side: const BorderSide(color: Color(0xFF4FC3F7)),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.arrow_back, size: 20),
                    SizedBox(width: 8),
                    Text(
                      'Previous',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          if (currentStep > 0) const SizedBox(width: 16),
          Expanded(
            child: ElevatedButton(
              onPressed: canProceed ? _handleNext : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4FC3F7),
                foregroundColor: Colors.white,
                disabledBackgroundColor: const Color(0xFF2A2A3E),
                disabledForegroundColor: Colors.white38,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    currentStep == totalSteps - 1 ? 'Complete' : 'Next',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(Icons.arrow_forward, size: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool _canProceedToNext() {
    switch (currentStep) {
      case 0:
        return answers['question1'] != null;
      case 1:
        return answers['question2'] != null;
      case 2:
        return answers['question3'] != null;
      case 3:
        return answers['question4'] != null;
      case 4:
        return answers['question5'] != null;
      case 5:
        return answers['question6'] != null;
      case 6:
        return answers['question7'] != null;
      case 7:
        return (answers['interests'] as List).isNotEmpty;
      default:
        return false;
    }
  }

  void _handleNext() {
    if (currentStep < totalSteps - 1) {
      setState(() => currentStep++);
    } else {
      _completeTest();
    }
  }

  List<Qna> _generateQnaPayload() {
    List<Qna> qnaList = [];

    answers.forEach((key, value) {
      if (value != null) {
        String answerString = '';

        if (value is List) {
          if (value.isNotEmpty) {
            answerString = value.join(', ');
          }
        } else {
          answerString = value.toString();
        }

        if (answerString.isNotEmpty) {
          qnaList.add(
            Qna(question: _questionTexts[key] ?? key, answer: answerString),
          );
        }
      }
    });

    return qnaList;
  }

  void _completeTest() async {

    final qnaPayload = _generateQnaPayload();

    print("Payload: $qnaPayload");


    try {

      final requestBody = ProfilesRequestBody(
        qna: qnaPayload, name: 'test',
      );

      print("Raw JSON: ${jsonEncode(requestBody)}");

      await rawDio.get('/create-user-if-not-exists');

      final res = await apiClient.profiles.postProfiles(body: requestBody);

      print("========== res=======: $res");


      if (mounted) {
        Navigator.of(context).pop();
      }

      _showSuccessDialog();

    } catch (e) {
      if (mounted) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save profile: $e')),
        );
      }
    }
  }

  void _showSuccessDialog() {
    // Show completion dialog or navigate directly to home
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF2A2A3E),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: const Row(
          children: [
            Icon(
              Icons.check_circle,
              color: Color(0xFF4FC3F7),
              size: 32,
            ),
            SizedBox(width: 12),
            Text(
              'Test Completed!',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your personality test is complete!',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Your learning preferences have been saved and we\'ll personalize your experience accordingly.',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 14,
              ),
            ),
          ],
        ),
        actions: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
                // Navigate to home and clear all previous routes
                Navigator.of(context).pushNamedAndRemoveUntil(
                  '/home',
                      (route) => false,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4FC3F7),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Go to Home',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showContinueLaterDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF2A2A3E),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        title: const Text(
          'Continue Later?',
          style: TextStyle(color: Colors.white),
        ),
        content: const Text(
          'Your progress will be saved. You can continue this test anytime from your profile.',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.white60),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed('/home');
            },
            child: const Text(
              'Save & Exit',
              style: TextStyle(color: Color(0xFF4FC3F7)),
            ),
          ),
        ],
      ),
    );
  }
}