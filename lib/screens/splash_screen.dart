import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // --- Logo/Icon Area ---
              const Icon(
                Icons.restaurant_menu,
                size: 100,
                color: Colors.deepPurple,
              ),
              const SizedBox(height: 20),
              
              // --- Title ---
              Text(
                'Welcome to Package Booking',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple.shade800,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              
              // --- Subtitle/Tagline ---
              Text(
                'Reserve your perfect dining experience now.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade600,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 60),
              
              // --- Continue Button (New Page 1) ---
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Navigate to the User Details Screen (now the new Page 2)
                    Navigator.pushNamed(context, '/user_details');
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    backgroundColor: Colors.deepPurple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Continue to Booking',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}