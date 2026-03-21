import 'package:flutter/material.dart';
import '../models/subscription_plan.dart';
import 'premium_plan_card.dart';

class PlanSelectionSection extends StatefulWidget {
  final Function(SubscriptionPlan) onPlanSelected;

  const PlanSelectionSection({
    super.key,
    required this.onPlanSelected,
  });

  @override
  State<PlanSelectionSection> createState() => _PlanSelectionSectionState();
}

class _PlanSelectionSectionState extends State<PlanSelectionSection> {
  late SubscriptionPlan selectedPlan;

  @override
  void initState() {
    super.initState();
    selectedPlan = subscriptionPlans[0];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: subscriptionPlans.length,
          itemBuilder: (context, index) {
            final plan = subscriptionPlans[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: PremiumPlanCard(
                plan: plan,
                isSelected: selectedPlan.name == plan.name,
                onTap: () {
                  setState(() {
                    selectedPlan = plan;
                  });
                  widget.onPlanSelected(plan);
                },
              ),
            );
          },
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
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Current: Free Plan',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8),
          Text(
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
