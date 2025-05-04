import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:supabase_flutter/supabase_flutter.dart';
import '../screens/success_page.dart';

class FootballerSignUpPage extends StatefulWidget {
  final String userId;
  const FootballerSignUpPage({Key? key, required this.userId}) : super(key: key);

  @override
  State<FootballerSignUpPage> createState() => _FootballerSignUpPageState();
=======

class FootballerSignUpPage extends StatefulWidget {
  final Function(Map<String, String>)
      onProfileCreated; // Callback to notify profile creation

  const FootballerSignUpPage({Key? key, required this.onProfileCreated})
      : super(key: key);

  @override
  _FootballerSignUpPageState createState() => _FootballerSignUpPageState();
>>>>>>> 6cac91beaada61b3ffc53a7521518f9a73ed764c
}

class _FootballerSignUpPageState extends State<FootballerSignUpPage> {
  final _formKey = GlobalKey<FormState>();
<<<<<<< HEAD
  bool _isSaving = false;

  // Controllers
  final _fullNameCtrl = TextEditingController();
  final _phoneCtrl    = TextEditingController();
  final _dobCtrl      = TextEditingController();
  final _heightCtrl   = TextEditingController();
  final _weightCtrl   = TextEditingController();
  final _clubCtrl     = TextEditingController();

  // Dropdown selections
=======

  // Form fields
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _clubController = TextEditingController();

>>>>>>> 6cac91beaada61b3ffc53a7521518f9a73ed764c
  String? position;
  String? foot;
  String? experience;

  @override
  void dispose() {
<<<<<<< HEAD
    _fullNameCtrl.dispose();
    _phoneCtrl.dispose();
    _dobCtrl.dispose();
    _heightCtrl.dispose();
    _weightCtrl.dispose();
    _clubCtrl.dispose();
    super.dispose();
  }

  Future<void> _saveProfile() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isSaving = true);

    final profile = {
      'user_id':          widget.userId,
      'full_name':        _fullNameCtrl.text.trim(),
      'phone':            _phoneCtrl.text.trim(),
      'dob':              _dobCtrl.text.trim(),
      'position':         position,
      'preferred_foot':   foot,
      'height_cm':        int.parse(_heightCtrl.text.trim()),
      'weight_kg':        int.parse(_weightCtrl.text.trim()),
      'experience_level': experience,
      'current_club':     _clubCtrl.text.trim().isEmpty
                            ? 'None'
                            : _clubCtrl.text.trim(),
      'last_seen':        DateTime.now().toIso8601String(),
    };

    final res = await Supabase.instance.client
        .from('footballer_profiles')
        .update(profile)
        .eq('user_id', widget.userId);

