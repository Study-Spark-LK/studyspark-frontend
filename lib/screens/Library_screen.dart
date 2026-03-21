import 'package:flutter/material.dart';
import 'package:clerk_flutter/clerk_flutter.dart';
import 'package:studyspark/api/api_client.dart';
import 'package:studyspark/api/export.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  bool _isLoading = true;
  String _error = '';
  List<Data5> _documents = [];
  List<Data5> _filtered = [];
  String _selectedCategory = 'All';
  final TextEditingController _searchController = TextEditingController();

  List<String> get _categories {
    final cats = _documents.map((d) => d.category ?? 'General').toSet().toList()..sort();
    return ['All', ...cats];
  }

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_applyFilter);
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

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadDocuments() async {
    try {
      setState(() {
        _isLoading = true;
        _error = '';
      });
      final auth = ClerkAuth.of(context);
      try {
        final sessionToken = await auth.sessionToken();
        rawDio.options.headers['Authorization'] = 'Bearer ${sessionToken.jwt}';
      } catch (_) {
        final jwt = auth.session?.lastActiveToken?.jwt;
        if (jwt != null) rawDio.options.headers['Authorization'] = 'Bearer $jwt';
      }
      final res = await apiClient.documents.getDocuments();
      final docs = res.data;
      setState(() {
        _documents = docs;
        _filtered = docs;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _error = 'Failed to load documents';
      });
    }
  }

  void _applyFilter() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filtered = _documents.where((d) {
        final matchCat =
            _selectedCategory == 'All' || d.category == _selectedCategory;
        final matchSearch =
            query.isEmpty || (d.title ?? '').toLowerCase().contains(query);
        return matchCat && matchSearch;
      }).toList();
    });
  }

  void _selectCategory(String cat) {
    setState(() => _selectedCategory = cat);
    _applyFilter();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Row(
              children: [
                const Text(
                  'My Library',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.refresh,
                      color: Color(0xFF6B7A99), size: 20),
                  onPressed: _loadDocuments,
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Search bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              controller: _searchController,
              style: const TextStyle(color: Colors.white, fontSize: 14),
              decoration: InputDecoration(
                hintText: 'Search lessons...',
                hintStyle:
                    const TextStyle(color: Color(0xFF6B7A99), fontSize: 14),
                prefixIcon: const Icon(Icons.search_rounded,
                    color: Color(0xFF6B7A99), size: 20),
                filled: true,
                fillColor: const Color(0xFF161B27),
                contentPadding: const EdgeInsets.symmetric(vertical: 14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide:
                      const BorderSide(color: Color(0xFF1E2A3A), width: 1),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide:
                      const BorderSide(color: Color(0xFF1E2A3A), width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide:
                      const BorderSide(color: Color(0xFF6C63FF), width: 1),
                ),
              ),
            ),
          ),

          const SizedBox(height: 12),

          // Category chips
          if (_documents.isNotEmpty)
            SizedBox(
              height: 36,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: _categories
                    .map((c) => _categoryChip(c))
                    .toList(),
              ),
            ),

          const SizedBox(height: 12),

          // Body
          Expanded(
            child: RefreshIndicator(
              onRefresh: _loadDocuments,
              color: const Color(0xFF6C63FF),
              backgroundColor: const Color(0xFF161B27),
              child: _buildBody(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(color: Color(0xFF6C63FF)),
      );
    }

    if (_error.isNotEmpty) {
      return ListView(
        children: [
          const SizedBox(height: 80),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, color: Color(0xFF6B7A99), size: 48),
                const SizedBox(height: 12),
                Text(_error,
                    style: const TextStyle(color: Color(0xFF6B7A99), fontSize: 14)),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: _loadDocuments,
                  child: const Text('Retry',
                      style: TextStyle(color: Color(0xFF6C63FF))),
                ),
              ],
            ),
          ),
        ],
      );
    }

    if (_documents.isEmpty) {
      return ListView(
        children: const [
          Padding(
            padding: EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 48),
                Icon(Icons.library_books_outlined,
                    color: Color(0xFF6B7A99), size: 64),
                SizedBox(height: 16),
                Text(
                  'No documents yet',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 8),
                Text(
                  'Upload your first study material\nto get started.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Color(0xFF6B7A99), fontSize: 14, height: 1.5),
                ),
              ],
            ),
          ),
        ],
      );
    }

    if (_filtered.isEmpty) {
      return ListView(
        children: const [
          SizedBox(height: 80),
          Center(
            child: Text('No results found',
                style: TextStyle(color: Color(0xFF6B7A99), fontSize: 14)),
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            '${_filtered.length} lesson${_filtered.length == 1 ? '' : 's'}',
            style: const TextStyle(color: Color(0xFF6B7A99), fontSize: 13),
          ),
        ),
        const SizedBox(height: 8),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: _filtered.length,
            itemBuilder: (context, index) =>
                _lessonCard(_filtered[index]),
          ),
        ),
      ],
    );
  }

  Widget _categoryChip(String category) {
    final isSelected = _selectedCategory == category;
    return GestureDetector(
      onTap: () => _selectCategory(category),
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF6C63FF)
              : const Color(0xFF161B27),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF6C63FF)
                : const Color(0xFF1E2A3A),
            width: 1,
          ),
        ),
        child: Text(
          category,
          style: TextStyle(
            color: isSelected ? Colors.white : const Color(0xFF6B7A99),
            fontSize: 12,
            fontWeight:
                isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _lessonCard(Data5 doc) {
    final isReady = doc.status == Status.ready;
    final rawPct = doc.progressPercentage.toDouble();
    final progress = (rawPct < 0 ? 0.0 : rawPct / 100).clamp(0.0, 1.0);

    return GestureDetector(
      onTap: () {
        if (isReady) {
          Navigator.pushNamed(
            context,
            '/output-result',
            arguments: {
              'documentId': doc.id,
              'title': doc.title,
              'category': doc.category,
            },
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Still processing, please wait'),
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF161B27),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFF1E2A3A), width: 1),
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
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: isReady
                        ? const Color(0xFF43C59E).withValues(alpha: 0.15)
                        : const Color(0xFFF5A623).withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    isReady ? 'Ready' : 'Processing',
                    style: TextStyle(
                      color: isReady
                          ? const Color(0xFF43C59E)
                          : const Color(0xFFF5A623),
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              '${doc.category} • Tap to open',
              style: const TextStyle(
                  color: Color(0xFF6B7A99), fontSize: 12),
            ),
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: progress,
                backgroundColor: const Color(0xFF1E2A3A),
                valueColor: AlwaysStoppedAnimation<Color>(
                  isReady
                      ? const Color(0xFF6C63FF)
                      : const Color(0xFFF5A623),
                ),
                minHeight: 5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
