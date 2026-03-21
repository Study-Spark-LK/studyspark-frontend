import 'package:flutter/material.dart';
import 'package:studyspark/api/api_client.dart';
import 'package:studyspark/api/models/data5.dart';
import 'package:studyspark/api/models/status.dart';
import 'package:studyspark/api/models/status2.dart';
import 'package:studyspark/state/app_state.dart';
import 'package:clerk_flutter/clerk_flutter.dart';

class UploadedLesson {
  final String title;
  final String subject;
  final String estimatedTime;
  final double progress;
  final String fileType; // 'pdf', 'video', 'doc', etc.

  const UploadedLesson({
    required this.title,
    required this.subject,
    required this.estimatedTime,
    required this.progress,
    required this.fileType,
  });

  String get progressLabel => '${(progress * 100).round()}%';
}

class LessonRepository {
  static final List<UploadedLesson> lessons = [];

  static void addLesson(UploadedLesson lesson) => lessons.add(lesson);

  static void updateProgress(String title, double progress) {
    final i = lessons.indexWhere((l) => l.title == title);
    if (i != -1) {
      final old = lessons[i];
      lessons[i] = UploadedLesson(
        title: old.title,
        subject: old.subject,
        estimatedTime: old.estimatedTime,
        progress: progress,
        fileType: old.fileType,
      );
    }
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isLoading = true;
  String? _userName;
  String? _dominantStyle;
  List<double> _varkScores = [];
  List<String> _hobbies = [];
  List<Data5> _documents = [];
  int _completedCount = 0;
  int _quizCount = 0;

  @override
  void initState() {
    super.initState();

    fetchClerkToken = () async =>
    ClerkAuth.of(context).session?.lastActiveToken?.jwt;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _loadData();
    });
  }



  Future<void> _loadData() async {
    try {
      final user = ClerkAuth.of(context).user;
      final userName = user?.firstName ?? 'there';

      final profilesResponse =
          await apiClient.profiles.getProfiles(status: Status2.all);
      final documentsResponse = await apiClient.documents.getDocuments();

      final profiles = profilesResponse.data;
      final readyProfile = profiles.cast<dynamic>().firstWhere(
            (p) => p.status == Status.ready,
            orElse: () => null,
          );

      String? dominantStyle;
      List<double> varkScores = [];
      if (readyProfile != null) {
        AppState.profileId = readyProfile.id as String;

        final v = (readyProfile.visualScore as num).toDouble().clamp(0.0, double.infinity);
        final a = (readyProfile.auditoryScore as num).toDouble().clamp(0.0, double.infinity);
        final r = (readyProfile.readingScore as num).toDouble().clamp(0.0, double.infinity);
        final k = (readyProfile.kinestheticScore as num).toDouble().clamp(0.0, double.infinity);
        final total = v + a + r + k;
        final safe = total == 0 ? 1.0 : total;

        varkScores = [
          (v / safe) * 100,
          (a / safe) * 100,
          (r / safe) * 100,
          (k / safe) * 100,
        ];

        final scoreMap = {
          'Visual': v,
          'Auditory': a,
          'Reading/Writing': r,
          'Kinesthetic': k,
        };
        dominantStyle =
            scoreMap.entries.reduce((a, b) => a.value >= b.value ? a : b).key;
      }

      final documents = documentsResponse.data;
      final completedCount =
          documents.where((d) => d.status == Status.ready).length;

      if (mounted) {
        setState(() {
          _isLoading = false;
          _userName = userName;
          _dominantStyle = dominantStyle;
          _varkScores = varkScores;
          _hobbies = [];
          _documents = documents;
          _completedCount = completedCount;
          _quizCount = 0;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading data: $e')),
        );
      }
    }
  }

  String _greeting() {
    final h = DateTime.now().hour;
    if (h < 12) return 'Good morning,';
    if (h < 17) return 'Good afternoon,';
    return 'Good evening,';
  }


  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(color: Color(0xFF6C63FF)),
      );
    }

    return SafeArea(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            _buildHeader(),
            const SizedBox(height: 24),
            _buildLearningStyleCard(),
            const SizedBox(height: 20),
            _buildStatsRow(),
            const SizedBox(height: 28),
            _buildContinueLearning(),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    final initial =
        (_userName?.isNotEmpty == true) ? _userName![0].toUpperCase() : 'U';
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _greeting(),
              style: const TextStyle(
                  color: Color(0xFF6B7A99),
                  fontSize: 13,
                  fontWeight: FontWeight.w400),
            ),
            const SizedBox(height: 4),
            Text(
              '${_userName ?? 'there'} 👋',
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
        Row(
          children: [
            GestureDetector(
              onTap: () async {
                await ClerkAuth.of(context).signOut();
                if (mounted) {
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil('/', (route) => false);
                }
              },
              child: const Icon(Icons.logout,
                  color: Color(0xFF4A5568), size: 22),
            ),
            const SizedBox(width: 12),
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF6C63FF), Color(0xFF4FC3F7)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(23),
              ),
              child: Center(
                child: Text(initial,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLearningStyleCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF161B27),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF1E2A3A), width: 1),
      ),
      child: _dominantStyle == null
          ? const Text(
              'Setting up your profile...',
              style: TextStyle(color: Color(0xFF6B7A99), fontSize: 14),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.remove_red_eye_outlined,
                        color: Color(0xFF6C63FF), size: 20),
                    const SizedBox(width: 10),
                    const Text('Your Learning Style',
                        style:
                            TextStyle(color: Color(0xFF6B7A99), fontSize: 13)),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        '$_dominantStyle Learner',
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                if (_hobbies.isNotEmpty) ...[
                  const SizedBox(height: 14),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _hobbies
                        .map((h) => Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 5),
                              decoration: BoxDecoration(
                                color: const Color(0xFF6C63FF)
                                    .withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(h,
                                  style: const TextStyle(
                                      color: Color(0xFFA89CFF), fontSize: 12)),
                            ))
                        .toList(),
                  ),
                ],
                const SizedBox(height: 18),
                Row(
                  children: [
                    Expanded(
                        child: _buildVarkBar(
                            'Visual',
                            _varkScores.isNotEmpty ? _varkScores[0] : 0,
                            const Color(0xFF6C63FF))),
                    const SizedBox(width: 16),
                    Expanded(
                        child: _buildVarkBar(
                            'Auditory',
                            _varkScores.length > 1 ? _varkScores[1] : 0,
                            const Color(0xFF4FC3F7))),
                  ],
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    Expanded(
                        child: _buildVarkBar(
                            'Reading',
                            _varkScores.length > 2 ? _varkScores[2] : 0,
                            const Color(0xFF43C59E))),
                    const SizedBox(width: 16),
                    Expanded(
                        child: _buildVarkBar(
                            'Kinesthetic',
                            _varkScores.length > 3 ? _varkScores[3] : 0,
                            const Color(0xFFF5A623))),
                  ],
                ),
              ],
            ),
    );
  }

  Widget _buildVarkBar(String label, double score, Color color) {
    final safeScore = score < 0 ? 0.0 : score;
    final progress = (safeScore / 100).clamp(0.0, 1.0);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label,
                style:
                    const TextStyle(color: Color(0xFF6B7A99), fontSize: 11)),
            Text('${safeScore.round()}%',
                style: TextStyle(
                    color: color,
                    fontSize: 11,
                    fontWeight: FontWeight.w600)),
          ],
        ),
        const SizedBox(height: 5),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: progress,
            backgroundColor: const Color(0xFF1E2A3A),
            valueColor: AlwaysStoppedAnimation<Color>(color),
            minHeight: 6,
          ),
        ),
      ],
    );
  }

  Widget _buildStatsRow() {
    return Row(
      children: [
        Expanded(
            child: _buildStatCard(
                '${_documents.length}', 'Documents', const Color(0xFF6C63FF))),
        const SizedBox(width: 12),
        Expanded(
            child: _buildStatCard(
                '$_completedCount', 'Completed', const Color(0xFF4FC3F7))),
        const SizedBox(width: 12),
        Expanded(
            child: _buildStatCard(
                '$_quizCount', 'Quizzes', const Color(0xFF43C59E))),
      ],
    );
  }

  Widget _buildStatCard(String value, String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF161B27),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFF1E2A3A), width: 1),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(value,
              style: TextStyle(
                  color: color, fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(label,
              style:
                  const TextStyle(color: Color(0xFF6B7A99), fontSize: 11)),
        ],
      ),
    );
  }

  Widget _buildContinueLearning() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Continue Learning',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700)),
            TextButton(
              onPressed: () {},
              child: const Text('See all',
                  style: TextStyle(color: Color(0xFF6C63FF), fontSize: 13)),
            ),
          ],
        ),
        const SizedBox(height: 12),
        if (_documents.isEmpty)
          _buildEmptyDocuments()
        else
          ..._documents.take(3).map(_buildDocumentCard),
      ],
    );
  }

  Widget _buildEmptyDocuments() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 24),
      decoration: BoxDecoration(
        color: const Color(0xFF161B27),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF1E2A3A), width: 1),
      ),
      child: const Column(
        children: [
          Icon(Icons.upload_file_outlined, color: Color(0xFF6C63FF), size: 36),
          SizedBox(height: 14),
          Text(
            'No documents yet. Upload your first study\nmaterial to get started.',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Color(0xFF6B7A99), fontSize: 13, height: 1.6),
          ),
        ],
      ),
    );
  }

  Widget _buildDocumentCard(Data5 doc) {
    final isReady = doc.status == Status.ready;
    final rawPct = doc.progressPercentage.toDouble();
    final progress = (rawPct < 0 ? 0.0 : rawPct / 100).clamp(0.0, 1.0);

    return GestureDetector(
      onTap: () {
        if (isReady) {
          Navigator.pushNamed(context, '/analytical',
              arguments: {'documentId': doc.id});
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Still processing, please wait')),
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
                    isReady ? doc.title : 'Processing...',
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
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
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(doc.category,
                style:
                    const TextStyle(color: Color(0xFF6B7A99), fontSize: 11)),
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: progress,
                backgroundColor: const Color(0xFF1E2A3A),
                valueColor: AlwaysStoppedAnimation<Color>(
                  isReady ? const Color(0xFF6C63FF) : const Color(0xFFF5A623),
                ),
                minHeight: 4,
              ),
            ),
          ],
        ),
      ),
    );
  }

}

