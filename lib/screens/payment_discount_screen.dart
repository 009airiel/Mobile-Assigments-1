import 'package:flutter/material.dart';
import '../models/booking_data.dart';

class PaymentAndDiscountScreen extends StatefulWidget {
  const PaymentAndDiscountScreen({super.key});

  @override
  State<PaymentAndDiscountScreen> createState() => _PaymentAndDiscountScreenState();
}

class _PaymentAndDiscountScreenState extends State<PaymentAndDiscountScreen> {
  // --- STATE ---
  final _discountController = TextEditingController();
  double _baseCost = 0.0;
  double _additionalCost = 0.0;
  double _subtotal = 0.0;
  double _discountAmount = 0.0;
  double _finalTotal = 0.0;
  double _discountRate = 0.0;
  String _discountMessage = "Enter code to apply discount";

  // --- THEME COLORS ---
  final Color oceanDark = const Color(0xFF0D47A1);
  final Color accentOrange = const Color(0xFFFF6F00);

  @override
  void initState() {
    super.initState();
    // Calculate totals as soon as the screen loads
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
    final booking = ModalRoute.of(context)!.settings.arguments as BookingData?;
    
    // Safety check if data is missing
    if (booking == null || booking.selectedPackage == null) return;

    // 1. Convert "Guests" String to Integer safely
    int guestCount = int.tryParse(booking.guests) ?? 0;

    // 2. Calculate Costs
    _baseCost = booking.selectedPackage!.pricePerGuest * guestCount;
    
    // Assuming sides cost $15 per head (matching your previous screen logic)
    _additionalCost = booking.hasAdditionalMenu ? (15.00 * guestCount) : 0.0;
    
    _subtotal = _baseCost + _additionalCost;
    _discountAmount = _subtotal * _discountRate;
    _finalTotal = _subtotal - _discountAmount;

    // Update the UI
    setState(() {});
  }

  void _applyDiscount(String code) {
    if (code.toUpperCase() == 'FLUTTER20') {
      setState(() {
        _discountRate = 0.20; // 20% off
        _discountMessage = "Success! 20% discount applied.";
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
    // Navigate to the Success/Review Page
    // Note: Since we calculated the final price here locally, the next screen 
    // might recalculate it without the discount unless we pass it.
    // For now, we just pass the booking data forward.
    Navigator.pushNamed(context, '/confirmation_review', arguments: booking);
  }

  // --- HELPER WIDGETS ---
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
              color: isDiscount ? Colors.green : (isTotal ? oceanDark : Colors.grey.shade700)
            )
          ),
          Text(
            // Format currency (negative sign for discounts)
            '${isDiscount ? "-" : ""}RM${amount.abs().toStringAsFixed(2)}', 
            style: TextStyle(
              fontSize: isTotal ? 20 : 16, 
              fontWeight: isTotal ? FontWeight.bold : FontWeight.w600, 
              color: isDiscount ? Colors.green : (isTotal ? accentOrange : Colors.black87)
            )
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final booking = ModalRoute.of(context)!.settings.arguments as BookingData?;

    if (booking == null) return const Scaffold(body: Center(child: Text("Error: No Data")));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Final Payment'),
        backgroundColor: oceanDark,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView( // Added scroll view to prevent overflow
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
                    decoration: InputDecoration(
                      hintText: 'e.g., FLUTTER20',
                      isDense: true,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () => _applyDiscount(_discountController.text),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: oceanDark,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: const Text('Apply'),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                _discountMessage, 
                style: TextStyle(
                  color: _discountRate > 0 ? Colors.green.shade700 : Colors.red.shade400, 
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w500
                )
              ),
            ),

            const SizedBox(height: 30),

            // --- Payment Breakdown Card ---
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
                side: BorderSide(color: Colors.grey.shade200, width: 1),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    _buildBreakdownRow('Package (${booking.selectedPackage?.name ?? "Selected"})', _baseCost),
                    _buildBreakdownRow('Add-Ons (Sides/Drinks)', _additionalCost),
                    const Divider(height: 25),
                    _buildBreakdownRow('Subtotal', _subtotal),
                    
                    // Discount Row
                    if (_discountRate > 0)
                      _buildBreakdownRow('Coupon Savings (20%)', _discountAmount, isDiscount: true),

                    const Divider(height: 30, thickness: 1.5),
                    _buildBreakdownRow('TOTAL PAYMENT DUE', _finalTotal, isTotal: true),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 40),

            // --- Confirm Button ---
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => _navigateToConfirmation(booking),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  elevation: 8,
                  backgroundColor: accentOrange, // Use the "Crab Orange"
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                ),
                child: const Text('Confirm & Pay Now', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}