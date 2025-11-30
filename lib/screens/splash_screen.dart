import 'package:flutter/material.dart';
// Make sure math is imported for rotation if needed, though I didn't use it here to keep it simple.
// import 'dart:math' as math; 


class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // --- THEME COLORS ---
    const Color accentOrange = Color(0xFFFF6F00);

    return Scaffold(
      body: Stack(
        children: [
          // ---------------------------------------------------------
          // LAYER 1: The Ocean Gradient
          // ---------------------------------------------------------
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFFE3F2FD), // Surface
                  Color(0xFF2196F3), // Mid
                  Color(0xFF0D47A1), // Deep
                ],
              ),
            ),
          ),

          // ---------------------------------------------------------
          // LAYER 2: BACKGROUND DECORATIONS (More Visible Now!)
          // ---------------------------------------------------------
          
          // --- BUBBLES (Scattered everywhere) ---
          Positioned(top: -50, left: -50, child: Icon(Icons.bubble_chart, size: 250, color: Colors.white.withOpacity(0.15))),
          Positioned(top: 100, right: -30, child: Icon(Icons.bubble_chart, size: 150, color: Colors.white.withOpacity(0.15))),
          Positioned(bottom: 50, left: 10, child: Icon(Icons.circle_outlined, size: 80, color: Colors.white.withOpacity(0.2))),
          Positioned(bottom: 200, left: 50, child: Icon(Icons.circle, size: 20, color: Colors.white.withOpacity(0.3))),
          Positioned(bottom: 220, left: 80, child: Icon(Icons.circle, size: 15, color: Colors.white.withOpacity(0.3))),
          Positioned(top: 300, right: 100, child: Icon(Icons.circle_outlined, size: 60, color: Colors.white.withOpacity(0.15))),
          Positioned(top: 50, left: 150, child: Icon(Icons.bubble_chart, size: 80, color: Colors.white.withOpacity(0.2))),

          // --- WAVES ---
          Positioned(bottom: -50, right: -50, child: Icon(Icons.waves, size: 300, color: Colors.white.withOpacity(0.15))),

          // --- FISH (Increased Opacity to 0.25 - 0.4 so they are visible) ---
          
          // 1. School of small fish (Top Left)
          Positioned(
            top: 120, left: 20,
            child: Icon(Icons.set_meal, size: 40, color: Colors.white.withOpacity(0.3)),
          ),
          Positioned(
            top: 140, left: 50,
            child: Icon(Icons.set_meal, size: 30, color: Colors.white.withOpacity(0.3)),
          ),
           Positioned(
            top: 110, left: 60,
            child: Icon(Icons.set_meal, size: 35, color: Colors.white.withOpacity(0.3)),
          ),

          // 2. Big Fish (Bottom Left)
          Positioned(
            bottom: 150, left: -20,
            child: Transform.rotate(
              angle: -0.2, // Tilted slightly up
              child: Icon(Icons.set_meal_rounded, size: 150, color: Colors.white.withOpacity(0.2)),
            ),
          ),

          // 3. Medium Fish (Middle Right)
          Positioned(
            top: 350, right: -20,
            child: Icon(Icons.set_meal_rounded, size: 100, color: Colors.white.withOpacity(0.25)),
          ),

          // 4. Tiny distant fish (Center)
          Positioned(
            top: 250, left: 100,
            child: Icon(Icons.set_meal, size: 20, color: Colors.white.withOpacity(0.4)),
          ),


          // ---------------------------------------------------------
          // LAYER 3: Main Content
          // ---------------------------------------------------------
          Center(
            child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // --- Logo Area ---
                  Container(
                    width: 180,
                    height: 180,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 25,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        'assets/logo.png',
                        fit: BoxFit.cover,
                        width: 180,
                        height: 180,
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),

                  // --- Title ---
                  const Text(
                    'Ocean Feast',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          offset: Offset(2, 2),
                          blurRadius: 10.0,
                          color: Colors.black45,
                        ),
                      ],
                      letterSpacing: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 15),

                  // --- Subtitle ---
                  Text(
                    'Premium Seafood Hotpot & Shellout.\nDive into flavor.',
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.5,
                      color: Colors.white.withOpacity(0.9),
                      fontWeight: FontWeight.w500,
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
                        backgroundColor: accentOrange,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        elevation: 10,
                        shadowColor: Colors.black.withOpacity(0.4),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Book a Table',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 10),
                          Icon(Icons.arrow_forward_rounded)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}