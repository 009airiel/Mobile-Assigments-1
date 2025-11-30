import 'package:flutter/material.dart';

// Import all your updated screens
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
    // --- THEME COLORS ---
    const Color oceanDark = Color(0xFF0D47A1);
    const Color accentOrange = Color(0xFFFF6F00);
    const Color oceanLight = Color(0xFFE3F2FD);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ocean Feast Booking',

      // ThemeData cannot be const
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: oceanDark,
        scaffoldBackgroundColor: Colors.white,

        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: oceanDark,
          secondary: accentOrange,
          surface: oceanLight,
        ),

        // 1. AppBar Theme
        appBarTheme: const AppBarTheme(
          backgroundColor: oceanDark,
          foregroundColor: Colors.white,
          centerTitle: true,
          elevation: 0,
        ),

        // 2. Button Theme
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: accentOrange,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            elevation: 4,
            textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        // 3. Input Fields
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.grey.shade50,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
            borderSide: BorderSide(color: oceanDark, width: 2),
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          prefixIconColor: Colors.blueGrey,
        ),

        // 4. Card Theme (fixed)
        // 4. Card Theme
cardTheme: CardThemeData(
  elevation: 4,
  shadowColor: Colors.black.withOpacity(0.2),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(15.0),
  ),
  color: Colors.white,
),

      ),

      // --- ROUTES ---
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/user_details': (context) => const UserDetailsScreen(),
        '/menu_selection': (context) => const MenuSelectionScreen(),
        '/payment_discount': (context) => const PaymentAndDiscountScreen(),
        '/confirmation_review': (context) => const ConfirmationReviewScreen(),
      },
    );
  }
}
