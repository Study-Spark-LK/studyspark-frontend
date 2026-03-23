import 'package:flutter/material.dart';

class PremiumFeaturesActivatedScreen extends StatelessWidget {
  const PremiumFeaturesActivatedScreen({Key? key}) : super(key: key);

  static const _backgroundColor = Color(0xFF0F172A);
  static const _panelColor = Color(0xFF111827);
  static const _accentColor = Color(0xFFFACC15);
  //static const _buttonColor = Color(0xFF1F2937);
  static const _textColor = Colors.white;

  Widget _buildQuickAction({
    required IconData icon,
    required String label,
    Color iconBg = const Color(0xFF1F2937),
  }) {
    return Container(
      decoration: BoxDecoration(
        color: _panelColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white10),
      ),
      padding: const EdgeInsets.all(14),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.all(12),
            child: Icon(icon, color: _accentColor, size: 24),
          ),
          const SizedBox(height: 10),
          Text(
            label,
            style: const TextStyle(
              color: _textColor,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildBadge(String label, IconData icon, Color bg) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: Colors.white),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: _backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              const Row(
                children: [
                  CircleAvatar(
                    radius: 22,
                    backgroundColor: Color(0xFF1F2937),
                    child: Text(
                      'A',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  Text(
                    'Welcome, Alex!',
                    style: TextStyle(
                      color: _textColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Premium card
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFF1F2937),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white12),
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.workspace_premium, color: _accentColor, size: 28),
                        SizedBox(width: 10),
                        Text(
                          'STUDYSPARK PREMIUM UNLOCKED!',
                          style: TextStyle(
                            color: _textColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.all(12),
                      child: const Text(
                        'Unlimited Access Active',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 22),

              const Text(
                'Quick Actions',
                style: TextStyle(
                  color: _textColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),

              GridView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: media.width > 500 ? 4 : 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1.05,
                ),
                children: [
                  _buildQuickAction(
                    icon: Icons.picture_as_pdf,
                    label: 'Try Unlimited\nPDF Upload',
                  ),
                  _buildQuickAction(
                    icon: Icons.chat,
                    label: 'Chat with\nPro AI',
                  ),
                  _buildQuickAction(
                    icon: Icons.file_download,
                    label: 'Access\nDownloads',
                  ),
                  _buildQuickAction(
                    icon: Icons.create,
                    label: 'Create\nHandwritten Notes',
                  ),
                ],
              ),
              const SizedBox(height: 18),

              const Text(
                'New Feature Badges',
                style: TextStyle(
                  color: _textColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),

              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  _buildBadge('Premium', Icons.star, const Color(0xFFCA8A04)),
                  _buildBadge('Premium', Icons.star, const Color(0xFFCA8A04)),
                  _buildBadge('Premium', Icons.star, const Color(0xFFCA8A04)),
                  _buildBadge('Unlimited', Icons.flash_on, const Color(0xFF14B8A6)),
                ],
              ),
              const SizedBox(height: 18),

              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: _panelColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.all(14),
                child: const Text(
                  'Ready to study like a pro? Dive in!',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}