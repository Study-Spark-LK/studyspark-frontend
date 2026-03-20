import 'package:flutter/material.dart';

class QuizQuestion {
  final int id;
  final String question;
  final List<String> options;
  final int? selectedAnswerIndex;

  QuizQuestion({
    required this.id,
    required this.question,
    required this.options,
    this.selectedAnswerIndex,
  });

  QuizQuestion copyWith({
    int? id,
    String? question,
    List<String>? options,
    int? selectedAnswerIndex,
  }) {
    return QuizQuestion(
      id: id ?? this.id,
      question: question ?? this.question,
      options: options ?? this.options,
      selectedAnswerIndex: selectedAnswerIndex ?? this.selectedAnswerIndex,
    );
  }
}

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  late PageController _pageController;
  int currentQuestionIndex = 0;
  int? selectedAnswerIndex;

  final List<QuizQuestion> questions = [
    QuizQuestion(
      id: 1,
      question: 'What is the primary function of chlorophyll in photosynthesis?',
      options: [
        'To store glucose',
        'To capture light energy',
        'To produce oxygen',
        'To absorb water',
      ],
    ),
    QuizQuestion(
      id: 2,
      question: 'Which organelle is responsible for cellular respiration?',
      options: [
        'Ribosome',
        'Mitochondrion',
        'Golgi apparatus',
        'Endoplasmic reticulum',
      ],
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _handleAnswerSelection(int index) {
    setState(() {
      selectedAnswerIndex = index;
    });
  }

  void _handleSubmitAnswer() {
    if (selectedAnswerIndex != null) {
      if (currentQuestionIndex < questions.length - 1) {
        // Move to next question
        setState(() {
          currentQuestionIndex++;
          selectedAnswerIndex = null;
        });
        _pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      } else {
        // Quiz completed
        _showQuizCompletedDialog();
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select an answer'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  void _showQuizCompletedDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1a1f2e),
        title: const Text(
          'Quiz Completed!',
          style: TextStyle(color: Colors.white),
        ),
        content: const Text(
          'You have completed the quiz. Great job!',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _resetQuiz();
            },
            child: const Text('Retake Quiz'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _resetQuiz() {
    setState(() {
      currentQuestionIndex = 0;
      selectedAnswerIndex = null;
    });
    _pageController.jumpToPage(0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1a1f2e),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF1a1f2e),
        title: const Text(
          'Quiz',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Center(
              child: Text(
                '${currentQuestionIndex}/${questions.length}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
      body: PageView.builder(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (index) {
          setState(() {
            currentQuestionIndex = index;
            selectedAnswerIndex = null;
          });
        },
        itemCount: questions.length,
        itemBuilder: (context, index) {
          final question = questions[index];
          return _buildQuestionView(question, index);
        },
      ),
    );
  }

  Widget _buildQuestionView(QuizQuestion question, int questionIndex) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Question counter
            Text(
              'Question ${questionIndex + 1} of ${questions.length}',
              style: const TextStyle(
                color: Colors.white54,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 16),

            // Question text
            Text(
              question.question,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 32),

            // Answer options
            ...List.generate(
              question.options.length,
              (optionIndex) => Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: _buildAnswerOption(
                  text: question.options[optionIndex],
                  index: optionIndex,
                  isSelected: selectedAnswerIndex == optionIndex,
                  onTap: () => _handleAnswerSelection(optionIndex),
                ),
              ),
            ),

            const SizedBox(height: 40),

            // Submit button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _handleSubmitAnswer,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF17A2B8),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Submit Answer',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnswerOption({
    required String text,
    required int index,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF2A3F5F) : Colors.transparent,
          border: Border.all(
            color: isSelected
                ? const Color(0xFF17A2B8)
                : const Color(0xFF3A4A5F),
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? const Color(0xFF17A2B8)
                      : const Color(0xFF3A4A5F),
                  width: 2,
                ),
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFF17A2B8),
                        ),
                      ),
                    )
                  : null,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
