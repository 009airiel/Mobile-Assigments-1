import 'package:flutter/material.dart';
import '../models/booking_data.dart'; // Import the model

class UserDetailsScreen extends StatefulWidget {
  const UserDetailsScreen({super.key});

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  // --- CONTROLLERS ---
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _guestsController = TextEditingController(
    text: "10",
  );
  final TextEditingController _specialRequestController =
      TextEditingController();

  final TextEditingController _dateController = TextEditingController(
    text: "2025-12-06",
  );
  final TextEditingController _timeController = TextEditingController(
    text: "11:21 PM",
  );
  final TextEditingController _endTimeController = TextEditingController(
    text: "02:21 AM",
  );

  // --- LOGIC: DATE & TIME PICKERS ---
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() {
        _dateController.text =
            "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        _timeController.text = picked.format(context);
        // Auto-Calculate End Time (+3 Hours)
        int startMinutes = picked.hour * 60 + picked.minute;
        int endMinutes = startMinutes + (3 * 60);
        if (endMinutes >= 1440) endMinutes -= 1440;
        int endHour = endMinutes ~/ 60;
        int endMinute = endMinutes % 60;
        final TimeOfDay endTime = TimeOfDay(hour: endHour, minute: endMinute);
        _endTimeController.text = endTime.format(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Reservation Details",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF2196F3), Color(0xFF0D47A1)],
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  const SizedBox(height: 10),

                  // Contact Info
                  _buildSectionCard(
                    title: "Contact Information",
                    icon: Icons.person_outline,
                    children: [
                      _buildTextField(
                        label: "Full Name",
                        icon: Icons.face,
                        controller: _nameController,
                      ),
                      const SizedBox(height: 15),
                      _buildTextField(
                        label: "Email Address",
                        icon: Icons.email_outlined,
                        inputType: TextInputType.emailAddress,
                        controller: _emailController,
                      ),
                      const SizedBox(height: 15),
                      _buildTextField(
                        label: "Phone Number",
                        icon: Icons.phone_outlined,
                        inputType: TextInputType.phone,
                        controller: _phoneController,
                      ),
                      const SizedBox(height: 15),
                      _buildTextField(
                        label: "Address",
                        icon: Icons.location_on_outlined,
                        controller: _addressController,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Booking Info
                  _buildSectionCard(
                    title: "Booking Requirements",
                    icon: Icons.calendar_today_outlined,
                    children: [
                      _buildTextField(
                        label: "Number of Guests (Min 10)",
                        icon: Icons.groups_outlined,
                        inputType: TextInputType.number,
                        controller: _guestsController,
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: _buildReadOnlyPicker(
                              label: "Date",
                              value: _dateController.text,
                              icon: Icons.event,
                              onTap: () => _selectDate(context),
                            ),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: _buildReadOnlyPicker(
                              label: "Start Time",
                              value: _timeController.text,
                              icon: Icons.access_time,
                              onTap: () => _selectTime(context),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: const Color(0xFF4FC3F7).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: const Color(0xFF4FC3F7).withOpacity(0.3),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Row(
                              children: [
                                Icon(
                                  Icons.timer_outlined,
                                  color: Colors.blueGrey,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  "Duration: 3 Hours",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Text(
                              "Ends: ${_endTimeController.text}",
                              style: const TextStyle(
                                color: Color(0xFF0D47A1),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Special Requests
                  _buildSectionCard(
                    title: "Special Requests",
                    icon: Icons.star_border,
                    children: [
                      TextFormField(
                        controller: _specialRequestController,
                        maxLines: 3,
                        decoration: InputDecoration(
                          labelText: "Additional Requests (e.g. Birthday)",
                          prefixIcon: const Icon(
                            Icons.edit_note,
                            color: Colors.blueGrey,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),

                  // --- SUBMIT BUTTON ---
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // 1. CREATE THE TICKET (BookingData)
                        BookingData myBooking = BookingData(
                          name: _nameController.text.isEmpty
                              ? "Guest"
                              : _nameController.text, // Default if empty
                          email: _emailController.text,
                          phone: _phoneController.text,
                          address: _addressController.text,
                          guests: _guestsController.text,
                          date: _dateController.text,
                          time: _timeController.text,
                          endTime: _endTimeController.text,
                          specialRequest: _specialRequestController.text,
                        );

                        // 2. SEND THE TICKET
                        // We use 'arguments' to pass the data to the next screen
                        Navigator.pushNamed(
                          context,
                          '/menu_selection',
                          arguments: myBooking,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFF6F00),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: const Text(
                        "Choose Menu Package",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- HELPER WIDGETS ---
  Widget _buildSectionCard({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: const Color(0xFF0D47A1)),
              const SizedBox(width: 10),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0D47A1),
                ),
              ),
            ],
          ),
          const Divider(height: 30),
          ...children,
        ],
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required IconData icon,
    required TextEditingController controller,
    TextInputType inputType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: inputType,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.blueGrey),
      ),
    );
  }

  Widget _buildReadOnlyPicker({
    required String label,
    required String value,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 16, color: const Color(0xFFFF6F00)),
                const SizedBox(width: 8),
                Text(
                  label,
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