    if (res.error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(res.error!.message)),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const SuccessPage()),
      );
    }

    setState(() => _isSaving = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Footballer Profile'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFF2C2C2C),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: Text(
                      'Complete Footballer Profile',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Full Name
                  _buildLabel('Full Name'),
                  _buildTextField(
                    'Enter your full name',
                    _fullNameCtrl,
                    validator: (v) => v!.trim().isEmpty ? 'Required' : null,
                  ),

                  // Phone
                  _buildLabel('Phone Number'),
                  _buildTextField(
                    'Enter phone',
                    _phoneCtrl,
                    keyboard: TextInputType.phone,
                    validator: (v) {
                      final val = v!.trim();
                      if (!RegExp(r'^\d{8,15}\$').hasMatch(val)) {
                        return 'Enter 8–15 digits';
                      }
                      return null;
                    },
                  ),

                  // DOB
                  _buildLabel('Date of Birth'),
                  _buildTextField(
                    'DD/MM/YYYY',
                    _dobCtrl,
                    keyboard: TextInputType.datetime,
                    prefixIcon: Icons.calendar_today,
                    validator: (v) {
                      final val = v!.trim();
                      if (!RegExp(r'^\d{2}/\d{2}/\d{4}\$').hasMatch(val)) {
                        return 'Use DD/MM/YYYY';
                      }
                      final parts = val.split('/');
                      final day = int.parse(parts[0]);
                      final month = int.parse(parts[1]);
                      final year = int.parse(parts[2]);
                      final date = DateTime.tryParse("\$year-\${month.toString().padLeft(2,'0')}-\${day.toString().padLeft(2,'0')}");
                      if (date == null) return 'Invalid date';
                      final age = DateTime.now().difference(date).inDays ~/ 365;
                      if (age < 10 || age > 80) return 'Age 10–80 only';
                      return null;
                    },
                  ),

                  // Position dropdown
                  _buildLabel('Position'),
                  _buildDropdown(
                    ['Goalkeeper','Defender','Midfielder','Striker'],
                    position,
                    (val) => setState(() => position = val),
                  ),

                  // Preferred foot
                  _buildLabel('Preferred Foot'),
                  _buildDropdown(
                    ['Left','Right','Both'],
                    foot,
                    (val) => setState(() => foot = val),
                  ),

                  // Height
                  _buildLabel('Height (cm)'),
                  _buildTextField(
                    'Enter height',
                    _heightCtrl,
                    keyboard: TextInputType.number,
                    validator: (v) {
                      final h = int.tryParse(v!.trim());
                      if (h == null || h < 100 || h > 250) {
                        return 'Enter 100–250 cm';
                      }
                      return null;
                    },
                  ),

                  // Weight
                  _buildLabel('Weight (kg)'),
                  _buildTextField(
                    'Enter weight',
                    _weightCtrl,
                    keyboard: TextInputType.number,
                    validator: (v) {
                      final w = int.tryParse(v!.trim());
                      if (w == null || w < 30 || w > 200) {
                        return 'Enter 30–200 kg';
                      }
                      return null;
                    },
                  ),

                  // Experience
                  _buildLabel('Experience Level'),
                  _buildDropdown(
                    ['Beginner','Semi-Pro','Professional'],
                    experience,
                    (val) => setState(() => experience = val),
                  ),

                  // Club optional
                  _buildLabel('Current Club (Optional)'),
                  _buildTextField(
                    'Enter club name',
                    _clubCtrl,
                    validator: (v) => null,
                  ),

                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _isSaving ? null : _saveProfile,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: _isSaving
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text(
                              'Save & Continue',
                              style: TextStyle(color: Colors.white, fontSize: 18),
                            ),
                    ),
                  ),
                ],
=======
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _dobController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    _clubController.dispose();
    super.dispose();
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
                            // Pass profile data back to ProfilePage
                            widget.onProfileCreated({
                              'fullName': _fullNameController.text,
                              'email': _emailController.text,
                              'phone': _phoneController.text,
                              'dob': _dobController.text,
                              'position': position ?? '',
                              'foot': foot ?? '',
                              'height': _heightController.text,
                              'weight': _weightController.text,
                              'experience': experience ?? '',
                              'club': _clubController.text,
                            });
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
>>>>>>> 6cac91beaada61b3ffc53a7521518f9a73ed764c
              ),
            ),
          ),
        ),
      ),
    );
  }

<<<<<<< HEAD
  Widget _buildLabel(String text) => Padding(
        padding: const EdgeInsets.only(top: 12, bottom: 4),
        child: Text(text, style: TextStyle(color: Colors.grey[300], fontWeight: FontWeight.w500)),
      );

  Widget _buildTextField(
    String hint,
    TextEditingController ctrl, {
    TextInputType keyboard = TextInputType.text,
    IconData? prefixIcon,
    String? Function(String?)? validator,
  }) => TextFormField(
        controller: ctrl,
        style: const TextStyle(color: Colors.white),
        keyboardType: keyboard,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey[800],
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.grey),
          prefixIcon: prefixIcon != null ? Icon(prefixIcon, color: Colors.grey) : null,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
        ),
        validator: validator ?? (v) => (v == null || v.isEmpty) ? 'Required' : null,
      );

  Widget _buildDropdown(
    List<String> items,
    String? value,
    void Function(String?) onChanged,
  ) => DropdownButtonFormField<String>(
        value: value,
        dropdownColor: Colors.grey[900],
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey[800],
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
        ),
        items: items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
        onChanged: onChanged,
        validator: (v) => (v == null || v.isEmpty) ? 'Please select' : null,
      );
}
=======
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
>>>>>>> 6cac91beaada61b3ffc53a7521518f9a73ed764c
