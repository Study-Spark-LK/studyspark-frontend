import 'package:flutter/material.dart';
import 'package:clerk_flutter/clerk_flutter.dart';
import 'package:studyspark/api/api_client.dart';
import 'package:studyspark/api/export.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isLoading = true;
  String _userName = '';
  String _userEmail = '';
  double _visualScore = 0;
  double _auditoryScore = 0;
  double _readingScore = 0;
  double _kinestheticScore = 0;
  String _dominantStyle = '';
  String _dominantStyleDesc = '';

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
      _loadProfile();
    });
  }

  double get _varkTotal =>
      _visualScore + _auditoryScore + _readingScore + _kinestheticScore;

  double _pct(double score) => _varkTotal > 0 ? score / _varkTotal : 0;

  Future<void> _loadProfile() async {
    try {
      final auth = ClerkAuth.of(context);
      try {
        final sessionToken = await auth.sessionToken();
        rawDio.options.headers['Authorization'] = 'Bearer ${sessionToken.jwt}';
      } catch (_) {
        final jwt = auth.session?.lastActiveToken?.jwt;
        if (jwt != null) rawDio.options.headers['Authorization'] = 'Bearer $jwt';
      }

      final user = auth.user;
      final firstName = user?.firstName ?? '';
      final lastName = user?.lastName ?? '';
      final name = [firstName, lastName]
          .where((s) => s.isNotEmpty)
          .join(' ');

      String email = '';
      try {
        final addrs = user?.emailAddresses;
        if (addrs != null && addrs.isNotEmpty) {
          email =
              ((addrs.first as dynamic).emailAddress as String?) ?? '';
        }
      } catch (_) {}

      final profilesRes =
          await apiClient.profiles.getProfiles(status: Status2.all);
      final profiles = profilesRes.data;

      Data2? readyProfile;
      if (profiles.isNotEmpty) {
        try {
          readyProfile =
              profiles.firstWhere((p) => p.status == Status.ready);
        } catch (_) {
          readyProfile = null;
        }
      }

      double v = 0, a = 0, r = 0, k = 0;
      String dominant = 'Not yet determined';
      String dominantDesc =
          'Complete the learning style quiz to see your profile';

      if (readyProfile != null) {
        v = readyProfile.visualScore.toDouble().clamp(0, double.infinity);
        a = readyProfile.auditoryScore.toDouble().clamp(0, double.infinity);
        r = readyProfile.readingScore.toDouble().clamp(0, double.infinity);
        k = readyProfile.kinestheticScore.toDouble().clamp(0, double.infinity);

        final scores = {'Visual': v, 'Auditory': a, 'Reading': r, 'Kinesthetic': k};
        final maxEntry =
            scores.entries.reduce((a, b) => a.value > b.value ? a : b);
        switch (maxEntry.key) {
          case 'Visual':
            dominant = 'Visual Learner';
            dominantDesc = 'You learn best through images and diagrams';
            break;
          case 'Auditory':
            dominant = 'Auditory Learner';
            dominantDesc = 'You learn best through listening and discussion';
            break;
          case 'Reading':
            dominant = 'Reading/Writing Learner';
            dominantDesc = 'You learn best through reading and taking notes';
            break;
          default:
            dominant = 'Kinesthetic Learner';
            dominantDesc = 'You learn best through hands-on experience';
        }
      }

      setState(() {
        _userName = name.isEmpty ? 'User' : name;
        _userEmail = email;
        _visualScore = v;
        _auditoryScore = a;
        _readingScore = r;
        _kinestheticScore = k;
        _dominantStyle = dominant;
        _dominantStyleDesc = dominantDesc;
        _isLoading = false;
      });
    } catch (_) {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(color: Color(0xFF6C63FF)),
      );
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          // Header
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                const Expanded(
                  child: Center(
                    child: Text(
                      'My Profile',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.refresh,
                      color: Color(0xFF6B7A99), size: 20),
                  onPressed: () {
                    setState(() => _isLoading = true);
                    _loadProfile();
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),

          // Avatar + name + email
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFF0f1419),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: const BoxDecoration(
                    color: Color(0xFF6C63FF),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      _userName.isNotEmpty
                          ? _userName[0].toUpperCase()
                          : 'U',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  _userName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _userEmail.isNotEmpty ? _userEmail : 'No email on file',
                  style: const TextStyle(
                    color: Color(0xFF8b92a0),
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Learning Profile
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Learning Profile',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0f1419),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: const BoxDecoration(
                              color: Color(0xFF6C63FF),
                              shape: BoxShape.circle,
                            ),
                            child: const Center(
                              child: Icon(Icons.psychology,
                                  size: 24, color: Colors.white),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _dominantStyle,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  _dominantStyleDesc,
                                  style: const TextStyle(
                                    color: Color(0xFF8b92a0),
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      ..._buildVarkBars(),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Retake quiz button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF0f1419),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFF6C63FF)),
              ),
              child: const Row(
                children: [
                  Icon(Icons.refresh, color: Color(0xFF6C63FF), size: 20),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Retake Learning Style Quiz',
                      style: TextStyle(
                        color: Color(0xFF6C63FF),
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios,
                      color: Color(0xFF6C63FF), size: 16),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Sign Out
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: GestureDetector(
              onTap: _showSignOutDialog,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFF0f1419),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFff6b6b)),
                ),
                child: const Center(
                  child: Text(
                    'Sign Out',
                    style: TextStyle(
                      color: Color(0xFFff6b6b),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 32),
        ],
      ),
    );
  }

  List<Widget> _buildVarkBars() {
    final items = [
      {
        'label': 'Visual',
        'score': _visualScore,
        'color': const Color(0xFF6C63FF),
        'icon': Icons.visibility,
      },
      {
        'label': 'Auditory',
        'score': _auditoryScore,
        'color': const Color(0xFFffd60a),
        'icon': Icons.volume_up,
      },
      {
        'label': 'Reading',
        'score': _readingScore,
        'color': const Color(0xFF4FC3F7),
        'icon': Icons.menu_book,
      },
      {
        'label': 'Kinesthetic',
        'score': _kinestheticScore,
        'color': const Color(0xFF43C59E),
        'icon': Icons.sports_handball,
      },
    ];

    return items.map((item) {
      final score = item['score'] as double;
      final pct = _pct(score);
      final color = item['color'] as Color;
      final icon = item['icon'] as IconData;
      final label = item['label'] as String;
      final displayScore = (pct * 100).toInt();

      return Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Row(
          children: [
            Icon(icon, size: 20, color: color),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: pct,
                      minHeight: 6,
                      backgroundColor: const Color(0xFF404854),
                      valueColor: AlwaysStoppedAnimation<Color>(color),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Text(
              '$displayScore%',
              style: const TextStyle(
                color: Color(0xFF8b92a0),
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      );
    }).toList();
  }

  void _showSignOutDialog() {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: const Color(0xFF1a1f2e),
        title: const Text('Sign Out',
            style: TextStyle(color: Colors.white)),
        content: const Text(
          'Are you sure you want to sign out?',
          style: TextStyle(color: Color(0xFF8b92a0)),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel',
                style: TextStyle(color: Color(0xFF6C63FF))),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(dialogContext);
              await ClerkAuth.of(context).signOut();
            },
            child: const Text('Sign Out',
                style: TextStyle(color: Color(0xFFff6b6b))),
          ),
        ],
      ),
    );
  }
}
