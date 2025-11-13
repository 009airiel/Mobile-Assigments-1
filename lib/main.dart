import 'package:flutter/material.dart';
import 'screens/splash_screen.dart'; // Import the new splash screen
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
    return MaterialApp(
      title: 'Restaurant Package Booking',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.deepPurple,
          foregroundColor: Colors.white,
          centerTitle: true,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurple,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      
      // Setting the new Splash Screen as the starting page
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(), // New Page 1: Splash Screen
        '/user_details': (context) => const UserDetailsScreen(), // Page 2: User Details
        '/menu_selection': (context) => const MenuSelectionScreen(), // Page 3: Menu Selection
        '/payment': (context) => const PaymentAndDiscountScreen(), // Page 4: Payment
        '/confirmation': (context) => const ConfirmationAndReviewScreen(), // Page 5: Confirmation & Review
      },
    );
  }
}