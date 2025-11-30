import 'package:flutter/material.dart';
import '../models/booking_data.dart';

class ConfirmationReviewScreen extends StatefulWidget {
  const ConfirmationReviewScreen({super.key});

  @override
  State<ConfirmationReviewScreen> createState() => _ConfirmationReviewScreenState();
}

class _ConfirmationReviewScreenState extends State<ConfirmationReviewScreen> {
  // --- STATE FOR RATINGS & REVIEWS (Old Feature Preserved) ---
  final _reviewController = TextEditingController();
  double _userRating = 5.0; // Default rating
  
  // Mock Reviews Data
  final List<Map<String, dynamic>> mockReviews = [
    {'name': 'Ahmad (Gold)', 'rating': 5.0, 'review': 'Fantastic service and excellent food package!'},
    {'name': 'Siti (Silver)', 'rating': 4.0, 'review': 'The decoration was amazing, minor delay in serving.'},
    {'name': 'Raju (Platinum)', 'rating': 3.5, 'review': 'Good value for money, but the main course was cold.'},
  ];

  void _submitReview() {
    if (_reviewController.text.isNotEmpty) {
      setState(() {
        mockReviews.insert(0, {
          'name': 'You (Just Now)',
          'rating': _userRating,
          'review': _reviewController.text,
        });
      });
      _reviewController.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Thank you for your review!')),
      );
    }
  }

  Widget _buildRatingStars(double rating, {double size = 20}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return Icon(
          index < rating.floor() 
            ? Icons.star_rounded 
            : (index < rating ? Icons.star_half_rounded : Icons.star_border_rounded),
          color: const Color(0xFFFF6F00), // Updated to "Crab Orange" to match theme
          size: size,
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    // 1. RECEIVE DATA
    final BookingData? booking = ModalRoute.of(context)!.settings.arguments as BookingData?;

    // Safety Check
    if (booking == null) {
      return const Scaffold(body: Center(child: Text("Error: No Booking Data Found")));
    }

    // 2. CALCULATE TOTAL (Since it's not stored in the model anymore)
    int guestCount = int.tryParse(booking.guests) ?? 0;
    double pricePerHead = booking.selectedPackage?.pricePerGuest ?? 0;
    double calculatedTotal = guestCount * pricePerHead;
    // Add extra cost if side menu was selected
    if (booking.hasAdditionalMenu) {
      calculatedTotal += (guestCount * 15.0); // Assuming $15 for sides
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking Confirmed'),
        backgroundColor: const Color(0xFF0D47A1), // Ocean Dark
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // --- Confirmation Card ---
            Card(
              elevation: 6,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: Icon(Icons.check_circle, size: 60, color: Colors.green),
                    ),
                    const SizedBox(height: 15),
                    const Center(
                      child: Text('Booking Successful!', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF0D47A1))),
                    ),
                    const Divider(height: 30),
                    
                    // Displaying Data using the NEW Model names
                    _buildSummaryRow('Reserved For:', '${booking.name} ($guestCount Guests)'),
                    _buildSummaryRow('Date & Time:', '${booking.date} @ ${booking.time}'),
                    _buildSummaryRow('Package:', booking.selectedPackage?.name ?? "Unknown"),
                    _buildSummaryRow('Add-Ons:', booking.hasAdditionalMenu ? "Premium Sides (Included)" : "None"),
                    const Divider(),
                    _buildSummaryRow('Total Estimated:', '\$${calculatedTotal.toStringAsFixed(2)}', isBold: true),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 40),

            // --- Ratings and Review Input (OLD FEATURE KEPT) ---
            const Text('Share Your Love!', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF0D47A1))),
            const Text('Help us improve by leaving a rating and review.', style: TextStyle(color: Colors.grey)),
            
            // Rating Input Slider
            Padding(
              padding: const EdgeInsets.only(top: 15.0, bottom: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Rating: ${_userRating.toStringAsFixed(1)}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                  _buildRatingStars(_userRating, size: 28),
                ],
              ),
            ),
            
            Slider(
              value: _userRating,
              min: 1,
              max: 5,
              divisions: 8,
              label: _userRating.toStringAsFixed(1),
              activeColor: const Color(0xFFFF6F00), // Orange Slider
              onChanged: (double value) {
                setState(() {
                  _userRating = value;
                });
              },
            ),

            // Review Input
            TextField(
              controller: _reviewController,
              decoration: InputDecoration(
                hintText: 'Write your detailed review here...',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.send, color: Color(0xFFFF6F00)),
                  onPressed: _submitReview,
                ),
              ),
              maxLines: 3,
            ),
            
            const SizedBox(height: 40),
            
            // --- Display Reviews List (OLD FEATURE KEPT) ---
            const Text('What Others Say', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF0D47A1))),
            
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: mockReviews.length,
              itemBuilder: (context, index) {
                final review = mockReviews[index];
                return Card(
                  elevation: 2,
                  margin: const EdgeInsets.only(top: 10),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.blue.shade100,
                      child: Text(review['name'][0], style: const TextStyle(color: Color(0xFF0D47A1))),
                    ),
                    title: Text(review['name']!, style: const TextStyle(fontWeight: FontWeight.w600)),
                    subtitle: Text(review['review']!, style: TextStyle(color: Colors.grey.shade600)),
                    trailing: _buildRatingStars(review['rating']!, size: 16),
                  ),
                );
              },
            ),

            const SizedBox(height: 30),
            
            // Back Home Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                   Navigator.popUntil(context, ModalRoute.withName('/')); 
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0D47A1),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                child: const Text("Back to Home", style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: Colors.grey.shade700, fontSize: 16)),
          Text(
            value, 
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.w500, 
              fontSize: isBold ? 18 : 16,
              color: isBold ? const Color(0xFFFF6F00) : Colors.black87
            )
          ),
        ],
      ),
    );
  }
}