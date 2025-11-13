import 'package:flutter/material.dart';
import '../models/booking_data.dart';

class UserDetailsScreen extends StatefulWidget {
  const UserDetailsScreen({super.key});

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  final BookingData _booking = BookingData();
  final List<int> durationOptions = [3, 4, 5];

  // Helper function to pick time
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: _booking.startTime ?? TimeOfDay.now(),
    );
    if (pickedTime != null) {
      setState(() {
        _booking.startTime = pickedTime;
        _calculateEndTime(pickedTime, _booking.durationHours);
      });
    }
  }

  void _calculateEndTime(TimeOfDay startTime, int duration) {
    if (startTime == null) return;
    final now = DateTime.now();
    DateTime startDateTime =
        DateTime(now.year, now.month, now.day, startTime.hour, startTime.minute);
    DateTime endDateTime = startDateTime.add(Duration(hours: duration));
    _booking.endTime = TimeOfDay.fromDateTime(endDateTime);
  }

  void _submitDetails() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // Navigate to Page 2, passing the booking data
      Navigator.pushNamed(context, '/menu_selection', arguments: _booking);
    }
  }

  @override
  void initState() {
    super.initState();
    _booking.reservationDate = DateTime.now().add(const Duration(days: 7)); // Default a week later
    _booking.startTime = TimeOfDay.now();
    _calculateEndTime(_booking.startTime!, _booking.durationHours);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('1. Your Reservation Details')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // --- User Details ---
              const Text('Personal Contact', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Full Name'),
                validator: (value) => value!.isEmpty ? 'Name is required' : null,
                onSaved: (value) => _booking.name = value!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Address'),
                validator: (value) => value!.isEmpty ? 'Address is required' : null,
                onSaved: (value) => _booking.address = value!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Phone Number'),
                keyboardType: TextInputType.phone,
                validator: (value) => value!.length < 10 ? 'Enter a valid phone number' : null,
                onSaved: (value) => _booking.phoneNo = value!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) => !value!.contains('@') ? 'Enter a valid email' : null,
                onSaved: (value) => _booking.email = value!,
              ),
              
              const SizedBox(height: 25),
              // --- Reservation Details ---
              const Text('Reservation Details', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              
              // Guests
              TextFormField(
                decoration: const InputDecoration(labelText: 'Number of Guests (Min 10)'),
                keyboardType: TextInputType.number,
                initialValue: _booking.numberOfGuests.toString(),
                validator: (value) {
                  final guests = int.tryParse(value ?? '');
                  if (guests == null || guests < 10) {
                    return 'Minimum 10 guests required';
                  }
                  return null;
                },
                onSaved: (value) => _booking.numberOfGuests = int.parse(value!),
              ),

              // Date Picker
              ListTile(
                title: Text("Date: ${_booking.reservationDate != null ? _booking.reservationDate!.toLocal().toString().split(' ')[0] : 'Choose Date'}"),
                trailing: const Icon(Icons.calendar_today),
                onTap: () async {
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: _booking.reservationDate ?? DateTime.now().add(const Duration(days: 1)),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2028),
                  );
                  if (picked != null) {
                    setState(() {
                      _booking.reservationDate = picked;
                    });
                  }
                },
              ),

              // Time Picker
              ListTile(
                title: Text("Start Time: ${_booking.startTime?.format(context) ?? 'Choose Time'}"),
                trailing: const Icon(Icons.access_time),
                onTap: () => _selectTime(context),
              ),

              // Duration and End Time Display
              Row(
                children: [
                  const Text("Duration: "),
                  DropdownButton<int>(
                    value: _booking.durationHours,
                    items: durationOptions.map((int value) {
                      return DropdownMenuItem<int>(
                        value: value,
                        child: Text('$value hours'),
                      );
                    }).toList(),
                    onChanged: (int? newValue) {
                      setState(() {
                        _booking.durationHours = newValue!;
                        if (_booking.startTime != null) {
                          _calculateEndTime(_booking.startTime!, newValue);
                        }
                      });
                    },
                  ),
                  const Spacer(),
                  Text("End Time: ${_booking.endTime?.format(context) ?? '--'}"),
                ],
              ),
              
              // Additional Requests
              TextFormField(
                decoration: const InputDecoration(labelText: 'Additional Requests (e.g., Decoration, Birthday)'),
                onSaved: (value) => _booking.additionalRequests = value ?? '',
              ),

              const SizedBox(height: 30),
              // --- Submit Button ---
              Center(
                child: ElevatedButton(
                  onPressed: _submitDetails,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  ),
                  child: const Text('Continue to Menu', style: TextStyle(fontSize: 18)),
                ),
              ),
              
              const SizedBox(height: 20),
              // --- Display User Information (Partial requirement demo) ---
              const Text('--- User Information Display (for validation) ---', style: TextStyle(color: Colors.grey)),
              Text('Guests: ${_booking.numberOfGuests}'),
              Text('Date: ${_booking.reservationDate != null ? _booking.reservationDate!.toLocal().toString().split(' ')[0] : 'N/A'}'),
              Text('Duration: ${_booking.durationHours} hours'),
            ],
          ),
        ),
      ),
    );
  }//endoflines
}