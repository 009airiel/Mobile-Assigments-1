import 'package:flutter/material.dart';
import '../models/booking_data.dart'; // Import the model

class MenuSelectionScreen extends StatefulWidget {
  const MenuSelectionScreen({super.key});

  @override
  State<MenuSelectionScreen> createState() => _MenuSelectionScreenState();
}

class _MenuSelectionScreenState extends State<MenuSelectionScreen> {
  // We store the selection locally first
  MenuPackage? _selectedPackage;
  bool _addSides = false; // This handles your 'hasAdditionalMenu' feature

  @override
  Widget build(BuildContext context) {
    // 1. Receive the Booking Data passed from the previous screen
    final BookingData? bookingData = ModalRoute.of(context)!.settings.arguments as BookingData?;

    // Safety check
    if (bookingData == null) return const Scaffold(body: Center(child: Text("Error: No Data")));

    return Scaffold(
      appBar: AppBar(
        title: const Text("Choose Your Feast"),
        backgroundColor: const Color(0xFF0D47A1), // Ocean Dark
        foregroundColor: Colors.white,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFE3F2FD), Color(0xFF64B5F6)],
          ),
        ),
        child: Column(
          children: [
            // --- SECTION 1: THE PACKAGES LIST ---
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: mockPackages.length,
                itemBuilder: (context, index) {
                  final package = mockPackages[index];
                  final isSelected = _selectedPackage?.id == package.id;

                  return Card(
                    margin: const EdgeInsets.only(bottom: 20),
                    elevation: isSelected ? 10 : 4,
                    // Highlight the border if selected
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                      side: isSelected 
                        ? const BorderSide(color: Color(0xFFFF6F00), width: 3) // Orange border
                        : BorderSide.none,
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(15),
                      onTap: () {
                        setState(() {
                          _selectedPackage = package;
                        });
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Header Image/Color
                          Container(
                            height: 100,
                            decoration: BoxDecoration(
                              color: isSelected ? const Color(0xFFFF6F00).withOpacity(0.8) : Colors.blueGrey.shade800,
                              borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                            ),
                            child: Center(
                              child: isSelected 
                                ? const Icon(Icons.check_circle, size: 50, color: Colors.white)
                                : Icon(Icons.restaurant_menu, size: 50, color: Colors.white.withOpacity(0.5)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      package.name,
                                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF0D47A1)),
                                    ),
                                    Text(
                                      "\$${package.pricePerGuest.toStringAsFixed(0)}/pax",
                                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFFFF6F00)),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  package.description,
                                  style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            // --- SECTION 2: ADDITIONAL OPTIONS (Your Old Feature) ---
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, -5))],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // The Switch for "Additional Menu"
                  SwitchListTile(
                    title: const Text("Add Premium Sides & Drinks?", style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF0D47A1))),
                    subtitle: const Text("Includes free-flow drinks and dessert bar (+\$15/pax)."),
                    value: _addSides,
                    activeColor: const Color(0xFFFF6F00),
                    onChanged: (bool value) {
                      setState(() {
                        _addSides = value;
                      });
                    },
                  ),
                  const Divider(),
                  const SizedBox(height: 10),

                  // --- SECTION 3: CONTINUE BUTTON ---
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _selectedPackage == null 
                        ? null // Disable button if nothing selected
                        : () {
                            // 1. Update the BookingData object
                            bookingData.selectedPackage = _selectedPackage;
                            bookingData.hasAdditionalMenu = _addSides;

                            // 2. Pass it to the next screen (Confirmation)
                            Navigator.pushNamed(
                              context, 
                              '/confirmation_review', 
                              arguments: bookingData
                            );
                          },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFF6F00),
                        disabledBackgroundColor: Colors.grey.shade400,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      ),
                      child: Text(
                        _selectedPackage == null ? "Select a Package" : "Review Booking",
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}