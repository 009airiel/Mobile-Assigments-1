import 'package:flutter/material.dart';
import '../models/booking_data.dart';

class MenuSelectionScreen extends StatefulWidget {
  const MenuSelectionScreen({super.key});

  @override
  State<MenuSelectionScreen> createState() => _MenuSelectionScreenState();
}

class _MenuSelectionScreenState extends State<MenuSelectionScreen> {
  MenuPackage? _selectedPackage;
  bool _hasAdditionalMenu = false;

  void _showPackageDetails(BuildContext context, MenuPackage package) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(package.name, style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: 10),
              Text('Price per Guest: RM${package.pricePerGuest.toStringAsFixed(2)}'),
              const SizedBox(height: 10),
              Text(package.description),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _selectedPackage = package;
                    });
                    Navigator.pop(context);
                  },
                  child: const Text('Select This Package'),
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

    // Update the booking data with selection results
    booking.selectedPackage = _selectedPackage;
    booking.hasAdditionalMenu = _hasAdditionalMenu;

    // Navigate to Page 3
    Navigator.pushNamed(context, '/payment', arguments: booking);
  }

  @override
  Widget build(BuildContext context) {
    // Retrieve the BookingData passed from Page 1
    final booking = ModalRoute.of(context)!.settings.arguments as BookingData;

    return Scaffold(
      appBar: AppBar(title: const Text('2. Choose Your Package')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: mockPackages.length,
              itemBuilder: (context, index) {
                final package = mockPackages[index];
                final isSelected = package == _selectedPackage;

                return Card(
                  elevation: 4,
                  margin: const EdgeInsets.all(8),
                  color: isSelected ? Colors.deepPurple.shade50 : Colors.white,
                  child: ListTile(
                    leading: GestureDetector(
                      onTap: () => _showPackageDetails(context, package),
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(child: Text(package.imageUrl.split('/').last.split('.').first.toUpperCase())), // Mock Image Placeholder
                      ),
                    ),
                    title: Text(package.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('RM${package.pricePerGuest.toStringAsFixed(2)} per guest'),
                    trailing: isSelected
                        ? const Icon(Icons.check_circle, color: Colors.green)
                        : OutlinedButton(
                            onPressed: () => setState(() => _selectedPackage = package),
                            child: const Text('Select'),
                          ),
                    onTap: () => _showPackageDetails(context, package),
                  ),
                );
              },
            ),
          ),
          // --- Additional Menu Option ---
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Include Additional Menu (RM10/guest)', style: TextStyle(fontSize: 16)),
                Switch(
                  value: _hasAdditionalMenu,
                  onChanged: (bool value) {
                    setState(() {
                      _hasAdditionalMenu = value;
                    });
                  },
                ),
              ],
            ),
          ),
          // --- Navigation Button ---
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: ElevatedButton(
              onPressed: () => _navigateToPayment(booking),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              ),
              child: const Text('Continue to Payment', style: TextStyle(fontSize: 18)),
            ),
          ),
        ],
      ),
    );
  }
}