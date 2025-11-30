import 'package:flutter/material.dart';
import '../models/booking_data.dart'; // Import the model

class MenuSelectionScreen extends StatefulWidget {
  const MenuSelectionScreen({super.key});

  @override
  State<MenuSelectionScreen> createState() => _MenuSelectionScreenState();
}

class _MenuSelectionScreenState extends State<MenuSelectionScreen> {
  MenuPackage? _selectedPackage;
  bool _addSides = false; 

  // --- HELPER FUNCTION: Show Package Details (Modal) ---
  void _showPackageDetails(BuildContext context, MenuPackage package) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: Container(
                  width: 50,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                package.name,
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
              ),
              const SizedBox(height: 10),
              Text(
                'RM${package.pricePerGuest.toStringAsFixed(2)} per guest',
                style: TextStyle(fontSize: 18, color: Theme.of(context).colorScheme.secondary),
              ),
              const SizedBox(height: 15),
              Text(package.description, style: TextStyle(color: Colors.grey.shade700)),
              const SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _selectedPackage = package;
                    });
                    Navigator.pop(context);
                  },
                  // Use primary color for selection button
                  style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).primaryColor),
                  child: const Text('Select This Package', style: TextStyle(fontSize: 16, color: Colors.white)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _navigateToPayment(BookingData booking) {
    if (_selectedPackage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a package menu first.')),
      );
      return;
    }

    // 1. Update the BookingData object
    booking.selectedPackage = _selectedPackage;
    booking.hasAdditionalMenu = _addSides;
    
    // 2. Navigate to Payment Screen (Correct Route)
    Navigator.pushNamed(context, '/payment_discount', arguments: booking); 
  }

  // --- HELPER WIDGET FOR IMAGE LOADING (Handling errors) ---
  Widget _buildAssetImage(String assetPath, {required double height, required double width, required Color fallbackColor}) {
    return Image.asset(
      assetPath,
      fit: BoxFit.cover,
      height: height,
      width: width,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          height: height,
          width: width,
          color: fallbackColor,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Asset Not Found:\n${assetPath.split('/').last}\n(Check pubspec.yaml)',
                textAlign: TextAlign.center,
                style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 10),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final BookingData? bookingData = ModalRoute.of(context)!.settings.arguments as BookingData?;
    final Color accentOrange = Theme.of(context).colorScheme.secondary;
    final Color oceanDark = Theme.of(context).primaryColor;

    if (bookingData == null) return const Scaffold(body: Center(child: Text("Error: No Data")));

    return Scaffold(
      appBar: AppBar(
        title: const Text("3. Choose Your Feast"), // Updated step number
        backgroundColor: oceanDark,
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
            // --- SECTION 1: THE PACKAGES GRID VIEW (CATALOG LAYOUT) ---
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0, bottom: 8.0), // Added top padding where image used to be
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, 
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.75, 
                  ),
                  itemCount: mockPackages.length,
                  itemBuilder: (context, index) {
                    final package = mockPackages[index];
                    final isSelected = _selectedPackage?.id == package.id;
                    
                    return Card(
                      elevation: isSelected ? 10 : 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        side: isSelected 
                          ? BorderSide(color: accentOrange, width: 3) 
                          : BorderSide.none,
                      ),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(15),
                        onTap: () {
                          setState(() {
                            _selectedPackage = package;
                          });
                          _showPackageDetails(context, package); 
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // 1. Image / Header
                            ClipRRect(
                              borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                              child: _buildAssetImage(
                                package.imageUrl, // Uses dynamic path from model
                                height: 120,
                                width: double.infinity,
                                fallbackColor: oceanDark.withOpacity(0.1),
                              ),
                            ),
                            
                            // 2. Text Content
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    package.name,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: oceanDark),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    "RM${package.pricePerGuest.toStringAsFixed(0)}/pax", // Changed to RM
                                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: accentOrange),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    package.description,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(fontSize: 11, color: Colors.grey.shade700), // <-- FONT SIZE REDUCED HERE
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
            ),

            // --- SECTION 2: ADDITIONAL OPTIONS (Footer) ---
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
                    subtitle: const Text("Includes free-flow drinks and dessert bar (+RM15/pax)."), // Changed to RM
                    value: _addSides,
                    activeColor: accentOrange,
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
                        ? null 
                        : () => _navigateToPayment(bookingData!), 
                      child: Text(
                        _selectedPackage == null ? "Select a Package" : "Continue to Payment (RM)",
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