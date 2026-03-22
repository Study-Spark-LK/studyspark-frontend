import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:clerk_flutter/clerk_flutter.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:studyspark/api/api_client.dart';
import 'package:studyspark/api/export.dart';
import 'ai_chat_bot.dart';

class OutputresultScreen extends StatefulWidget {
  const OutputresultScreen({super.key});

  @override
  State<OutputresultScreen> createState() => _OutputresultScreenState();
}

class _OutputresultScreenState extends State<OutputresultScreen>
    with TickerProviderStateMixin {
  late final AnimationController _flipController;
  late final Animation<double> _flipAnimation;
  int _selectedType = 0;
  bool _isLoading = true;
  bool _hasError = false;
  bool _initialized = false;

  // Route args
  String? _documentId;
  String _title = 'Lesson';
  String _category = '';

  // Parsed AI content
  String _explanation = '';
  String _tldrSummary = '';
  List<String> _keyPoints = [];
  String _storyMode = '';
  List<Map<String, dynamic>> _flashcards = [];

  // Flashcards tab state
  int _flashcardIndex = 0;
  bool _flashcardRevealed = false;
  bool _flashcardsDone = false;

  // Draggable chat icon position
  double _chatTop = 500;
  double _chatLeft = 300;

  final _types = ['Visual', 'Audio', 'Analytical', 'Story', 'Flashcards'];

  @override
  void initState() {
    super.initState();
    _flipController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _flipAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _flipController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _flipController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      _initialized = true;
      final args =
          ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
      _documentId = args?['documentId'] as String?;
      _title = args?['title'] as String? ?? 'Lesson';
      _category = args?['category'] as String? ?? '';

      fetchClerkToken = () async {
        final auth = ClerkAuth.of(context);
        try {
          final sessionToken = await auth.sessionToken();
          return sessionToken.jwt;
        } catch (_) {
          return auth.session?.lastActiveToken?.jwt;
        }
      };

      if (_documentId != null) {
        _loadContent();
      } else {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _loadContent() async {
    setState(() {
      _isLoading = true;
      _hasError = false;
    });
    try {
      final auth = ClerkAuth.of(context);
      try {
        final sessionToken = await auth.sessionToken();
        rawDio.options.headers['Authorization'] = 'Bearer ${sessionToken.jwt}';
      } catch (_) {
        final jwt = auth.session?.lastActiveToken?.jwt;
        if (jwt != null) rawDio.options.headers['Authorization'] = 'Bearer $jwt';
      }

      // 1. Fetch document with generated files list
      final docRes = await apiClient.documents
          .getDocumentsDocumentId(documentId: _documentId!);
      final generatedFiles = docRes.data.generatedFiles;

      final analyticalFile = generatedFiles.cast<GeneratedFiles?>()
          .firstWhere((f) => f!.type == Type.analytical, orElse: () => null);
      final storyFile = generatedFiles.cast<GeneratedFiles?>()
          .firstWhere((f) => f!.type == Type.story, orElse: () => null);

      if (analyticalFile == null) {
        setState(() {
          _explanation = 'Content is being finalized. Please check back shortly.';
          _isLoading = false;
        });
        return;
      }

      // 2. Fetch analytical content — keys: explanation, tldrSummary, keyPoints
      final analyticalRes =
          await rawDio.get('/storage/files/${analyticalFile.fileId}');
      final analyticalData = analyticalRes.data;
      final Map<String, dynamic> analytical = analyticalData is Map<String, dynamic>
          ? analyticalData
          : jsonDecode(analyticalData as String) as Map<String, dynamic>;

      final explanation = analytical['explanation'] as String? ?? '';
      final tldr = analytical['tldrSummary'] as String? ?? '';
      final keyPointsRaw = analytical['keyPoints'] as List? ?? [];
      final keyPoints = keyPointsRaw.map((e) => e.toString()).toList();

      // 3. Fetch story content — separate R2 file, key: story
      String story = '';
      if (storyFile != null) {
        try {
          final storyRes =
              await rawDio.get('/storage/files/${storyFile.fileId}');
          final storyData = storyRes.data;
          final Map<String, dynamic> storyJson = storyData is Map<String, dynamic>
              ? storyData
              : jsonDecode(storyData as String) as Map<String, dynamic>;
          story = storyJson['story'] as String? ?? '';
        } catch (_) {
          // story is non-critical — leave empty
        }
      }

      // 4. Fetch flashcards from database endpoint
      List<Map<String, dynamic>> flashcards = [];
      try {
        final fcRes =
            await rawDio.get('/documents/$_documentId/flashcards');
        final fcData = fcRes.data;
        final List<dynamic> fcList = fcData is List
            ? fcData
            : fcData is Map
                ? (fcData['data'] as List? ?? fcData['flashcards'] as List? ?? [])
                : (jsonDecode(fcData as String) as Map)['data'] as List? ?? [];
        flashcards = fcList
            .whereType<Map>()
            .map((f) => Map<String, dynamic>.from(f))
            .toList();
      } catch (_) {
        // flashcards are non-critical — leave empty
      }

      setState(() {
        _explanation = explanation;
        _tldrSummary = tldr;
        _keyPoints = keyPoints;
        _storyMode = story;
        _flashcards = flashcards;
        _isLoading = false;
      });
    } catch (e) {
      debugPrint(e.toString());
      setState(() {
        _isLoading = false;
        _hasError = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1117),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A2332),
        elevation: 0,
        leading: const BackButton(color: Colors.white),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _title,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w600),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            if (_category.isNotEmpty)
              Text(
                _category,
                style: const TextStyle(
                    color: Color(0xFF6B7A99), fontSize: 11),
              ),
          ],
        ),
      ),
      body: _isLoading
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(color: Color(0xFF6C63FF)),
                  SizedBox(height: 16),
                  Text('Loading your lesson...',
                      style: TextStyle(color: Color(0xFF6B7A99))),
                ],
              ),
            )
          : _hasError
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.error_outline,
                          color: Color(0xFF6B7A99), size: 48),
                      const SizedBox(height: 12),
                      const Text('Failed to load lesson content',
                          style: TextStyle(color: Colors.white)),
                      const SizedBox(height: 16),
                      TextButton(
                        onPressed: _loadContent,
                        child: const Text('Retry',
                            style: TextStyle(color: Color(0xFF6C63FF))),
                      ),
                    ],
                  ),
                )
              : Stack(
                  children: [
                    SingleChildScrollView(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Type selector
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: List.generate(_types.length, (i) {
                                return GestureDetector(
                                  onTap: () =>
                                      setState(() => _selectedType = i),
                                  child: Container(
                                    margin: const EdgeInsets.only(right: 8),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 10),
                                    decoration: BoxDecoration(
                                      color: _selectedType == i
                                          ? const Color(0xFF6C63FF)
                                          : const Color(0xFF1A2332),
                                      borderRadius:
                                          BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      _types[i],
                                      style: TextStyle(
                                        color: _selectedType == i
                                            ? Colors.white
                                            : const Color(0xFF6B7A99),
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ),

                          const SizedBox(height: 20),

                          // Content for selected tab
                          _buildContent(),

                          const SizedBox(height: 100),
                        ],
                      ),
                    ),

                    // Draggable chat icon
                    Positioned(
                      top: _chatTop,
                      left: _chatLeft,
                      child: Draggable(
                        feedback: _chatIcon(),
                        childWhenDragging: Container(),
                        onDragEnd: (details) {
                          setState(() {
                            _chatTop = details.offset.dy;
                            _chatLeft = details.offset.dx;
                          });
                        },
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const AIChatScreen(),
                              ),
                            );
                          },
                          child: _chatIcon(),
                        ),
                      ),
                    ),
                  ],
                ),
    );
  }

  Widget _chatIcon() {
    return Material(
      color: Colors.transparent,
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          color: const Color(0xFF6C63FF),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF6C63FF).withValues(alpha: 0.4),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: const Icon(Icons.chat, color: Colors.white, size: 26),
      ),
    );
  }

  Widget _buildContent() {
    switch (_selectedType) {
      case 0:
        return _visualTab();
      case 1:
        return _audioTab();
      case 2:
        return _analyticalTab();
      case 3:
        return _storyTab();
      case 4:
        return _flashcardsTab();
      default:
        return Container();
    }
  }

  Widget _visualTab() {
    if (_keyPoints.isEmpty && _tldrSummary.isEmpty) {
      return _emptyContent('No visual content available');
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (_tldrSummary.isNotEmpty)
          _infoCard(
            'TL;DR Summary',
            Icons.bolt,
            const Color(0xFF6C63FF),
            [
              _mdBody(_tldrSummary),
            ],
          ),
        if (_keyPoints.isNotEmpty) ...[
          const SizedBox(height: 16),
          _infoCard(
            'Key Points',
            Icons.list_alt,
            const Color(0xFF4FC3F7),
            _keyPoints.asMap().entries.map((entry) {
              return Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFF0D1117),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 12,
                      backgroundColor: const Color(0xFF6C63FF),
                      child: Text(
                        '${entry.key + 1}',
                        style: const TextStyle(
                            color: Colors.white, fontSize: 11),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(child: _mdBody(entry.value, fontSize: 13)),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ],
    );
  }

  Widget _audioTab() {
    return _infoCard(
      'Audio Learning',
      Icons.headphones,
      const Color(0xFFffd60a),
      [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFF0D1117),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Column(
            children: [
              Icon(Icons.mic_off, color: Color(0xFF6B7A99), size: 48),
              SizedBox(height: 12),
              Text(
                'Audio generation coming soon',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8),
              Text(
                'In the meantime, try the Analytical or Story tabs for text-based learning.',
                style: TextStyle(color: Color(0xFF6B7A99), fontSize: 13, height: 1.5),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _analyticalTab() {
    if (_explanation.isEmpty) {
      return _emptyContent('No analytical content available');
    }
    return Column(
      children: [
        _infoCard(
          'Detailed Explanation',
          Icons.analytics,
          const Color(0xFF8466ff),
          [_mdBody(_explanation)],
        ),
        if (_tldrSummary.isNotEmpty) ...[
          const SizedBox(height: 16),
          _infoCard(
            'Quick Summary',
            Icons.summarize,
            const Color(0xFF43C59E),
            [_mdBody(_tldrSummary)],
          ),
        ],
      ],
    );
  }

  Widget _storyTab() {
    if (_storyMode.isEmpty) {
      return _emptyContent('No story content available');
    }
    return _infoCard(
      'Story Mode',
      Icons.menu_book,
      const Color(0xFFff6b6b),
      [
        _mdBody(_storyMode, lineHeight: 1.8),
      ],
    );
  }

  Widget _flashcardsTab() {
    if (_flashcards.isEmpty) {
      return _emptyContent('No flashcards available for this lesson yet.');
    }

    if (_flashcardsDone) {
      return _flashcardsCompletion();
    }

    final card = _flashcards[_flashcardIndex];
    final question = card['question'] as String? ?? '';
    final answer = card['answer'] as String? ?? '';
    final hint = card['hint'] as String? ?? '';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Progress indicator
        Text(
          'Card ${_flashcardIndex + 1} of ${_flashcards.length}',
          style: const TextStyle(color: Color(0xFF6B7A99), fontSize: 13),
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: (_flashcardIndex + 1) / _flashcards.length,
            minHeight: 4,
            backgroundColor: const Color(0xFF1E2A3A),
            valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF6C63FF)),
          ),
        ),
        const SizedBox(height: 16),

        // Card with flip animation
        GestureDetector(
          onTap: () {
            if (!_flashcardRevealed) {
              _flipController.forward();
              setState(() => _flashcardRevealed = true);
            }
          },
          child: AnimatedBuilder(
            animation: _flipAnimation,
            builder: (context, _) {
              final angle = _flipAnimation.value * pi;
              final isFront = angle < pi / 2;
              return Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..rotateY(angle),
                child: isFront
                    ? _flashcardFront(question, hint)
                    : Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.identity()..rotateY(pi),
                        child: _flashcardBack(answer),
                      ),
              );
            },
          ),
        ),

        const SizedBox(height: 16),

        // Action buttons
        Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 48,
                child: OutlinedButton(
                  onPressed: _advanceFlashcard,
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFFF5A623)),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text(
                    'Review Later',
                    style: TextStyle(
                        color: Color(0xFFF5A623),
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: SizedBox(
                height: 48,
                child: ElevatedButton(
                  onPressed: _advanceFlashcard,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF43C59E),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text(
                    'Got it ✓',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _flashcardFront(String question, String hint) {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(minHeight: 220),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF161B27),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFF1E2A3A)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            question,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              height: 1.5,
            ),
          ),
          if (hint.isNotEmpty) ...[
            const SizedBox(height: 12),
            Text(
              hint,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFF6B7A99),
                fontSize: 12,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
          const SizedBox(height: 16),
          const Text(
            'Tap to reveal',
            style: TextStyle(color: Color(0xFF6B7A99), fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _flashcardBack(String answer) {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(minHeight: 220),
      padding: const EdgeInsets.all(24),
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
              color: Color(0xFF43C59E), size: 28),
          const SizedBox(height: 12),
          Text(
            answer,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xFF6B7A99),
              fontSize: 15,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  void _advanceFlashcard() {
    _flipController.reset();
    setState(() {
      _flashcardRevealed = false;
      if (_flashcardIndex < _flashcards.length - 1) {
        _flashcardIndex++;
      } else {
        _flashcardsDone = true;
      }
    });
  }

  Widget _flashcardsCompletion() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 32),
          const Icon(Icons.check_circle_outline,
              color: Color(0xFF43C59E), size: 72),
          const SizedBox(height: 16),
          const Text(
            'All done!',
            style: TextStyle(
                color: Colors.white, fontSize: 22, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 8),
          const Text(
            'You\'ve reviewed all the flashcards.',
            style: TextStyle(color: Color(0xFF6B7A99), fontSize: 14),
          ),
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            height: 54,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF6C63FF), Color(0xFF4FC3F7)],
                ),
                borderRadius: BorderRadius.circular(14),
              ),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    '/quiz',
                    arguments: {'documentId': _documentId},
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                ),
                child: const Text(
                  'Take Quiz',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          TextButton(
            onPressed: () => setState(() {
              _flashcardIndex = 0;
              _flashcardRevealed = false;
              _flashcardsDone = false;
            }),
            child: const Text(
              'Review again',
              style: TextStyle(color: Color(0xFF6B7A99)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _mdBody(String text, {double fontSize = 14, double lineHeight = 1.6}) {
    return MarkdownBody(
      data: text,
      styleSheet: MarkdownStyleSheet(
        p: TextStyle(color: Colors.white70, fontSize: fontSize, height: lineHeight),
        strong: TextStyle(color: Colors.white, fontSize: fontSize, fontWeight: FontWeight.w600),
        em: TextStyle(color: Colors.white70, fontSize: fontSize, fontStyle: FontStyle.italic),
        h1: TextStyle(color: Colors.white, fontSize: fontSize + 6, fontWeight: FontWeight.bold),
        h2: TextStyle(color: Colors.white, fontSize: fontSize + 4, fontWeight: FontWeight.bold),
        h3: TextStyle(color: Colors.white, fontSize: fontSize + 2, fontWeight: FontWeight.w600),
        listBullet: TextStyle(color: Colors.white70, fontSize: fontSize),
        blockquoteDecoration: const BoxDecoration(
          color: Color(0xFF0D1117),
          border: Border(left: BorderSide(color: Color(0xFF6C63FF), width: 3)),
        ),
        blockquotePadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        code: TextStyle(
          color: const Color(0xFF4FC3F7),
          fontSize: fontSize - 1,
          backgroundColor: const Color(0xFF0D1117),
        ),
      ),
      shrinkWrap: true,
      softLineBreak: true,
    );
  }

  Widget _infoCard(
      String title, IconData icon, Color color, List<Widget> children) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1A2332),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 18),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...children,
        ],
      ),
    );
  }

  Widget _emptyContent(String message) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: const Color(0xFF1A2332),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Center(
        child: Text(
          message,
          style: const TextStyle(color: Color(0xFF6B7A99), fontSize: 14),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
