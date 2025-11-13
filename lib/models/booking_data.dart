import 'package:flutter/material.dart';

// --- Menu Package Model ---
class MenuPackage {
  final int id;
  final String name;
  final String description;
  final double pricePerGuest;
  final String imageUrl;

  MenuPackage({
    required this.id,
    required this.name,
    required this.description,
    required this.pricePerGuest,
    required this.imageUrl,
  });
}

// Mock Data for Packages
List<MenuPackage> mockPackages = [
  MenuPackage(
      id: 1,
      name: 'Silver Gathering',
      description: 'Appetizers, 2 main courses, soft drinks. Elegant and classic.',
      pricePerGuest: 45.00,
      imageUrl: 'assets/silver.jpg'),
  MenuPackage(
      id: 2,
      name: 'Gold Feast',
      description: 'All-inclusive buffet, 3 main courses, deluxe dessert. Luxurious.',
      pricePerGuest: 75.00,
      imageUrl: 'assets/gold.jpg'),
  MenuPackage(
      id: 3,
      name: 'Platinum Experience',
      description: 'Premium dining, unlimited courses, and signature cocktails.',
      pricePerGuest: 120.00,
      imageUrl: 'assets/platinum.jpg'),
];

// --- Central Booking State Model (Passed between screens) ---
class BookingData {
  // Page 1: User Details
  String name = '';
  String address = '';
  String phoneNo = '';
  String email = '';
  DateTime? reservationDate;
  TimeOfDay? startTime;
  TimeOfDay? endTime;
  int durationHours = 3;
  String additionalRequests = '';
  int numberOfGuests = 10;

  // Page 2: Menu Selection
  MenuPackage? selectedPackage;
  bool hasAdditionalMenu = false; // Additional menu fixed rate

  // Page 3: Payment
  String discountCode = '';
  double discountRate = 0.0;
  double finalTotal = 0.0;
}