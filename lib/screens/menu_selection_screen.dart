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
                style: const TextStyle(fontSize: 18, color: Colors.green),
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
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  ),
                  child: const Text('Select This Package', style: TextStyle(fontSize: 16)),
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

    booking.selectedPackage = _selectedPackage;
    booking.hasAdditionalMenu = _hasAdditionalMenu;
    Navigator.pushNamed(context, '/payment', arguments: booking);
  }

  @override
  Widget build(BuildContext context) {
    final booking = ModalRoute.of(context)!.settings.arguments as BookingData;
    const Color accentColor = Color(0xFFF48FB1); // Soft Pink Accent

    return Scaffold(
      appBar: AppBar(title: const Text('3. Choose Your Package')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: mockPackages.length,
              itemBuilder: (context, index) {
                final package = mockPackages[index];
                final isSelected = package == _selectedPackage;

                return GestureDetector(
                  onTap: () => _showPackageDetails(context, package),
                  child: Card(
                    elevation: isSelected ? 8 : 2, // Highlight selected card
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      side: isSelected ? BorderSide(color: accentColor, width: 3) : BorderSide.none,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: ListTile(
                        leading: Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: isSelected ? accentColor.withOpacity(0.4) : Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.dinner_dining,
                              color: isSelected ? Colors.white : Colors.grey.shade700,
                            ),
                          ),
                        ),
                        title: Text(
                          package.name,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          'RM${package.pricePerGuest.toStringAsFixed(2)} per guest\n${package.description.split('.').first}.',
                          maxLines: 2,
                        ),
                        trailing: isSelected
                            ? Icon(Icons.check_circle_rounded, color: accentColor, size: 30)
                            : TextButton(
                                onPressed: () => setState(() => _selectedPackage = package),
                                child: const Text('View/Select'),
                              ),
                        isThreeLine: true,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          // --- Additional Menu Option ---
          Card(
            margin: const EdgeInsets.all(16.0),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Include Additional Menu (RM10/guest)', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                  Switch(
                    value: _hasAdditionalMenu,
                    activeColor: accentColor,
                    onChanged: (bool value) {
                      setState(() {
                        _hasAdditionalMenu = value;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          // --- Navigation Button ---
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0, left: 20, right: 20),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => _navigateToPayment(booking),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  elevation: 5,
                ),
                child: const Text('Continue to Payment', style: TextStyle(fontSize: 18)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}