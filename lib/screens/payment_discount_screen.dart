import 'package:flutter/material.dart';
import '../models/booking_data.dart';

class PaymentAndDiscountScreen extends StatefulWidget {
  const PaymentAndDiscountScreen({super.key});

  @override
  State<PaymentAndDiscountScreen> createState() => _PaymentAndDiscountScreenState();
}

class _PaymentAndDiscountScreenState extends State<PaymentAndDiscountScreen> {
  final _discountController = TextEditingController();
  double _baseCost = 0.0;
  double _additionalCost = 0.0;
  double _subtotal = 0.0;
  double _discountAmount = 0.0;
  double _finalTotal = 0.0;
  double _discountRate = 0.0;
  String _discountMessage = "Enter code to apply discount";

  @override
  void initState() {
    super.initState();
    // Calculations will run after the context is fully built and arguments are available
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _calculateTotal();
    });
  }

  @override
  void dispose() {
    _discountController.dispose();
    super.dispose();
  }

  void _calculateTotal() {
    final booking = ModalRoute.of(context)!.settings.arguments as BookingData;
    if (booking.selectedPackage == null) return;

    // 1. Calculate Base Cost
    _baseCost = booking.selectedPackage!.pricePerGuest * booking.numberOfGuests;

    // 2. Calculate Additional Cost (RM10/guest)
    _additionalCost = booking.hasAdditionalMenu ? (10.00 * booking.numberOfGuests) : 0.0;

    // 3. Subtotal
    _subtotal = _baseCost + _additionalCost;

    // 4. Discount Application
    _discountAmount = _subtotal * _discountRate;

    // 5. Final Total
    _finalTotal = _subtotal - _discountAmount;

    // Update state and booking data
    setState(() {
      booking.finalTotal = _finalTotal;
      booking.discountCode = _discountController.text;
      booking.discountRate = _discountRate;
    });
  }

  void _applyDiscount(String code) {
    // Mock Discount Logic
    if (code.toUpperCase() == 'FLUTTER20') {
      setState(() {
        _discountRate = 0.20; // 20% off
        _discountMessage = "Discount 'FLUTTER20' (20%) Applied!";
      });
    } else {
      setState(() {
        _discountRate = 0.0;
        _discountMessage = "Invalid or expired discount code.";
      });
    }
    _calculateTotal();
  }

  void _navigateToConfirmation(BookingData booking) {
    // Navigate to Page 4
    Navigator.pushNamed(context, '/confirmation', arguments: booking);
  }

  Widget _buildBreakdownRow(String title, double amount, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(fontSize: isTotal ? 20 : 16, fontWeight: isTotal ? FontWeight.bold : FontWeight.normal)),
          Text('RM${amount.toStringAsFixed(2)}', style: TextStyle(fontSize: isTotal ? 20 : 16, fontWeight: isTotal ? FontWeight.bold : FontWeight.normal, color: isTotal ? Colors.deepPurple : null)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final booking = ModalRoute.of(context)!.settings.arguments as BookingData;

    return Scaffold(
      appBar: AppBar(title: const Text('3. Payment & Discount')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // --- Discount Code Input ---
            const Text('Discount Code', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _discountController,
                    decoration: const InputDecoration(hintText: 'Enter discount code'),
                  ),
                ),
                ElevatedButton(
                  onPressed: () => _applyDiscount(_discountController.text),
                  child: const Text('Apply'),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(_discountMessage, style: TextStyle(color: _discountRate > 0 ? Colors.green : Colors.red, fontStyle: FontStyle.italic)),
            ),

            const SizedBox(height: 30),
            // --- Payment Breakdown ---
            const Text('Payment Summary', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            
            _buildBreakdownRow('Package Base Cost', _baseCost),
            _buildBreakdownRow('Additional Menu (${booking.numberOfGuests} guests x RM10)', _additionalCost),
            const Divider(),
            _buildBreakdownRow('Subtotal', _subtotal, isTotal: true),
            
            const Divider(height: 20, thickness: 2),
            _buildBreakdownRow('Discount Applied (${(_discountRate * 100).toInt()}%)', -_discountAmount, isTotal: true),
            
            const Divider(height: 20, thickness: 2, color: Colors.deepPurple),
            _buildBreakdownRow('TOTAL PAYMENT DUE', _finalTotal, isTotal: true),
            
            const Spacer(),
            // --- Navigation Button ---
            Center(
              child: ElevatedButton(
                onPressed: () => _navigateToConfirmation(booking),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  backgroundColor: Colors.deepPurple,
                ),
                child: const Text('Confirm Booking', style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}