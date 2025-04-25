import 'package:flutter/material.dart';
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
      home: const ScoutSignUpPage(),
      routes: {
        '/scout_profile': (context) => const SuccessPage(),
      },
    );
  }
}

class ScoutSignUpPage extends StatefulWidget {
  const ScoutSignUpPage({super.key});

  @override
  _ScoutSignUpPageState createState() => _ScoutSignUpPageState();
}

class _ScoutSignUpPageState extends State<ScoutSignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _cityController = TextEditingController();
  final _experienceController = TextEditingController();
  final _bioController = TextEditingController(); // Bio text field controller
  String? _selectedCountry;
  String? _selectedScoutingLevel;

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
    _experienceController.dispose();
    _bioController.dispose();
    super.dispose();
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
