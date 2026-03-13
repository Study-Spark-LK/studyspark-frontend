class SubscriptionPlan {
  final String name;
  final double price;
  final String period;
  final String billDescription;
  final bool isPopular;

  SubscriptionPlan({
    required this.name,
    required this.price,
    required this.period,
    required this.billDescription,
    this.isPopular = false,
  });
}

class PlanFeature {
  final String title;
  final String description;

  PlanFeature({
    required this.title,
    required this.description,
  });
}

final List<SubscriptionPlan> subscriptionPlans = [
  SubscriptionPlan(
    name: 'Yearly Plan',
    price: 99.99,
    period: 'year',
    billDescription: '\$99.99/year',
    isPopular: true,
  ),
  SubscriptionPlan(
    name: 'Monthly Plan',
    price: 9.99,
    period: 'month',
    billDescription: '\$9.99/month',
    isPopular: false,
  ),
];

final List<PlanFeature> premiumFeatures = [
  PlanFeature(
    title: 'Unlimited PDF uploads per day',
    description: 'Upload as many PDFs as you need daily',
  ),
  PlanFeature(
    title: 'Upload handwritten notes & lectures',
    description: 'Support for multiple note formats',
  ),
  PlanFeature(
    title: 'Unlimited AI chatbot messages',
    description: 'Ask unlimited questions to our AI',
  ),
  PlanFeature(
    title: 'Personalized learning, videos & summaries',
    description: 'Get customized content for your learning',
  ),
  PlanFeature(
    title: 'Priority content processing',
    description: 'Fast processing of your uploads',
  ),
  PlanFeature(
    title: 'Advanced reports & analytics',
    description: 'Deep insights into your learning',
  ),
];
