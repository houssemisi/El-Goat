import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:supabase_flutter/supabase_flutter.dart';
import 'success_page.dart';

class ClubSignUpPage extends StatefulWidget {
  final String userId;
  const ClubSignUpPage({Key? key, required this.userId}) : super(key: key);
=======
import 'package:image_picker/image_picker.dart';
import 'success_page.dart'; // Import SuccessPage
import 'dart:io';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'El Goat',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ClubSignUpPage(),
    );
  }
}

class ClubSignUpPage extends StatefulWidget {
  const ClubSignUpPage({super.key});
>>>>>>> 6cac91beaada61b3ffc53a7521518f9a73ed764c

  @override
  _ClubSignUpPageState createState() => _ClubSignUpPageState();
}

class _ClubSignUpPageState extends State<ClubSignUpPage> {
  final _formKey = GlobalKey<FormState>();
<<<<<<< HEAD
  bool _isSaving = false;

  // Controllers for form fields
  final _clubNameCtrl   = TextEditingController();
  final _locationCtrl   = TextEditingController();
  final _websiteCtrl    = TextEditingController();
  final _descriptionCtrl= TextEditingController();

  @override
  void dispose() {
    _clubNameCtrl.dispose();
    _locationCtrl.dispose();
    _websiteCtrl.dispose();
    _descriptionCtrl.dispose();
    super.dispose();
  }

  /// Saves the club profile to Supabase and navigates to the success page
  Future<void> _saveProfile() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isSaving = true);

    final profile = {
      'user_id':       widget.userId,
      'club_name':     _clubNameCtrl.text.trim(),
      'location':      _locationCtrl.text.trim(),
      'website':       _websiteCtrl.text.trim(),
      'description':   _descriptionCtrl.text.trim(),
      'last_seen':     DateTime.now().toIso8601String(),
    };

    final res = await Supabase.instance.client
        .from('club_profiles')
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
        title: const Text('Complete Club Profile'),
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
                      'Club Information',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Club Name
                  _buildLabel('Club Name'),
                  _buildTextField(
                    hint: 'Enter club name',
                    controller: _clubNameCtrl,
                  ),

                  // Location
                  _buildLabel('Location (City, Region)'),
                  _buildTextField(
                    hint: 'Enter location',
                    controller: _locationCtrl,
                  ),

                  // Website (optional)
                  _buildLabel('Website (Optional)'),
                  _buildTextField(
                    hint: 'https://example.com',
                    controller: _websiteCtrl,
                    keyboard: TextInputType.url,
                    validator: (v) {
                      final val = v!.trim();
                      if (val.isEmpty) return null;
                      final pattern = r'^(https?:\/\/)?[\w.-]+\.[a-z]{2,}';
                      if (!RegExp(pattern).hasMatch(val)) {
                        return 'Invalid URL';
                      }
                      return null;
                    },
                  ),

                  // Description
                  _buildLabel('Club Description'),
                  _buildTextField(
                    hint: 'Enter description',
                    controller: _descriptionCtrl,
                    maxLines: 3,
                  ),

                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _isSaving ? null : _saveProfile,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.greenAccent,
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
              ),
            ),
=======
  final _clubNameController = TextEditingController();
  final _locationController = TextEditingController();
  final _websiteController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  XFile? _clubLogo;

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _clubLogo = image;
    });
  }

  @override
  void dispose() {
    _clubNameController.dispose();
    _locationController.dispose();
    _websiteController.dispose();
    _descriptionController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up – Club Profile'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Club Information',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _clubNameController,
                decoration: const InputDecoration(
                  labelText: '🏷️ Club Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the club name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _locationController,
                decoration: const InputDecoration(
                  labelText: '🗺️ Location (City, Region)',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the location';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _websiteController,
                decoration: const InputDecoration(
                  labelText: '🌐 Website (optional)',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: '📝 Club Description',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              const Text(
                'Media Upload',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: _pickImage,
                icon: const Icon(Icons.image),
                label: const Text('📸 Upload Club Logo'),
              ),
              if (_clubLogo != null)
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Image.file(
                    File(_clubLogo!.path),
                    height: 100,
                  ),
                ),
              const SizedBox(height: 20),
              const Text(
                'Account Access',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: '📧 Email Address',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email address';
                  }
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: '🔒 Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  if (value.length < 6) {
                    return 'Password must be at least 6 characters long';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Navigate to SuccessPage after successful validation
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SuccessPage(),
                        ),
                      );
                    }
                  },
                  child: const Text('🔘 Sign Up'),
                ),
              ),
            ],
>>>>>>> 6cac91beaada61b3ffc53a7521518f9a73ed764c
          ),
        ),
      ),
    );
  }
<<<<<<< HEAD

  Widget _buildLabel(String text) => Padding(
        padding: const EdgeInsets.only(top: 12, bottom: 4),
        child: Text(text,
            style: TextStyle(color: Colors.grey[300], fontWeight: FontWeight.w500)),
      );

  Widget _buildTextField({
    required String hint,
    required TextEditingController controller,
    TextInputType keyboard = TextInputType.text,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) => TextFormField(
        controller: controller,
        style: const TextStyle(color: Colors.white),
        keyboardType: keyboard,
        maxLines: maxLines,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey[800],
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
        validator: validator ?? (v) => (v == null || v.isEmpty) ? 'Required' : null,
      );
}
=======
}

>>>>>>> 6cac91beaada61b3ffc53a7521518f9a73ed764c
