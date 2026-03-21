import 'package:flutter/material.dart';
import 'package:clerk_flutter/clerk_flutter.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  List<Map<String, dynamic>> _flashcards = [];
  int _currentIndex = 0;
  bool _isRevealed = false;
  int _gotItCount = 0;
  bool _isDone = false;
  bool _initialized = false;
  String _title = 'Flashcards';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      _initialized = true;
      final args =
          ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
      final raw = args?['flashcards'] as List?;
      _flashcards = raw != null
          ? raw
              .whereType<Map>()
              .map((f) => Map<String, dynamic>.from(f))
              .toList()
          : [];
      _title = args?['title'] as String? ?? 'Flashcards';

      // If no flashcards were passed and the user is authenticated,
      // they landed here via back-navigation — redirect to home.
      if (_flashcards.isEmpty) {
        final token =
            ClerkAuth.of(context).session?.lastActiveToken?.jwt;
        if (token != null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil('/home', (route) => false);
            }
          });
        }
      }
    }
  }

  void _gotIt() {
    setState(() {
      _gotItCount++;
      _advance();
    });
  }

  void _reviewLater() {
    setState(() => _advance());
  }

  void _advance() {
    if (_currentIndex < _flashcards.length - 1) {
      _currentIndex++;
      _isRevealed = false;
    } else {
      _isDone = true;
    }
  }

  void _restart() {
    setState(() {
      _currentIndex = 0;
      _isRevealed = false;
      _gotItCount = 0;
      _isDone = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1117),
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: const Color(0xFF0D1117),
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => Navigator.pop(context),
      ),
      title: Text(
        _title,
        style: const TextStyle(
            color: Colors.white, fontSize: 15, fontWeight: FontWeight.w600),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      centerTitle: true,
    );
  }

  Widget _buildBody() {
    if (_flashcards.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.quiz_outlined, color: Color(0xFF6B7A99), size: 64),
              SizedBox(height: 16),
              Text(
                'No flashcards available',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 8),
              Text(
                'Flashcards will appear here once your lesson is processed.',
                style: TextStyle(
                    color: Color(0xFF6B7A99), fontSize: 14, height: 1.5),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    if (_isDone) {
      return _completionScreen();
    }

    final card = _flashcards[_currentIndex];

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
      child: Column(
        children: [
          // Progress
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Card ${_currentIndex + 1} of ${_flashcards.length}',
                style: const TextStyle(
                    color: Color(0xFF6B7A99), fontSize: 13),
              ),
              Text(
                '$_gotItCount got it',
                style: const TextStyle(
                    color: Color(0xFF43C59E), fontSize: 13),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: (_currentIndex + 1) / _flashcards.length,
              backgroundColor: const Color(0xFF1E2A3A),
              valueColor: const AlwaysStoppedAnimation<Color>(
                  Color(0xFF6C63FF)),
              minHeight: 4,
            ),
          ),
          const SizedBox(height: 28),

          // Flash card
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              transitionBuilder: (child, animation) =>
                  FadeTransition(opacity: animation, child: child),
              child: _isRevealed
                  ? _answerCard(card)
                  : _questionCard(card),
            ),
          ),

          const SizedBox(height: 20),

          // Action buttons
          if (!_isRevealed)
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: () => setState(() => _isRevealed = true),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6C63FF),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                ),
                child: const Text(
                  'Reveal Answer',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 16),
                ),
              ),
            )
          else
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 52,
                    child: OutlinedButton(
                      onPressed: _reviewLater,
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Color(0xFF1E2A3A)),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                      ),
                      child: const Text(
                        'Review Later',
                        style: TextStyle(color: Color(0xFF6B7A99)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: SizedBox(
                    height: 52,
                    child: ElevatedButton(
                      onPressed: _gotIt,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF43C59E),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                      ),
                      child: const Text(
                        'Got it ✓',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _questionCard(Map<String, dynamic> card) {
    return Container(
      key: const ValueKey('question'),
      width: double.infinity,
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: const Color(0xFF161B27),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFF1E2A3A)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.help_outline,
              color: Color(0xFF6C63FF), size: 36),
          const SizedBox(height: 20),
          const Text(
            'QUESTION',
            style: TextStyle(
                color: Color(0xFF6B7A99),
                fontSize: 11,
                letterSpacing: 1.5),
          ),
          const SizedBox(height: 16),
          Text(
            card['question'] as String? ?? '',
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Tap "Reveal Answer" when ready',
            style: TextStyle(color: Color(0xFF6B7A99), fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _answerCard(Map<String, dynamic> card) {
    final hint = card['hint'] as String? ?? '';
    return Container(
      key: const ValueKey('answer'),
      width: double.infinity,
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: const Color(0xFF0A1F18),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
            color: const Color(0xFF43C59E).withValues(alpha: 0.5)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.lightbulb_outline,
              color: Color(0xFF43C59E), size: 36),
          const SizedBox(height: 20),
          const Text(
            'ANSWER',
            style: TextStyle(
                color: Color(0xFF43C59E),
                fontSize: 11,
                letterSpacing: 1.5),
          ),
          const SizedBox(height: 16),
          Text(
            card['answer'] as String? ?? '',
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
              height: 1.5,
            ),
          ),
          if (hint.isNotEmpty) ...[
            const SizedBox(height: 20),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: const Color(0xFF6C63FF).withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                    color: const Color(0xFF6C63FF).withValues(alpha: 0.3)),
              ),
              child: Text(
                '💡 $hint',
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Color(0xFF6C63FF), fontSize: 13, height: 1.4),
              ),
            ),
          ],
          const SizedBox(height: 20),
          const Text(
            'Did you get it right?',
            style: TextStyle(color: Color(0xFF6B7A99), fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _completionScreen() {
    final total = _flashcards.length;
    final pct =
        total > 0 ? (_gotItCount / total * 100).toInt() : 0;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.emoji_events,
                color: Color(0xFFffd60a), size: 80),
            const SizedBox(height: 24),
            const Text(
              'Session Complete!',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text(
              '$pct% mastered',
              style: const TextStyle(
                  color: Color(0xFF43C59E),
                  fontSize: 22,
                  fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),
            Text(
              '$_gotItCount of $total cards',
              style: const TextStyle(
                  color: Color(0xFF6B7A99), fontSize: 15),
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: _restart,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF161B27),
                  side: const BorderSide(color: Color(0xFF6C63FF)),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                ),
                child: const Text(
                  'Study Again',
                  style: TextStyle(
                      color: Color(0xFF6C63FF),
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6C63FF),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                ),
                child: const Text(
                  'Back to Lesson',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
