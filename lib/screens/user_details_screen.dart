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
    final now = DateTime.now();
    DateTime startDateTime =
        DateTime(now.year, now.month, now.day, startTime.hour, startTime.minute);
    DateTime endDateTime = startDateTime.add(Duration(hours: duration));
    _booking.endTime = TimeOfDay.fromDateTime(endDateTime);
  }

  void _submitDetails() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // Navigate to Page 3, passing the booking data
      Navigator.pushNamed(context, '/menu_selection', arguments: _booking);
    }
  }

  @override
  void initState() {
    super.initState();
    _booking.reservationDate = DateTime.now().add(const Duration(days: 7));
    _booking.startTime = TimeOfDay.now();
    _calculateEndTime(_booking.startTime!, _booking.durationHours);
  }

  Widget _buildTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, bottom: 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('2. Reservation Details')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildTitle('Contact Information'),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Full Name'),
                validator: (value) => value!.isEmpty ? 'Name is required' : null,
                onSaved: (value) => _booking.name = value!,
              ),
              const SizedBox(height: 15),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Email Address'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) => !value!.contains('@') ? 'Enter a valid email' : null,
                onSaved: (value) => _booking.email = value!,
              ),
              const SizedBox(height: 15),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Phone Number'),
                keyboardType: TextInputType.phone,
                validator: (value) => value!.length < 10 ? 'Enter a valid phone number' : null,
                onSaved: (value) => _booking.phoneNo = value!,
              ),
              const SizedBox(height: 15),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Address'),
                validator: (value) => value!.isEmpty ? 'Address is required' : null,
                onSaved: (value) => _booking.address = value!,
              ),
              
              _buildTitle('Booking Requirements'),
              
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
              const SizedBox(height: 10),

              // Date Picker
              Card(
                elevation: 0,
                margin: EdgeInsets.zero,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  title: Text("Date: ${_booking.reservationDate != null ? _booking.reservationDate!.toLocal().toString().split(' ')[0] : 'Choose Date'}"),
                  trailing: Icon(Icons.date_range, color: Theme.of(context).hintColor),
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
              ),
              const SizedBox(height: 10),

              // Time Picker and Duration
              Row(
                children: [
                  Expanded(
                    child: Card(
                      elevation: 0,
                      margin: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                        title: Text("Start: ${_booking.startTime?.format(context) ?? 'Time'}"),
                        trailing: Icon(Icons.access_time, color: Theme.of(context).hintColor),
                        onTap: () => _selectTime(context),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: DropdownButton<int>(
                      value: _booking.durationHours,
                      icon: Icon(Icons.timer, color: Theme.of(context).hintColor),
                      underline: const SizedBox(),
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
                  ),
                ],
              ),
              const SizedBox(height: 10),
              
              // End Time Display
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  "Expected End Time: ${_booking.endTime?.format(context) ?? '--'} (Based on ${_booking.durationHours} hours)",
                  style: TextStyle(color: Colors.grey.shade700),
                ),
              ),

              // Additional Requests
              const SizedBox(height: 15),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Additional Requests (e.g., Decoration, Birthday)'),
                maxLines: 3,
                onSaved: (value) => _booking.additionalRequests = value ?? '',
              ),

              const SizedBox(height: 40),
              // --- Submit Button ---
              Center(
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _submitDetails,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      elevation: 5,
                    ),
                    child: const Text('Choose Menu Package', style: TextStyle(fontSize: 18)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}