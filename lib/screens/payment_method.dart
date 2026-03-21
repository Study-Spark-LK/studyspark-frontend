import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PaymentMethodScreen extends StatefulWidget {
  const PaymentMethodScreen({super.key});

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  late TextEditingController _cardNumberController;
  late TextEditingController _cardholderNameController;
  late TextEditingController _expiryDateController;
  late TextEditingController _cvvController;

  bool _agreeToTerms = false;
  bool _isProcessing = false;
  String? _selectedPaymentMethod;

  @override
  void initState() {
    super.initState();
    _cardNumberController = TextEditingController();
    _cardholderNameController = TextEditingController();
    _expiryDateController = TextEditingController();
    _cvvController = TextEditingController();
  }

  @override
  void dispose() {
    _cardNumberController.dispose();
    _cardholderNameController.dispose();
    _expiryDateController.dispose();
    _cvvController.dispose();
    super.dispose();
  }

  String _formatCardNumber(String value) {
    String cleaned = value.replaceAll(RegExp(r'\s'), '');
    if (cleaned.length > 16) {
      cleaned = cleaned.substring(0, 16);
    }
    String formatted = '';
    for (int i = 0; i < cleaned.length; i++) {
      if (i > 0 && i % 4 == 0) {
        formatted += ' ';
      }
      formatted += cleaned[i];
    }
    return formatted;
  }

  String _formatExpiryDate(String value) {
    String cleaned = value.replaceAll(RegExp(r'\D'), '');
    if (cleaned.length > 4) {
      cleaned = cleaned.substring(0, 4);
    }
    if (cleaned.length >= 2) {
      return '${cleaned.substring(0, 2)}/${cleaned.substring(2)}';
    }
    return cleaned;
  }

  void _handlePayment() {
    if (_cardNumberController.text.isEmpty ||
        _cardholderNameController.text.isEmpty ||
        _expiryDateController.text.isEmpty ||
        _cvvController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all payment details'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (!_agreeToTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please agree to the terms and conditions'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _isProcessing = true;
    });

    // Simulate payment processing
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isProcessing = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Payment processed successfully!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    });
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
        centerTitle: false,
        title: const Text(
          'Payment Details',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Subtitle
              const Text(
                'Enter your card information securely',
                style: TextStyle(
                  color: Color(0xFF9CA3AF),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 24),

              // Plan Details Card
              _buildPlanDetailsCard(),
              const SizedBox(height: 24),

              // Security Message
              _buildSecurityMessage(),
              const SizedBox(height: 24),

              // Card Number Input
              _buildInputField(
                label: 'Card Number',
                controller: _cardNumberController,
                hintText: '1234 5678 9012 3456',
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                onChanged: (value) {
                  _cardNumberController.value = TextEditingValue(
                    text: _formatCardNumber(value),
                    selection: TextSelection.fromPosition(
                      TextPosition(offset: _formatCardNumber(value).length),
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),

              // Cardholder Name Input
              _buildInputField(
                label: 'Cardholder Name',
                controller: _cardholderNameController,
                hintText: 'John Doe',
              ),
              const SizedBox(height: 16),

              // Expiry Date and CVV Row
              Row(
                children: [
                  Expanded(
                    child: _buildInputField(
                      label: 'Expiry Date',
                      controller: _expiryDateController,
                      hintText: 'MM/YY',
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      onChanged: (value) {
                        _expiryDateController.value = TextEditingValue(
                          text: _formatExpiryDate(value),
                          selection: TextSelection.fromPosition(
                            TextPosition(
                                offset: _formatExpiryDate(value).length),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildInputField(
                      label: 'CVV',
                      controller: _cvvController,
                      hintText: '123',
                      maxLength: 3,
                      isPassword: true,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Payment Methods
              _buildPaymentMethods(),
              const SizedBox(height: 24),

              // Terms Checkbox
              _buildTermsCheckbox(),
              const SizedBox(height: 24),

              // Pay Button
              _buildPayButton(),
              const SizedBox(height: 16),

              // Security Footer Note
              const Text(
                'Payments are processed securely. Your card details are never stored.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF9CA3AF),
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPlanDetailsCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF252d3d),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF3a4456), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Plan Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'StudySpark Premium',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFA500),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'Yearly',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Annual Subscription
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Annual Subscription',
                style: TextStyle(
                  color: Color(0x99FFFFFF),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                '\$99',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Annual Savings
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Annual Savings',
                style: TextStyle(
                  color: Color(0xFF4ECB71),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Row(
                children: [
                  Text(
                    '.99',
                    style: TextStyle(
                      color: Color(0xFF4ECB71),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(width: 8),
                  Text(
                    '\$19.80',
                    style: TextStyle(
                      color: Color(0xFF6B7280),
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            height: 1,
            color: const Color(0xFF3a4456),
          ),
          const SizedBox(height: 16),

          // Total Due Today
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Due Today',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '\$99.99',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSecurityMessage() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F5E9),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFF4ECB71), width: 1),
      ),
      child: const Row(
        children: [
          Icon(Icons.lock, color: Color(0xFF4ECB71), size: 20),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              'Your payment information is encrypted and secure',
              style: TextStyle(
                color: Color(0xFF2E7D32),
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    required String hintText,
    List<TextInputFormatter>? inputFormatters,
    void Function(String)? onChanged,
    int? maxLength,
    bool isPassword = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          obscureText: isPassword,
          inputFormatters: inputFormatters,
          onChanged: onChanged,
          maxLength: maxLength,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
          cursorColor: const Color(0xFFFFA500),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(
              color: Color(0xFF6B7280),
              fontSize: 14,
            ),
            filled: true,
            fillColor: const Color(0xFF252d3d),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFF3a4456), width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFF3a4456), width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide:
                  const BorderSide(color: Color(0xFFFFA500), width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 10,
            ),
            counterText: '',
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentMethods() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'We accept',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _buildPaymentMethodButton('visa', 'Visa'),
            const SizedBox(width: 12),
            _buildPaymentMethodButton('mastercard', 'MC'),
            const SizedBox(width: 12),
            _buildPaymentMethodButton('amex', 'AMEX'),
          ],
        ),
      ],
    );
  }

  Widget _buildPaymentMethodButton(String id, String label) {
    bool isSelected = _selectedPaymentMethod == id;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedPaymentMethod = id;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFFFFA500)
              : const Color(0xFF252d3d),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected
                ? const Color(0xFFFFA500)
                : const Color(0xFF3a4456),
            width: 1,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.black : Colors.white,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildTermsCheckbox() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F4F6),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Checkbox(
            value: _agreeToTerms,
            onChanged: (value) {
              setState(() {
                _agreeToTerms = value ?? false;
              });
            },
            fillColor: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.selected)) {
                return const Color(0xFFFFA500);
              }
              return const Color(0xFFE5E7EB);
            }),
            side: const BorderSide(color: Color(0xFFD1D5DB), width: 1),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: 'By confirming your purchase, you agree to be charged ',
                      style: TextStyle(
                        color: Color(0xFF374151),
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    TextSpan(
                      text: '\$99.99 annually',
                      style: TextStyle(
                        color: Color(0xFF111827),
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextSpan(
                      text:
                          '. Your subscription will automatically renew unless cancelled. You can cancel anytime from your profile settings.',
                      style: TextStyle(
                        color: Color(0xFF374151),
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPayButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _isProcessing ? null : _handlePayment,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFF59E0B),
          disabledBackgroundColor: const Color(0xFFFBD38D),
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_isProcessing)
              const SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                ),
              )
            else
              const Icon(Icons.lock, size: 18, color: Colors.black),
            const SizedBox(width: 8),
            Text(
              _isProcessing ? 'Processing...' : 'Pay \$99.99 Securely',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
