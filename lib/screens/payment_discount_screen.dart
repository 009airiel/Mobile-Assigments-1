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

    _baseCost = booking.selectedPackage!.pricePerGuest * booking.numberOfGuests;
    _additionalCost = booking.hasAdditionalMenu ? (10.00 * booking.numberOfGuests) : 0.0;
    _subtotal = _baseCost + _additionalCost;

    _discountAmount = _subtotal * _discountRate;
    _finalTotal = _subtotal - _discountAmount;

    setState(() {
      booking.finalTotal = _finalTotal;
      booking.discountCode = _discountController.text;
      booking.discountRate = _discountRate;
    });
  }

  void _applyDiscount(String code) {
    if (code.toUpperCase() == 'FLUTTER20') {
      setState(() {
        _discountRate = 0.20; // 20% off
        _discountMessage = "Discount 'FLUTTER20' (20%) Applied!";
      });
    } else {
      setState(() {
        _discountRate = 0.0;
        _discountMessage = "Invalid code. Try 'FLUTTER20'.";
      });
    }
    _calculateTotal();
  }

  void _navigateToConfirmation(BookingData booking) {
    Navigator.pushNamed(context, '/confirmation', arguments: booking);
  }

  Widget _buildBreakdownRow(String title, double amount, {bool isDiscount = false, bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title, 
            style: TextStyle(
              fontSize: isTotal ? 20 : 16, 
              fontWeight: isTotal ? FontWeight.bold : FontWeight.w500,
              color: isDiscount ? Theme.of(context).hintColor : (isTotal ? Theme.of(context).primaryColor : Colors.grey.shade700)
            )
          ),
          Text(
            'RM${amount.toStringAsFixed(2)}', 
            style: TextStyle(
              fontSize: isTotal ? 20 : 16, 
              fontWeight: isTotal ? FontWeight.bold : FontWeight.w600, 
              color: isDiscount ? Theme.of(context).hintColor : (isTotal ? Theme.of(context).primaryColor : Colors.black87)
            )
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final booking = ModalRoute.of(context)!.settings.arguments as BookingData;

    return Scaffold(
      appBar: AppBar(title: const Text('4. Final Payment')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // --- Discount Code Input ---
            const Text('Apply Coupon', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _discountController,
                    decoration: const InputDecoration(
                      hintText: 'e.g., FLUTTER20',
                      isDense: true,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () => _applyDiscount(_discountController.text),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                  child: const Text('Apply'),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(_discountMessage, style: TextStyle(color: _discountRate > 0 ? Colors.green.shade600 : Colors.red.shade400, fontStyle: FontStyle.italic)),
            ),

            const SizedBox(height: 30),
            // --- Payment Breakdown Card (Minimalist Receipt Look) ---
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
                side: BorderSide(color: Colors.grey.shade300, width: 1),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    _buildBreakdownRow('Package (${booking.selectedPackage!.name})', _baseCost),
                    _buildBreakdownRow('Service Fee (Additional Menu)', _additionalCost),
                    const Divider(height: 25),
                    _buildBreakdownRow('Subtotal', _subtotal),
                    
                    // Discount Row
                    if (_discountRate > 0)
                      _buildBreakdownRow('Coupon Savings', -_discountAmount, isDiscount: true)
                    else 
                      _buildBreakdownRow('Coupon Savings', 0.00),

                    const Divider(height: 30, thickness: 1.5),
                    _buildBreakdownRow('TOTAL PAYMENT DUE', _finalTotal, isTotal: true),
                  ],
                ),
              ),
            ),
            
            const Spacer(),
            // --- Navigation Button ---
            Center(
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => _navigateToConfirmation(booking),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    elevation: 5,
                    backgroundColor: Theme.of(context).hintColor,
                  ),
                  child: const Text('Confirm & Pay Now', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}