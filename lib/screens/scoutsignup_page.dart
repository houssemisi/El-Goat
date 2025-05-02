import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/screens/success_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'El Goat – Scout',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ScoutSignUpPage(userId: 'exampleUserId'),
      routes: {
        '/scout_profile': (context) => const SuccessPage(),
      },
    );
  }
}

class ScoutSignUpPage extends StatefulWidget {
  final String userId;          // ← add this
  const ScoutSignUpPage({
    Key? key,
    required this.userId,       // ← and require it
  }) : super(key: key);

  @override
  State<ScoutSignUpPage> createState() => _ScoutSignUpPageState();
}
class _ScoutSignUpPageState extends State<ScoutSignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _cityController = TextEditingController();
  final _emailController = TextEditingController(); // Email text field controller
  final _phoneController = TextEditingController(); // Phone text field controller
  final _countryController = TextEditingController(); // Country text field controller
  final _scoutingLevelController = TextEditingController(); // Scouting level text field controller
  final _experienceController = TextEditingController();
  final _bioController = TextEditingController(); // Bio text field controller
  String? _selectedCountry;
  String? _selectedScoutingLevel;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;



  final List<String> _countries = [
    'Tunisia',
'Algeria',
'Marocco',
'Egypt',
'Sudan',
'Libya',
'South Africa',
'Nigeria',
'Kenya',
'Ghana',
'Mali',
'Cameroon',
'Togo',
'Burkina Faso',
'Uganda',
'Zambia',
'Zimbabwe',
'Namibia',
'Botswana',
'Rwanda',
'Congo',
'Gabon',
'Angola',
'Tanzania',
'Ethiopia',
'Somalia',
'Djibouti',
'Mauritius',
'Seychelles',
'United States',
'United Kingdom',
'France',
'Germany',
'Spain',
'Italy',
'Portugal',
'Netherlands',
'Belgium',
'Sweden',
'Norway',
'Finland',
'Denmark',
'Russia',
'India',
'Pakistan',
'Bangladesh',
'Sri Lanka',
'Indonesia',
'Malaysia',
'Philippines',
'Vietnam',
'Australia',
'Japan',
'China',
'Brazil',
  ];

  final List<String> _scoutingLevels = ['Local', 'National', 'International'];

  @override
  void dispose() {
    _nameController.dispose();
    _cityController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _countryController.dispose();
    _experienceController.dispose();
    _bioController.dispose();
    super.dispose();
  }

Future<void> submitScoutForm() async {
  final user = FirebaseAuth.instance.currentUser;

  final scoutData = {
    "fullName": _nameController.text,
    "email": _emailController.text,
    "phone": _phoneController.text,
    "country": _countryController.text,
    "city": _cityController.text,
    "scoutingLevel": _scoutingLevelController.text,
    "experience": _experienceController.text,
    "bio": _bioController.text,
    "createdAt": FieldValue.serverTimestamp(),
  };

  await FirebaseFirestore.instance
      .collection("Users")
      .doc(user!.uid)
      .collection("ScoutData")
      .doc("info")
      .set(scoutData);
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up – Scout Profile'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Scout Information',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: '🧑 Full Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your full name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: _selectedCountry,
                decoration: const InputDecoration(
                  labelText: '🌍 Country / Region',
                  border: OutlineInputBorder(),
                ),
                items: _countries
                    .map((country) => DropdownMenuItem(
                          value: country,
                          child: Text(country),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCountry = value;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Please select a country';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _cityController,
                decoration: const InputDecoration(
                  labelText: '🧭 City',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your city';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: _selectedScoutingLevel,
                decoration: const InputDecoration(
                  labelText: '🎯 Scouting Level',
                  border: OutlineInputBorder(),
                ),
                items: _scoutingLevels
                    .map((level) => DropdownMenuItem(
                          value: level,
                          child: Text(level),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedScoutingLevel = value;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Please select a scouting level';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _experienceController,
                decoration: const InputDecoration(
                  labelText: '📅 Years of Experience',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your years of experience';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              const Text(
                'Bio',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _bioController,
                decoration: const InputDecoration(
                  labelText: '📝 Bio',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your bio';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Navigate to ScoutProfilePage with the entered data
                      Navigator.pushNamed(
                        context,
                        '/scout_profile',
                        arguments: {
                          'name': _nameController.text,
                          'country': _selectedCountry,
                          'city': _cityController.text,
                          'scoutingLevel': _selectedScoutingLevel,
                          'experience': _experienceController.text,
                          'bio': _bioController.text,
                        },
                      );
                    }
                  },
                  child: const Text('🔘 Sign Up'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
