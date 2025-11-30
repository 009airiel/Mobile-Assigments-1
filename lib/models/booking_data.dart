import 'package:flutter/material.dart';
// ---------------------------------------------------------------------------
// PART 1: The Menu Packages (Data for the Screen you are about to build)
// ---------------------------------------------------------------------------
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

// These are your "Seafood" themed packages
List<MenuPackage> mockPackages = [
  MenuPackage(
    id: 1,
    name: 'Captain\'s Shellout',
    description: 'Fresh crab, prawns, and mussels served on the table. Spicy Cajun sauce.',
    pricePerGuest: 45.00,
    imageUrl: 'assets/shellout.jpg', // Placeholder
  ),
  MenuPackage(
    id: 2,
    name: 'Deep Sea Hotpot',
    description: 'Premium grouper slices, tiger prawns, and scallops with Tom Yam broth.',
    pricePerGuest: 75.00,
    imageUrl: 'assets/hotpot.jpg', // Placeholder
  ),
  MenuPackage(
    id: 3,
    name: 'Neptune\'s Royal Feast',
    description: 'Unlimited lobster, Alaskan king crab legs, and oyster platter.',
    pricePerGuest: 120.00,
    imageUrl: 'assets/royal.jpg', // Placeholder
  ),
];

// ---------------------------------------------------------------------------
// PART 2: The Booking Data (The "Ticket" passed between screens)
// ---------------------------------------------------------------------------
class BookingData {
  // User Details (From Page 1)
  final String name;
  final String email;
  final String phone;
  final String address;
  final String guests;
  final String date;
  final String time;
  final String endTime;
  final String specialRequest;

  // Menu Selection (For Page 2)
  MenuPackage? selectedPackage; 
  bool hasAdditionalMenu = false;

  BookingData({
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.guests,
    required this.date,
    required this.time,
    required this.endTime,
    required this.specialRequest,
    this.selectedPackage,
    this.hasAdditionalMenu = false,
  });
}
