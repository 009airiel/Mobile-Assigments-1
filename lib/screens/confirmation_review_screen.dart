import 'package:flutter/material.dart';
import '../models/booking_data.dart';

class ConfirmationAndReviewScreen extends StatefulWidget {
  const ConfirmationAndReviewScreen({super.key});

  @override
  State<ConfirmationAndReviewScreen> createState() => _ConfirmationAndReviewScreenState();
}

class _ConfirmationAndReviewScreenState extends State<ConfirmationAndReviewScreen> {
  final _reviewController = TextEditingController();
  double _userRating = 4.5; // Default rating
  
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
          'name': 'You (New)',
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
          color: const Color(0xFFF48FB1), // Soft Pink Accent
          size: size,
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    final booking = ModalRoute.of(context)!.settings.arguments as BookingData;

    return Scaffold(
      appBar: AppBar(title: const Text('5. Booking Confirmed')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // --- Confirmation Card ---
            Card(
              elevation: 6,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Icon(Icons.check_circle_outline, size: 60, color: Theme.of(context).primaryColor),
                    ),
                    const SizedBox(height: 15),
                    const Center(
                      child: Text('Booking Successful!', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                    ),
                    const Divider(height: 30),
                    _buildSummaryRow(context, 'Reserved For:', '${booking.name} (${booking.numberOfGuests} Guests)'),
                    _buildSummaryRow(context, 'Date & Time:', '${booking.reservationDate!.toLocal().toString().split(' ')[0]} @ ${booking.startTime!.format(context)}'),
                    _buildSummaryRow(context, 'Package:', booking.selectedPackage!.name),
                    _buildSummaryRow(context, 'Total Paid:', 'RM${booking.finalTotal.toStringAsFixed(2)}'),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 40),
            // --- Ratings and Review Input ---
            const Text('Share Your Love!', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87)),
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
              activeColor: Theme.of(context).hintColor,
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
                suffixIcon: IconButton(
                  icon: const Icon(Icons.send, color: Color(0xFFF48FB1)),
                  onPressed: _submitReview,
                ),
              ),
              maxLines: 3,
            ),
            
            const SizedBox(height: 40),
            // --- Display Reviews ---
            const Text('What Others Say', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: mockReviews.length,
              itemBuilder: (context, index) {
                final review = mockReviews[index];
                return Card(
                  elevation: 1,
                  margin: const EdgeInsets.only(top: 10),
                  child: ListTile(
                    title: Text(review['name']!, style: const TextStyle(fontWeight: FontWeight.w600)),
                    subtitle: Text(review['review']!, style: TextStyle(color: Colors.grey.shade600)),
                    trailing: _buildRatingStars(review['rating']!),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: Colors.grey.shade600)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}