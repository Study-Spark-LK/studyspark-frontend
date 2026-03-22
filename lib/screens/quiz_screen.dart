import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:clerk_flutter/clerk_flutter.dart';
import 'package:studyspark/api/api_client.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  bool _isLoading = true;
  bool _isSubmitting = false;
  List<dynamic> _questions = [];
  final Map<String, String> _selectedAnswers = {};
  int _currentIndex = 0;
  Map<String, dynamic>? _results;
  String? _error;
  String? _documentId;
  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      _initialized = true;
      final args =
          ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
      _documentId = args?['documentId'] as String?;

      fetchClerkToken = () async {
        final auth = ClerkAuth.of(context);
        try {
          final sessionToken = await auth.sessionToken();
          return sessionToken.jwt;
        } catch (_) {
          return auth.session?.lastActiveToken?.jwt;
        }
      };

      _loadQuiz();
    }
  }

  Future<void> _loadQuiz() async {
    setState(() {
      _isLoading = true;
      _error = null;
      _questions = [];
      _selectedAnswers.clear();
      _currentIndex = 0;
      _results = null;
    });

    if (_documentId == null) {
      setState(() {
        _isLoading = false;
        _error = 'No document ID provided.';
      });
      return;
    }

    try {
      final auth = ClerkAuth.of(context);
      try {
        final sessionToken = await auth.sessionToken();
        rawDio.options.headers['Authorization'] = 'Bearer ${sessionToken.jwt}';
      } catch (_) {
        final jwt = auth.session?.lastActiveToken?.jwt;
        if (jwt != null) rawDio.options.headers['Authorization'] = 'Bearer $jwt';
      }

      final res = await rawDio.post(
        '/documents/$_documentId/quiz/generate',
        data: {'numQuestions': 5, 'difficulty': 'medium'},
        options: Options(receiveTimeout: const Duration(seconds: 60)),
      );

      final data = res.data;
      final List<dynamic> questions = data is List
          ? data
          : (data is Map && data['questions'] != null)
              ? data['questions'] as List
              : [];

      setState(() {
        _questions = questions;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _error = 'Failed to generate quiz. Please try again.';
      });
    }
  }

  Future<void> _submitQuiz() async {
    setState(() => _isSubmitting = true);

    try {
      final auth = ClerkAuth.of(context);
      try {
        final sessionToken = await auth.sessionToken();
        rawDio.options.headers['Authorization'] = 'Bearer ${sessionToken.jwt}';
      } catch (_) {
        final jwt = auth.session?.lastActiveToken?.jwt;
        if (jwt != null) rawDio.options.headers['Authorization'] = 'Bearer $jwt';
      }

      final answers = _selectedAnswers.entries
          .map((e) => {'questionId': e.key, 'selectedAnswer': e.value})
          .toList();

      final res = await rawDio.post(
        '/documents/$_documentId/quiz/evaluate',
        data: {'answers': answers},
        options: Options(receiveTimeout: const Duration(seconds: 60)),
      );

      final data = res.data as Map<String, dynamic>;
      setState(() {
        _results = data;
        _isSubmitting = false;
      });
    } catch (e) {
      setState(() => _isSubmitting = false);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to submit quiz. Please try again.'),
          backgroundColor: Color(0xFF1E2A3A),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        backgroundColor: Color(0xFF0D1117),
        body: Center(
          child: CircularProgressIndicator(color: Color(0xFF6C63FF)),
        ),
      );
    }

    if (_error != null) {
      return Scaffold(
        backgroundColor: const Color(0xFF0D1117),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline,
                    color: Color(0xFF6B7A99), size: 64),
                const SizedBox(height: 16),
                Text(
                  _error!,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _loadQuiz,
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6C63FF)),
                  child: const Text('Try Again',
                      style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ),
      );
    }

    if (_results != null) {
      return _resultsScreen();
    }

    if (_questions.isEmpty) {
      return Scaffold(
        backgroundColor: const Color(0xFF0D1117),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.quiz_outlined,
                    color: Color(0xFF6B7A99), size: 64),
                const SizedBox(height: 16),
                const Text('No questions available',
                    style: TextStyle(color: Colors.white, fontSize: 18)),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _loadQuiz,
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6C63FF)),
                  child: const Text('Try Again',
                      style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return _quizScreen();
  }

  Widget _quizScreen() {
    final q = _questions[_currentIndex] as Map<String, dynamic>;
    final questionId = q['id'] as String? ?? q['questionId'] as String? ?? '$_currentIndex';
    final questionText = q['question'] as String? ?? '';
    final optionsRaw = q['options'] as List? ?? [];
    final options = optionsRaw.map((o) => o.toString()).toList();
    final selected = _selectedAnswers[questionId];
    final isLastQuestion = _currentIndex == _questions.length - 1;

    return Scaffold(
      backgroundColor: const Color(0xFF0D1117),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Question ${_currentIndex + 1} of ${_questions.length}',
          style: const TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4),
          child: LinearProgressIndicator(
            value: (_currentIndex + 1) / _questions.length,
            backgroundColor: const Color(0xFF1E2A3A),
            valueColor:
                const AlwaysStoppedAnimation<Color>(Color(0xFF6C63FF)),
            minHeight: 4,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),

            // Question card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF161B27),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFF1E2A3A)),
              ),
              child: Text(
                questionText,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  height: 1.5,
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Options
            Expanded(
              child: ListView.builder(
                itemCount: options.length,
                itemBuilder: (context, i) {
                  final letters = ['A', 'B', 'C', 'D'];
                  final letter = i < letters.length ? letters[i] : '${i + 1}';
                  final optionText = options[i];
                  final isSelected = selected == optionText;

                  return GestureDetector(
                    onTap: () => setState(
                        () => _selectedAnswers[questionId] = optionText),
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xFF6C63FF).withValues(alpha: 0.15)
                            : const Color(0xFF161B27),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected
                              ? const Color(0xFF6C63FF)
                              : const Color(0xFF1E2A3A),
                          width: isSelected ? 2 : 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? const Color(0xFF6C63FF)
                                  : const Color(0xFF1E2A3A),
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                letter,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              optionText,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            // Bottom button
            SizedBox(
              width: double.infinity,
              height: 54,
              child: selected == null
                  ? ElevatedButton(
                      onPressed: null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color(0xFF1E2A3A),
                        disabledBackgroundColor: const Color(0xFF1E2A3A),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14)),
                      ),
                      child: const Text(
                        'Select an answer',
                        style: TextStyle(color: Color(0xFF6B7A99)),
                      ),
                    )
                  : isLastQuestion
                      ? DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFF6C63FF), Color(0xFF4FC3F7)],
                            ),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: ElevatedButton(
                            onPressed: _isSubmitting ? null : _submitQuiz,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14)),
                            ),
                            child: _isSubmitting
                                ? const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                        strokeWidth: 2, color: Colors.white))
                                : const Text(
                                    'Submit Quiz',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                          ),
                        )
                      : ElevatedButton(
                          onPressed: () =>
                              setState(() => _currentIndex++),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF6C63FF),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14)),
                          ),
                          child: const Text(
                            'Next Question →',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                        ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _resultsScreen() {
    final score = (_results!['score'] as num?)?.toInt() ?? 0;
    final correctCount = (_results!['correctCount'] as num?)?.toInt() ??
        (_results!['correct'] as num?)?.toInt() ?? 0;
    final totalQuestions = (_results!['totalQuestions'] as num?)?.toInt() ??
        (_results!['total'] as num?)?.toInt() ?? _questions.length;
    final feedback = _results!['feedback'] as String? ?? '';
    final weakAreasRaw = _results!['weakAreas'] as List? ?? [];
    final weakAreas = weakAreasRaw.map((e) => e.toString()).toList();

    Color scoreColor;
    String scoreMessage;
    if (score >= 70) {
      scoreColor = const Color(0xFF43C59E);
      scoreMessage = 'Great work! 🎉';
    } else if (score >= 40) {
      scoreColor = const Color(0xFFF5A623);
      scoreMessage = 'Good effort! 💪';
    } else {
      scoreColor = const Color(0xFFE24B4A);
      scoreMessage = 'Keep practising! 📚';
    }

    return Scaffold(
      backgroundColor: const Color(0xFF0D1117),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),

              // Score circle
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      scoreColor.withValues(alpha: 0.3),
                      scoreColor.withValues(alpha: 0.1),
                    ],
                  ),
                  border: Border.all(color: scoreColor, width: 3),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '$score%',
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.w700),
                    ),
                    const Text(
                      'Score',
                      style: TextStyle(color: Colors.white, fontSize: 13),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              Text(
                scoreMessage,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w700),
              ),

              const SizedBox(height: 8),

              Text(
                '$correctCount out of $totalQuestions correct',
                style: const TextStyle(
                    color: Color(0xFF6B7A99), fontSize: 15),
              ),

              const SizedBox(height: 24),

              if (feedback.isNotEmpty) ...[
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF161B27),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFF1E2A3A)),
                  ),
                  child: Text(
                    feedback,
                    style: const TextStyle(
                        color: Color(0xFF6B7A99), fontSize: 14, height: 1.6),
                  ),
                ),
                const SizedBox(height: 16),
              ],

              if (weakAreas.isNotEmpty) ...[
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Areas to review',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  children: weakAreas
                      .map(
                        (area) => Container(
                          margin: const EdgeInsets.all(4),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            color: const Color(0xFF1E2A3A),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            area,
                            style: const TextStyle(
                                color: Color(0xFF6B7A99), fontSize: 12),
                          ),
                        ),
                      )
                      .toList(),
                ),
                const SizedBox(height: 24),
              ],

              // Retake button
              SizedBox(
                width: double.infinity,
                height: 52,
                child: OutlinedButton(
                  onPressed: _loadQuiz,
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFF6C63FF)),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14)),
                  ),
                  child: const Text(
                    'Retake Quiz',
                    style: TextStyle(
                        color: Color(0xFF6C63FF),
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // Back to content button
              SizedBox(
                width: double.infinity,
                height: 52,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF6C63FF), Color(0xFF4FC3F7)],
                    ),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14)),
                    ),
                    child: const Text(
                      'Back to Content',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
