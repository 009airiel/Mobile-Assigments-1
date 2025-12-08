/*import 'package:flutter/material.dart';

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
    description:
        'Fresh crab, prawns, and mussels served on the table. Spicy Cajun sauce.',
    pricePerGuest: 45.00,
    // FIX: Menggunakan nama file yang benar untuk Captain's Shellout
    imageUrl: 'assets/silver.png',
  ),
  MenuPackage(
    id: 2,
    name: 'Deep Sea Hotpot',
    description:
        'Premium grouper slices, tiger prawns, and scallops with Tom Yam broth.',
    pricePerGuest: 75.00,
    imageUrl: 'assets/deep_sea_hotpot.png',
  ),
  MenuPackage(
    id: 3,
    name: 'Neptune\'s Royal ',
    description:
        'Unlimited lobster, Alaskan king crab legs, and oyster platter.',
    pricePerGuest: 120.00,
    imageUrl: 'assets/neptune_royal_feast.png',
  ),
];

// ---------------------------------------------------------------------------
// PART 2: The Booking Data (The "Ticket" passed between screens)
// ---------------------------------------------------------------------------
class BookingData {
  // User Details (Immutable data from Page 1)
  final String name;
  final String email;
  final String phone;
  final String address;
  final String guests;
  final String date;
  final String time;
  final String endTime;
  final String specialRequest;

  // Menu Selection (Mutable data for Page 2/3)
  // MenuPackage? selectedPackage;
  List<MenuPackage> selectedPackages = [];
  bool hasAdditionalMenu = false;

  // Payment Data (Mutable data for Page 3/4)
  double finalTotal = 0.0;
  String discountCode = '';
  double discountRate = 0.0;

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
*/

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
    description:
        'Fresh crab, prawns, and mussels served on the table. Spicy Cajun sauce.',
    pricePerGuest: 45.00,
    imageUrl: 'assets/silver.png',
  ),
  MenuPackage(
    id: 2,
    name: 'Deep Sea Hotpot',
    description:
        'Premium grouper slices, tiger prawns, and scallops with Tom Yam broth.',
    pricePerGuest: 75.00,
    imageUrl: 'assets/deep_sea_hotpot.png',
  ),
  MenuPackage(
    id: 3,
    name: 'Neptune\'s Royal',
    description:
        'Unlimited lobster, Alaskan king crab legs, and oyster platter.',
    pricePerGuest: 120.00,
    imageUrl: 'assets/neptune_royal_feast.png',
  ),
];

// ---------------------------------------------------------------------------
// PART 2: The Booking Data (The "Ticket" passed between screens)
// ---------------------------------------------------------------------------
class BookingData {
  // User Details (Immutable data from Page 1)
  final String name;
  final String email;
  final String phone;
  final String address;
  final String guests;
  final String date;
  final String time;
  final String endTime;
  final String specialRequest;

  // Menu Selection (Mutable data for Page 2/3)
  List<MenuPackage> selectedPackages = [];
  bool hasAdditionalMenu = false;

  // Payment Data (Mutable data for Page 3/4)
  double finalTotal = 0.0;
  String discountCode = '';
  double discountRate = 0.0;

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
    List<MenuPackage>? selectedPackages,
    this.hasAdditionalMenu = false,
  }) : selectedPackages = selectedPackages ?? [];
}
