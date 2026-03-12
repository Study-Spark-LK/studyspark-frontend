import 'package:flutter/material.dart';
import '../api/api_client.dart';
import '../api/models/profiles_request_body.dart';
import 'package:studyspark/api/models/profiles_request_body.dart';
import 'package:studyspark/api/models/qna.dart';
import 'package:clerk_flutter/clerk_flutter.dart';

class PersonalityTestQuestionnaireScreen extends StatefulWidget {
  const PersonalityTestQuestionnaireScreen({super.key});

  @override
  State<PersonalityTestQuestionnaireScreen> createState() =>
      _PersonalityTestQuestionnaireScreenState();
}

class _PersonalityTestQuestionnaireScreenState
    extends State<PersonalityTestQuestionnaireScreen> {
  int currentStep = 0;
  final int totalSteps = 5;

  @override
  void initState() {
    super.initState();

    fetchClerkToken = () async {
      return ClerkAuth.of(context).session?.lastActiveToken?.jwt;
    };
  }

  // Store answers for each question
  Map<String, dynamic> answers = {
    'learningPreference': null, // Question 1
    'informationRetention': null, // Question 2
    'interestCreation': null, // Question 3
    'interests': <String>[], // Question 4 (multi-select)
    'contentConsumption': <String>[], // Question 5 (multi-select)
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
            // Header with back button and progress
            _buildHeader(),

            // Content area
            Expanded(
              child: _buildCurrentStep(),
            ),

            // Navigation buttons
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
                    setState(() {
                      currentStep--;
                    });
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
              const SizedBox(width: 48), // Balance the back button
            ],
          ),
          const SizedBox(height: 16),
          // Progress bar
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: (currentStep + 1) / totalSteps,
              backgroundColor: const Color(0xFF2A2A3E),
              valueColor:
                  const AlwaysStoppedAnimation<Color>(Color(0xFF4FC3F7)),
              minHeight: 8,
            ),
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
      default:
        return Container();
    }
  }

  // Question 1: When learning something new, I prefer to:
  Widget _buildQuestion1() {
    final options = [
      {
        'text': 'Watch diagrams, videos, or demonstrations',
        'value': 'visual'
      },
      {
        'text': 'Listen to explanations and discussions',
        'value': 'auditory'
      },
      {'text': 'Read detailed documentation and analyze it', 'value': 'reading'},
      {
        'text': 'Hear real-world examples and stories',
        'value': 'kinesthetic'
      },
    ];

    return _buildSingleSelectQuestion(
      questionNumber: '1 of 5',
      questionText: 'When learning something new, I prefer to:',
      options: options,
      selectedValue: answers['learningPreference'],
      onSelect: (value) {
        setState(() {
          answers['learningPreference'] = value;
        });
      },
    );
  }

  // Question 2: I remember information best when:
  Widget _buildQuestion2() {
    final options = [
      {'text': 'I can visualize it as an image or chart', 'value': 'visual'},
      {'text': 'I hear it repeated or discussed', 'value': 'auditory'},
      {'text': 'I organize it into logical categories', 'value': 'logical'},
      {
        'text': 'It\'s connected to a personal experience',
        'value': 'experiential'
      },
    ];

    return _buildSingleSelectQuestion(
      questionNumber: '2 of 5',
      questionText: 'I remember information best when:',
      options: options,
      selectedValue: answers['informationRetention'],
      onSelect: (value) {
        setState(() {
          answers['informationRetention'] = value;
        });
      },
    );
  }

  // Question 3: A topic becomes interesting to me when:
  Widget _buildQuestion3() {
    final options = [
      {
        'text': 'Visually appealing or unique presentation',
        'value': 'visual'
      },
      {'text': 'Engaging narration or storytelling', 'value': 'narrative'},
      {
        'text': 'Real-life uses, relevant to career, etc',
        'value': 'practical'
      },
      {'text': 'Relatable examples or case studies', 'value': 'relatable'},
    ];

    return _buildSingleSelectQuestion(
      questionNumber: '2 of 5',
      questionText: 'A topic becomes interesting to me when:',
      options: options,
      selectedValue: answers['interestCreation'],
      onSelect: (value) {
        setState(() {
          answers['interestCreation'] = value;
        });
      },
    );
  }

  // Question 4: Mark your interests (multi-select)
  Widget _buildQuestion4() {
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
    ];

    return _buildMultiSelectQuestion(
      questionNumber: '3 of 5',
      questionText: 'Mark your interests to create personalized\nlearning content',
      subtitle: 'OR',
      options: interests,
      selectedValues: answers['interests'] as List<String>,
      onToggle: (value) {
        setState(() {
          List<String> currentInterests =
              List<String>.from(answers['interests']);
          if (currentInterests.contains(value)) {
            currentInterests.remove(value);
          } else {
            currentInterests.add(value);
          }
          answers['interests'] = currentInterests;
        });
      },
      showCustomInput: true,
      customInputHint: 'Type a hobby',
      onAddCustom: (customValue) {
        if (customValue.isNotEmpty) {
          setState(() {
            List<String> currentInterests =
                List<String>.from(answers['interests']);
            if (!currentInterests.contains(customValue)) {
              currentInterests.add(customValue);
              answers['interests'] = currentInterests;
            }
            _customInterestController.clear();
          });
        }
      },
    );
  }

  // Question 5: Content consumption preferences (multi-select)
  Widget _buildQuestion5() {
    final methods = [
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
    ];

    return _buildMultiSelectQuestion(
      questionNumber: '3 of 5',
      questionText: 'Mark your interests to create personalized\nlearning content',
      subtitle: 'OR',
      options: methods,
      selectedValues: answers['contentConsumption'] as List<String>,
      onToggle: (value) {
        setState(() {
          List<String> currentMethods =
              List<String>.from(answers['contentConsumption']);
          if (currentMethods.contains(value)) {
            currentMethods.remove(value);
          } else {
            currentMethods.add(value);
          }
          answers['contentConsumption'] = currentMethods;
        });
      },
      showCustomInput: true,
      customInputHint: 'Other(specify)',
      onAddCustom: (customValue) {
        if (customValue.isNotEmpty) {
          setState(() {
            List<String> currentMethods =
                List<String>.from(answers['contentConsumption']);
            if (!currentMethods.contains(customValue)) {
              currentMethods.add(customValue);
              answers['contentConsumption'] = currentMethods;
            }
            _customInterestController.clear();
          });
        }
      },
    );
  }

  // Reusable single-select question widget
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
            style: const TextStyle(
              color: Colors.white60,
              fontSize: 14,
            ),
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

  // Reusable multi-select question widget
  Widget _buildMultiSelectQuestion({
    required String questionNumber,
    required String questionText,
    String? subtitle,
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
            'Step $questionNumber',
            style: const TextStyle(
              color: Colors.white60,
              fontSize: 14,
            ),
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
          if (subtitle != null) ...[
            const SizedBox(height: 16),
            Text(
              subtitle,
              style: const TextStyle(
                color: Colors.white60,
                fontSize: 14,
              ),
            ),
          ],
          const SizedBox(height: 24),
          // Chips
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
                      onAddCustom(_customInterestController.text);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2A2A3E),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Add'),
                ),
              ],
            ),
          ],
          // Display selected hobbies
          if (selectedValues.isNotEmpty) ...[
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF2A2A3E),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: const Color(0xFF4FC3F7).withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: Color(0xFF4FC3F7),
                        size: 20,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Selected Hobbies',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
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
                          color: const Color(0xFF4FC3F7).withOpacity(0.2),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: const Color(0xFF4FC3F7),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              hobby,
                              style: const TextStyle(
                                color: Color(0xFF4FC3F7),
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(width: 6),
                            GestureDetector(
                              onTap: () => onToggle(hobby),
                              child: const Icon(
                                Icons.close,
                                size: 16,
                                color: Color(0xFF4FC3F7),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ],
          const SizedBox(height: 16),
          // Continue later button
          Center(
            child: TextButton(
              onPressed: () {
                // Handle continue later
                _showContinueLaterDialog();
              },
              style: TextButton.styleFrom(
                backgroundColor: const Color(0xFF4FC3F7),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.bookmark_outline, size: 18),
                  SizedBox(width: 8),
                  Text(
                    'Continue Later',
                    style: TextStyle(fontSize: 14),
                  ),
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
          color: isSelected
              ? const Color(0xFF4FC3F7)
              : const Color(0xFF2A2A3E),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color:
                isSelected ? const Color(0xFF4FC3F7) : Colors.transparent,
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
              const Icon(
                Icons.check_circle,
                color: Colors.white,
                size: 24,
              ),
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
          color: isSelected
              ? const Color(0xFF4FC3F7)
              : const Color(0xFF2A2A3E),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color:
                isSelected ? const Color(0xFF4FC3F7) : Colors.transparent,
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
        border: Border(
          top: BorderSide(
            color: Color(0xFF2A2A3E),
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          if (currentStep > 0)
            Expanded(
              child: OutlinedButton(
                onPressed: () {
                  setState(() {
                    currentStep--;
                  });
                },
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
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ),
          if (currentStep > 0) const SizedBox(width: 16),
          Expanded(
            flex: currentStep == 0 ? 1 : 1,
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
                        fontSize: 16, fontWeight: FontWeight.w600),
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
        return answers['learningPreference'] != null;
      case 1:
        return answers['informationRetention'] != null;
      case 2:
        return answers['interestCreation'] != null;
      case 3:
        return (answers['interests'] as List).isNotEmpty;
      case 4:
        return (answers['contentConsumption'] as List).isNotEmpty;
      default:
        return false;
    }
  }

  void _handleNext() {
    if (currentStep < totalSteps - 1) {
      setState(() {
        currentStep++;
      });
    } else {
      // Complete the test
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
            Qna(
              question: _questionTexts[key] ?? key,
              answer: answerString,
            ),
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

      await apiClient.profiles.postProfiles(body: requestBody);

      if (mounted) {
        Navigator.of(context).pop();
      }

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
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
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
            onPressed: () {
              Navigator.of(context).pop(); // Close dialog
            },
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.white60),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close dialog
              Navigator.of(context).pushReplacementNamed('/home'); // Go home
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