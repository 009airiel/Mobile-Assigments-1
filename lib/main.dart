import 'package:flutter/material.dart';
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
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const UserDetailsScreen(), // Page 1
        '/menu_selection': (context) => const MenuSelectionScreen(), // Page 2
        '/payment': (context) => const PaymentAndDiscountScreen(), // Page 3
        '/confirmation': (context) => const ConfirmationAndReviewScreen(), // Page 4
      },
    );
  }
}