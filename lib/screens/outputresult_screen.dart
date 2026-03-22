import 'dart:convert';
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

class _OutputresultScreenState extends State<OutputresultScreen> {
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

  // Draggable chat icon position
  double _chatTop = 500;
  double _chatLeft = 300;

  final _types = ['Visual', 'Audio', 'Analytical', 'Story'];

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
            : (jsonDecode(fcData as String) as List);
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
      print(e);
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
                          Row(
                            children: List.generate(_types.length, (i) {
                              return Expanded(
                                child: GestureDetector(
                                  onTap: () =>
                                      setState(() => _selectedType = i),
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 3),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    decoration: BoxDecoration(
                                      color: _selectedType == i
                                          ? const Color(0xFF6C63FF)
                                          : const Color(0xFF1A2332),
                                      borderRadius:
                                          BorderRadius.circular(12),
                                    ),
                                    child: Center(
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
                                  ),
                                ),
                              );
                            }),
                          ),

                          const SizedBox(height: 20),

                          // Content for selected tab
                          _buildContent(),

                          const SizedBox(height: 20),

                          // Take Quiz button
                          if (_flashcards.isNotEmpty)
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                    context,
                                    '/quiz',
                                    arguments: {
                                      'flashcards': _flashcards,
                                      'title': _title,
                                    },
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color(0xFF6C63FF),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 16),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: const Text(
                                  'Take Quiz',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),

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
