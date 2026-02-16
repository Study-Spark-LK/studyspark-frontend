import 'package:flutter/material.dart';
import '../models/subscription_plan.dart';
import '../widgets/premium_plan_card.dart';
import '../widgets/premium_features_list.dart';
import '../widgets/plan_selection_section.dart';

class PremiumUpgradeScreen extends StatefulWidget {
  const PremiumUpgradeScreen({super.key});

  @override
  State<PremiumUpgradeScreen> createState() => _PremiumUpgradeScreenState();
}

class _PremiumUpgradeScreenState extends State<PremiumUpgradeScreen> {
  late SubscriptionPlan selectedPlan;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    selectedPlan = subscriptionPlans[0];
  }

  void _handlePlanSelected(SubscriptionPlan plan) {
    setState(() {
      selectedPlan = plan;
    });
  }

  Future<void> _handleContinueToUpgrade() async {
    setState(() {
      isLoading = true;
    });

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      isLoading = false;
    });

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Upgrading to ${selectedPlan.name}...'),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1a1f2e),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF1a1f2e),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
          'Upgrade to Premium',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header Section
            Container(
              color: const Color(0xFF1a1f2e),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: Column(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFFFA500),
                    ),
                    child: const Icon(
                      Icons.star,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Upgrade to Premium',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Unlock unlimited learning potential',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF8b92a0),
                    ),
                  ),
                ],
              ),
            ),
            // Plans Section
            Container(
              color: const Color(0xFF0f1419),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Choose Your Plan',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  PlanSelectionSection(
                    onPlanSelected: _handlePlanSelected,
                  ),
                  const SizedBox(height: 16),
                  const CurrentPlanSection(),
                ],
              ),
            ),
            // Features Section
            Container(
              color: const Color(0xFF1a1f2e),
              padding: const EdgeInsets.all(16),
              child: PremiumFeaturesList(
                features: premiumFeatures,
              ),
            ),
            // Feature Cards Section
            Container(
              color: const Color(0xFF0f1419),
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildFeatureCard(
                        icon: Icons.document_scanner,
                        label: 'PDF\nUpload',
                      ),
                      _buildFeatureCard(
                        icon: Icons.rate_review,
                        label: 'Review\nNotes',
                      ),
                      _buildFeatureCard(
                        icon: Icons.chat,
                        label: 'AI\nChat',
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // CTA Button & Terms
            Container(
              color: const Color(0xFF1a1f2e),
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: isLoading ? null : _handleContinueToUpgrade,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFFA500),
                        disabledBackgroundColor: Colors.grey.shade700,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: isLoading
                          ? const SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.white,
                                ),
                                strokeWidth: 2,
                              ),
                            )
                          : const Text(
                              'Continue to Premium',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      'By continuing, you agree to our Terms of Service and Privacy Policy',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF8b92a0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureCard({
    required IconData icon,
    required String label,
  }) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color(0xFF1a1f2e),
            border: Border.all(
              color: const Color(0xFF8b92a0),
              width: 1,
            ),
          ),
          child: Icon(
            icon,
            size: 28,
            color: const Color(0xFFFFA500),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}

class CurrentPlanSection extends StatelessWidget {
  const CurrentPlanSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1a1f2e),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF8b92a0),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Current: Free Plan',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            '• Limited PDF uploads per day\n• Limited chatbot messages\n• PDF summaries only',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Color(0xFF8b92a0),
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}
