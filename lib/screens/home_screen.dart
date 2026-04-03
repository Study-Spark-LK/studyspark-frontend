import 'package:flutter/material.dart';
import 'package:studyspark/api/api_client.dart';
import 'package:studyspark/api/models/data5.dart';
import 'package:studyspark/api/models/status.dart';
import 'package:studyspark/api/models/status2.dart';
import 'package:studyspark/state/app_state.dart';
import 'package:clerk_flutter/clerk_flutter.dart';


// Simple data model for uploaded lessons 
class UploadedLesson {
  final String title; //lesson title
  final String subject; //subject name
  final String estimatedTime;
  final double progress; // 0.0 to 1.0
  final String fileType; // 'pdf', 'video', 'doc', etc.

  const UploadedLesson({
    required this.title,
    required this.subject,
    required this.estimatedTime,
    required this.progress,
    required this.fileType,
  });

  //Convert progress to percentage string
  String get progressLabel => '${(progress * 100).round()}%';
}


// Repository for managing uploaded lessons in memory
class LessonRepository {
  // In-memory list of lessons, simulating a simple data store
  static final List<UploadedLesson> lessons = [];

  // Add a new lesson to the repository
  static void addLesson(UploadedLesson lesson) => lessons.add(lesson);

  // Update progress of a lesson by title
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


// Main home screen widget
class HomeScreen extends StatefulWidget {
  // Constructor with optional callback for "See all" button in Continue Learning section
  const HomeScreen({super.key, this.onSeeAll});

  final VoidCallback? onSeeAll;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}


// State for home screen, handles data fetching and UI updates
class _HomeScreenState extends State<HomeScreen> {
  bool _isLoading = true; //show loader while fetching data
  String? _userName; //user name for greeting
  String? _dominantStyle; //dominant learning style VARK
  List<double> _varkScores = []; //VARK scores for bars
  List<String> _hobbies = []; //hobbies/interests for tags
  List<Data5> _documents = []; //user's uploaded documents
  int _completedCount = 0;
  int _quizCount = 0;

  @override
  // Initialize state and fetch data on load
  void initState() {
    super.initState();
    
    // Inject token into API calls
    fetchClerkToken = () async {
      final auth = ClerkAuth.of(context);
      try {
        final sessionToken = await auth.sessionToken();
        return sessionToken.jwt;
      } catch (_) {
        return auth.session?.lastActiveToken?.jwt;
      }
    };
    //Run after UI is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _loadData();
    });
  }


// Load user info, profiles, and documents
  Future<void> _loadData() async {
    // a. Get user name for greeting
    try {
      final auth = ClerkAuth.of(context);
      String? token;
      // b. Fetch a fresh token and set it on rawDio for authentication with backend
      try {
        final sessionToken = await auth.sessionToken();
        token = sessionToken.jwt;
      } 
      // If fetching a new token fails, try to get the last active token from the session
      catch (_) {
        token = auth.session?.lastActiveToken?.jwt;
      }
      // Set the token in rawDio for authenticated API calls
      if (token != null) {
        rawDio.options.headers['Authorization'] = 'Bearer $token';
      }

      // Fetch user info, profiles, and documents in parallel
      final user = auth.user;
      final userName = user?.firstName ?? 'there';

      // Fetch profiles and documents concurrently
      final profilesResponse =
          await apiClient.profiles.getProfiles(status: Status2.all);
      final documentsResponse = await apiClient.documents.getDocuments();

      final profiles = profilesResponse.data;

      //Find ready profile or null if none
      final readyProfile = profiles.cast<dynamic>().firstWhere(
            (p) => p.status == Status.ready,
            orElse: () => null,
          );

      // Determine dominant learning style and calculate VARK percentages if profile is ready
      String? dominantStyle;
      List<double> varkScores = [];
      if (readyProfile != null) {
        // Store profile ID in global state for later use
        AppState.profileId = readyProfile.id as String;

        // Calculate VARK percentages
        final v = (readyProfile.visualScore as num).toDouble().clamp(0.0, double.infinity);
        final a = (readyProfile.auditoryScore as num).toDouble().clamp(0.0, double.infinity);
        final r = (readyProfile.readingScore as num).toDouble().clamp(0.0, double.infinity);
        final k = (readyProfile.kinestheticScore as num).toDouble().clamp(0.0, double.infinity);
        final total = v + a + r + k; //Total score
        final safe = total == 0 ? 1.0 : total; // prevent divide by zero

        //Convert to percentages
        varkScores = [
          (v / safe) * 100,
          (a / safe) * 100,
          (r / safe) * 100,
          (k / safe) * 100,
        ];

        //Find highest score and corresponding style
        final scoreMap = {
          'Visual': v,
          'Auditory': a,
          'Reading/Writing': r,
          'Kinesthetic': k,
        };
        // Get the style with the highest score, if there's a tie it will take the first one in the map order
        dominantStyle =
            scoreMap.entries.reduce((a, b) => a.value >= b.value ? a : b).key;
      }

      final documents = documentsResponse.data;

      // Count how many documents are completed (status == ready)
      final completedCount =
          documents.where((d) => d.status == Status.ready).length;


      // updated UI with fetched data
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
    } 
    // Show error if data fetching fails
    catch (e) {
      // Log the error and show a snackbar message
      if (mounted) {
        setState(() => _isLoading = false); // stop loading indicator on error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading data: $e')),
        );
      }
    }
  }

  // Generate greeting based on time of day
  String _greeting() {
    final h = DateTime.now().hour;
    if (h < 12) return 'Good morning,';
    if (h < 17) return 'Good afternoon,';
    return 'Good evening,';
  }


  @override

  // Build the main UI of the home screen, showing loading indicator, greeting, learning style card, stats, and continue learning section
  Widget build(BuildContext context) {

    // Show loading indicator while fetching data
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(color: Color(0xFF6C63FF)),
      );
    }

    return SafeArea(
      child: RefreshIndicator(
        onRefresh: _loadData, //pull to refresh functionality
        color: const Color(0xFF6C63FF),
        backgroundColor: const Color(0xFF161B27),
        child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
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
      ),
    );
  }


// Header UI
  Widget _buildHeader() {
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
        Stack(
          clipBehavior: Clip.none,
          children: [
            IconButton(
              icon: const Icon(Icons.notifications_outlined,
                  color: Colors.white, size: 26),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Notifications coming soon'),
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Color(0xFF1E2A3A),
                  ),
                );
              },
            ),
            Positioned(
              top: 8,
              right: 8,
              child: Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: Color(0xFFE24B4A),
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }


// Learning style card UI
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


// VARK progress bar UI
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


// Stats row UI
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


// Continue learning section UI
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
              onPressed: widget.onSeeAll ?? () => Navigator.pushNamed(context, '/library'),
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


// Document card UI
  Widget _buildDocumentCard(Data5 doc) {
    final isReady = doc.status == Status.ready;
    final rawPct = doc.progressPercentage.toDouble();
    final progress = (rawPct < 0 ? 0.0 : rawPct / 100).clamp(0.0, 1.0);

    return GestureDetector(
      onTap: () {
        if (isReady) {
          Navigator.pushNamed(context, '/output-result', arguments: {
            'documentId': doc.id,
            'title': doc.title,
            'category': doc.category,
          });
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
                    isReady ? (doc.title ?? 'Untitled') : 'Processing...',
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
            Text(doc.category ?? '',
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

