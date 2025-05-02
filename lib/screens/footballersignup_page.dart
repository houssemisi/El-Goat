import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'success_page.dart';

class FootballerSignUpPage extends StatefulWidget {
  final String userId;
  const FootballerSignUpPage({
    Key? key,
    required this.userId,
  }) : super(key: key);

  @override
  State<FootballerSignUpPage> createState() => _FootballerSignupPageState();
}


class _FootballerSignupPageState extends State<FootballerSignUpPage> {
  final _formKey = GlobalKey<FormState>();

  // Form fields
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _clubController = TextEditingController();

  String? position;
  String? foot;
  String? experience;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _dobController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    _clubController.dispose();
    super.dispose();
  }

  Future<void> _saveFootballerData() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        await _firestore.collection('footballers').doc(user.uid).set({
            'fullName': _fullNameController.text,
            'uid_fsc': user.uid,
          'email': _emailController.text,
          'phone': _phoneController.text,
          'dob': _dobController.text,
          'position': position ?? '',
          'foot': foot ?? '',
          'height': _heightController.text,
          'weight': _weightController.text,
          'experience': experience ?? '',
          'club': _clubController.text.isEmpty ? "None" : _clubController.text,
          'createdAt': FieldValue.serverTimestamp(),
        });
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SuccessPage()),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving data: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E), // Soft black background
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Create Profile'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF2C2C2C), // Dark grey form container
                borderRadius: BorderRadius.circular(16),
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: Text(
                        'Sign Up as Footballer',
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Full Name
                    buildLabel('Full Name'),
                    buildTextField('Enter your full name', _fullNameController),

                    // Email
                    buildLabel('Email Address'),
                    buildTextField('Enter your email', _emailController),

                    // Phone Number
                    buildLabel('Phone Number'),
                    buildTextField('Enter your phone number', _phoneController),

                    // Date of Birth
                    buildLabel('Date of Birth'),
                    buildTextField('DD/MM/YYYY', _dobController,
                        icon: Icons.calendar_today),

                    // Position Dropdown
                    buildLabel('Position'),
                    buildDropdown(
                        ['Goalkeeper', 'Defender', 'Midfielder', 'Striker'],
                        (val) => setState(() => position = val),
                        position),

                    // Preferred Foot
                    buildLabel('Preferred Foot'),
                    buildDropdown(['Left', 'Right', 'Both'],
                        (val) => setState(() => foot = val), foot),

                    // Height & Weight
                    buildLabel('Height (cm)'),
                    buildTextField('Enter height', _heightController),
                    buildLabel('Weight (kg)'),
                    buildTextField('Enter weight', _weightController),

                    // Experience
                    buildLabel('Experience Level'),
                    buildDropdown(['Beginner', 'Semi-Pro', 'Professional'],
                        (val) => setState(() => experience = val), experience),

                    // Club (Optional)
                    buildLabel('Current Club (Optional)'),
                    buildTextField('Enter club name', _clubController),

                    const SizedBox(height: 30),

                    // Submit Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _saveFootballerData(); // Save data to Firestore
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 4),
      child: Text(
        text,
        style: TextStyle(color: Colors.grey[300], fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget buildTextField(String hint, TextEditingController controller,
      {IconData? icon}) {
    return TextFormField(
      controller: controller,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey[800],
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey),
        prefixIcon: icon != null ? Icon(icon, color: Colors.grey) : null,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none),
      ),
      validator: (value) =>
          value == null || value.isEmpty ? 'Required field' : null,
    );
  }

  Widget buildDropdown(
      List<String> items, Function(String?) onChanged, String? value) {
    return DropdownButtonFormField<String>(
      value: value,
      dropdownColor: Colors.grey[900],
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey[800],
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none),
      ),
      items: items.map((String val) {
        return DropdownMenuItem<String>(
          value: val,
          child: Text(val),
        );
      }).toList(),
      onChanged: onChanged,
      validator: (value) =>
          value == null || value.isEmpty ? 'Please select' : null,
    );
  }
}
