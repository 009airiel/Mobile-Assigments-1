import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/user_details_screen.dart';
import 'screens/menu_selection_screen.dart';
import 'screens/payment_discount_screen.dart';
import 'screens/confirmation_review_screen.dart';

void main() {
  runApp(const RestaurantBookingApp());
}

class RestaurantBookingApp extends StatelessWidget {
  const RestaurantBookingApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Define a soft, cute color palette
    const Color primarySoftColor = Color(0xFF81D4FA); // Soft Blue
    const Color accentColor = Color(0xFFF48FB1); // Soft Pink Accent

    return MaterialApp(
      title: 'Restaurant Package Booking',
      theme: ThemeData(
        // Using a soft color for the primary theme
        primarySwatch: Colors.lightBlue,
        primaryColor: primarySoftColor,
        hintColor: accentColor,
        scaffoldBackgroundColor: const Color(0xFFF7F9FC), // Very light grey/white background
        
        appBarTheme: const AppBarTheme(
          backgroundColor: primarySoftColor,
          foregroundColor: Colors.white,
          centerTitle: true,
          elevation: 0, // Minimalist: no shadows
        ),
        
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: primarySoftColor,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0), // Cute: Highly rounded buttons
            ),
            elevation: 2,
          ),
        ),
        
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0), // Rounded inputs
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(color: accentColor, width: 2),
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
        ),
        
        // --- CORRECTED CARD THEME PLACEMENT (Added 'const' for cleanliness) ---
        cardTheme: const CardTheme( 
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0), // Rounded cards
          ),
        ),
        // -------------------------------------
        
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/user_details': (context) => const UserDetailsScreen(),
        '/menu_selection': (context) => const MenuSelectionScreen(),
        '/payment': (context) => const PaymentAndDiscountScreen(),
        '/confirmation': (context) => const ConfirmationAndReviewScreen(),
      },
    );
  }
}