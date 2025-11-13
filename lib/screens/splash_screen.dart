import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color accentColor = Color(0xFFF48FB1); // Soft Pink Accent
    
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // --- Logo/Icon Area (Minimalist Focus) ---
              Container(
                padding: const EdgeInsets.all(25),
                decoration: BoxDecoration(
                  color: accentColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Icon(
                  Icons.favorite_border, // Cute icon
                  size: 70,
                  color: accentColor,
                ),
              ),
              const SizedBox(height: 30),
              
              // --- Title ---
              Text(
                'Your Perfect Meal Awaits',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                  color: Theme.of(context).primaryColor,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              
              // --- Subtitle/Tagline ---
              Text(
                'Book your exclusive package and enjoy a seamless reservation experience.',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey.shade600,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 80),
              
              // --- Continue Button ---
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/user_details');
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    elevation: 5,
                  ),
                  child: const Text(
                    'Continue to Booking',
                    style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
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