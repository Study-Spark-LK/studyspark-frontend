import 'package:flutter/material.dart';
import 'package:clerk_flutter/clerk_flutter.dart';
import 'package:studyspark/api/api_client.dart';
import 'package:studyspark/api/export.dart';

class PracticeScreen extends StatefulWidget {
  const PracticeScreen({super.key});

  @override
  State<PracticeScreen> createState() => _PracticeScreenState();
}

class _PracticeScreenState extends State<PracticeScreen> {
  bool _isLoading = true;
  List<Data5> _documents = [];
  String _selectedCategory = 'All';

  List<String> get _categories {
    final cats = _documents.map((d) => d.category ?? 'General').toSet().toList()..sort();
    return ['All', ...cats];
  }

  List<Data5> get _filtered {
    if (_selectedCategory == 'All') return _documents;
    return _documents
        .where((d) => d.category == _selectedCategory)
        .toList();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchClerkToken = () async {
        final auth = ClerkAuth.of(context);
        try {
          final sessionToken = await auth.sessionToken();
          return sessionToken.jwt;
        } catch (_) {
          return auth.session?.lastActiveToken?.jwt;
        }
      };
      _loadDocuments();
    });
  }

  Future<void> _loadDocuments() async {
    try {
      final auth = ClerkAuth.of(context);
      try {
        final sessionToken = await auth.sessionToken();
        rawDio.options.headers['Authorization'] = 'Bearer ${sessionToken.jwt}';
      } catch (_) {
        final jwt = auth.session?.lastActiveToken?.jwt;
        if (jwt != null) rawDio.options.headers['Authorization'] = 'Bearer $jwt';
      }
      final res = await apiClient.documents.getDocuments();
      setState(() {
        _documents = res.data
            .where((d) => d.status == Status.ready)
            .toList();
        _isLoading = false;
      });
    } catch (_) {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: _isLoading
          ? const Center(
              child: CircularProgressIndicator(color: Color(0xFF6C63FF)))
          : RefreshIndicator(
              onRefresh: _loadDocuments,
              color: const Color(0xFF6C63FF),
              backgroundColor: const Color(0xFF161B27),
              child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 4),
                    const Text(
                      'Practice & Quizzes',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildStatsRow(),
                    const SizedBox(height: 18),

                    if (_documents.isEmpty)
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.45,
                        child: Center(
                          child: _buildEmptyState(),
                        ),
                      )
                    else ...[
                      _buildCategoryChips(),
                      const SizedBox(height: 14),
                      ..._filtered.map((doc) => _buildDocumentCard(doc)),
                    ],

                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      margin: const EdgeInsets.only(top: 32),
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: const Color(0xFF161B27),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF1E2A3A)),
      ),
      child: Column(
        children: [
          const Icon(Icons.psychology_outlined,
              color: Color(0xFF6B7A99), size: 64),
          const SizedBox(height: 16),
          const Text(
            'No practice sessions yet',
            style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          const Text(
            'Upload a document and complete a lesson\nto unlock practice sessions here.',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Color(0xFF6B7A99), fontSize: 14, height: 1.5),
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () => Navigator.pushNamed(context, '/upload'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF6C63FF),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
            icon: const Icon(Icons.upload_file, color: Colors.white),
            label: const Text('Upload a Document',
                style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsRow() {
    final total = _documents.length;
    final completed = _documents
        .where((d) =>
            (d.progressPercentage.toDouble().clamp(0, 100)) >= 100)
        .length;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF1D293D),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildStatTile('$total', 'Lessons', Icons.menu_book_outlined),
          _buildStatTile(
              '$completed', 'Completed', Icons.check_circle_outline),
          _buildStatTile('${_flashcardCount()}', 'Flashcards',
              Icons.style_outlined),
        ],
      ),
    );
  }

  int _flashcardCount() => _documents.length * 5; // Estimated

  Widget _buildStatTile(String value, String title, IconData icon) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: const Color(0xFF4FC3F7), size: 16),
              const SizedBox(width: 6),
              Text(
                title,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.8),
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChips() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: _categories.map((item) {
          final selected = _selectedCategory == item;
          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: GestureDetector(
              onTap: () =>
                  setState(() => _selectedCategory = item),
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: selected
                      ? const Color(0xFF6C63FF)
                      : const Color(0xFF1B273A),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: selected
                        ? Colors.transparent
                        : Colors.white.withValues(alpha: 0.15),
                  ),
                ),
                child: Text(
                  item,
                  style: TextStyle(
                    color: selected
                        ? Colors.white
                        : Colors.white.withValues(alpha: 0.85),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildDocumentCard(Data5 doc) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/quiz', arguments: {
          'flashcards': <Map<String, dynamic>>[],
          'title': doc.title,
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Open the lesson first to access flashcards'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: const Color(0xFF131A28),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
              color: Colors.white.withValues(alpha: 0.09)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    doc.title ?? 'Processing...',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/output-result',
                        arguments: {
                          'documentId': doc.id,
                          'title': doc.title ?? '',
                          'category': doc.category ?? '',
                        });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF6C63FF),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(6),
                      child: Icon(Icons.play_arrow,
                          color: Colors.white, size: 20),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              doc.category ?? '',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.6),
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: (doc.progressPercentage.toDouble().clamp(0, 100)) /
                    100,
                minHeight: 6,
                backgroundColor: Colors.white.withValues(alpha: 0.1),
                valueColor: const AlwaysStoppedAnimation<Color>(
                    Color(0xFF6C63FF)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
