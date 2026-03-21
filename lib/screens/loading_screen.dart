import 'package:flutter/material.dart';
import 'package:clerk_flutter/clerk_flutter.dart';
import 'package:studyspark/api/api_client.dart';
import 'package:studyspark/api/export.dart';

class LoadingScreen extends StatefulWidget {
  final String documentId;
  final String title;
  final String category;

  const LoadingScreen({
    super.key,
    required this.documentId,
    required this.title,
    required this.category,
  });

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double _progress = 0.05;
  int _pollCount = 0;
  static const int _maxPolls = 20; // 60 seconds max (3s interval)
  bool _polling = false;

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
      _startPolling();
    });
  }

  Future<void> _startPolling() async {
    if (_polling) return;
    _polling = true;
    // Give the backend a moment to register the document
    await Future.delayed(const Duration(seconds: 3));
    _poll();
  }

  Future<void> _poll() async {
    if (!mounted) return;

    // Refresh token before each poll so it never expires mid-session
    final auth = ClerkAuth.of(context);
    try {
      final sessionToken = await auth.sessionToken();
      rawDio.options.headers['Authorization'] = 'Bearer ${sessionToken.jwt}';
    } catch (_) {
      final jwt = auth.session?.lastActiveToken?.jwt;
      if (jwt != null) rawDio.options.headers['Authorization'] = 'Bearer $jwt';
    }

    if (_pollCount >= _maxPolls) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
                'This is taking longer than expected. Check back in your Library.'),
            behavior: SnackBarBehavior.floating,
          ),
        );
        Navigator.pop(context);
      }
      return;
    }

    try {
      final response = await apiClient.documents
          .getDocumentsDocumentId(documentId: widget.documentId);
      final doc = response.data;

      if (doc.status == Status.ready) {
        if (!mounted) return;
        setState(() => _progress = 1.0);
        await Future.delayed(const Duration(milliseconds: 600));
        if (!mounted) return;
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/output-result',
          (route) => route.isFirst,
          arguments: {
            'documentId': widget.documentId,
            'title': doc.title,
            'category': doc.category,
          },
        );
        return;
      }
    } catch (_) {
      // Continue polling on transient errors
    }

    _pollCount++;
    // Animate progress bar slowly toward 0.9
    if (mounted) {
      setState(() {
        _progress = (_progress + 0.04).clamp(0.0, 0.9);
      });
    }

    await Future.delayed(const Duration(seconds: 3));
    _poll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1117),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D1117),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Creating Your Lesson',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),

            const Text(
              'Creating your lesson',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              widget.title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFF6C63FF),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              'Analyzing content and personalizing for your learning style...',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.6),
                fontSize: 13,
                height: 1.5,
              ),
            ),

            const SizedBox(height: 40),

            SizedBox(
              width: 130,
              height: 130,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CircularProgressIndicator(
                    value: _progress,
                    strokeWidth: 8,
                    backgroundColor: const Color(0xFF1E2A3A),
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      Color(0xFF6C63FF),
                    ),
                  ),
                  Text(
                    '${(_progress * 100).toInt()}%',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            _buildStep('Extracting content from PDF'),
            _buildStep('Analyzing learning concepts'),
            _buildStep('Personalizing to your VARK style'),

            const Spacer(),
          ],
        ),
      ),
    );
  }

  Widget _buildStep(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.check_circle, color: Color(0xFF43C59E), size: 18),
          const SizedBox(width: 10),
          Text(
            text,
            style: const TextStyle(
              color: Color(0xFF6B7A99),
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}
