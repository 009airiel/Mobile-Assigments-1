import 'package:flutter/material.dart';
import '../models/booking_data.dart';

class ConfirmationAndReviewScreen extends StatefulWidget {
  const ConfirmationAndReviewScreen({super.key});

  @override
  State<ConfirmationAndReviewScreen> createState() => _ConfirmationAndReviewScreenState();
}

class _ConfirmationAndReviewScreenState extends State<ConfirmationAndReviewScreen> {
  final _reviewController = TextEditingController();
  double _userRating = 4.0; // Default rating
  
  // Mock Reviews Data
  final List<Map<String, dynamic>> mockReviews = [
    {'name': 'Ahmad', 'rating': 5.0, 'review': 'Fantastic service and excellent food package!'},
    {'name': 'Siti', 'rating': 4.0, 'review': 'The venue decoration was amazing, minor delay in serving.'},
    {'name': 'Raju', 'rating': 3.5, 'review': 'Good value for money, but the main course was cold.'},
  ];

  void _submitReview() {
    if (_reviewController.text.isNotEmpty) {
      // In a real app, this data would be sent to a server.
      setState(() {
        mockReviews.insert(0, {
          'name': 'You', // Placeholder for current user
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

  Widget _buildRatingStars(double rating) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return Icon(
          index < rating.floor() ? Icons.star : (index < rating ? Icons.star_half : Icons.star_border),
          color: Colors.amber,
          size: 20,
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Retrieve the final BookingData
    final booking = ModalRoute.of(context)!.settings.arguments as BookingData;

    return Scaffold(
      appBar: AppBar(title: const Text('4. Confirmation & Reviews')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // --- Confirmation Summary ---
            const Text('Booking Confirmation', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.green)),
            const Divider(),
            ListTile(title: const Text('Reservation for:'), subtitle: Text('${booking.name} (${booking.numberOfGuests} Guests)')),
            ListTile(title: const Text('Date & Time:'), subtitle: Text('${booking.reservationDate!.toLocal().toString().split(' ')[0]} at ${booking.startTime!.format(context)} (${booking.durationHours} hours)')),
            ListTile(title: const Text('Package Selected:'), subtitle: Text(booking.selectedPackage!.name)),
            ListTile(title: const Text('Final Payment:'), subtitle: Text('RM${booking.finalTotal.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.deepPurple))),
            ListTile(title: const Text('Additional Requests:'), subtitle: Text(booking.additionalRequests.isNotEmpty ? booking.additionalRequests : 'None')),

            const SizedBox(height: 30),
            // --- Ratings and Review Input ---
            const Text('Leave Your Review', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            
            // Rating Input
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Row(
                children: [
                  const Text('Your Rating: ', style: TextStyle(fontSize: 16)),
                  Slider(
                    value: _userRating,
                    min: 1,
                    max: 5,
                    divisions: 8, // Allows steps of 0.5
                    label: _userRating.toStringAsFixed(1),
                    onChanged: (double value) {
                      setState(() {
                        _userRating = value;
                      });
                    },
                  ),
                  _buildRatingStars(_userRating),
                ],
              ),
            ),
            
            // Review Input
            TextField(
              controller: _reviewController,
              decoration: InputDecoration(
                hintText: 'Share your experience...',
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _submitReview,
                ),
              ),
              maxLines: 3,
            ),
            
            const SizedBox(height: 30),
            // --- Display Reviews ---
            const Text('Customer Reviews', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            
            // List of Reviews
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: mockReviews.length,
              itemBuilder: (context, index) {
                final review = mockReviews[index];
                return ListTile(
                  title: Text(review['name']!),
                  subtitle: Text(review['review']!),
                  trailing: _buildRatingStars(review['rating']!),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}