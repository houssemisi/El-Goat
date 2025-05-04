import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:supabase_flutter/supabase_flutter.dart';
import '../screens/clubsigup_page.dart';
import '../screens/scoutsignup_page.dart';
import '../screens/footballersignup_page.dart';
import '../widgets/navbar/bottom_navbar.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey         = GlobalKey<FormState>();
  final _nameController  = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _selectedCategory;
  bool _isLoading = false;
  int  _navIndex  = 0;
=======
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Authentication
import '../screens/success_page.dart';
import '../screens/clubsigup_page.dart'; // Import ClubSignUpPage
import '../screens/scoutsignup_page.dart'; // Import ScoutSignUpPage
import '../widgets/navbar/bottom_navbar.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  String? _selectedCategory;
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  int _selectedIndex = 0;

  final FirebaseAuth _auth =
      FirebaseAuth.instance; // Firebase Authentication instance
>>>>>>> 6cac91beaada61b3ffc53a7521518f9a73ed764c

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

<<<<<<< HEAD
  void _onNavTapped(int index) {
    setState(() => _navIndex = index);
    const routes = ['/', '/stories', '/news_home', '/profile'];
    if (index < routes.length) Navigator.pushNamed(context, routes[index]);
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate() || _selectedCategory == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please complete all fields')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      // 1️⃣ Sign up with Supabase Auth
      final AuthResponse res = await Supabase.instance.client.auth.signUp(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      if (res.session == null || res.user == null) {
        throw AuthException('Sign-up failed: No session or user returned');
      }
      final userId = res.user!.id;

      // 2️⃣ Insert minimal profile row
      final tableName = '${_selectedCategory!.toLowerCase()}_profiles';
      final insertResp = await Supabase.instance.client
          .from(tableName)
          .insert({
            'user_id': userId,
            'name': _nameController.text.trim(),
            'last_seen': DateTime.now().toIso8601String(),
          });
      if (insertResp.error != null) {
        throw insertResp.error!;
      }

      // 3️⃣ Navigate to the correct form page based on the selected category
      Widget nextPage;
      switch (_selectedCategory) {
        case 'Club':
          nextPage = ClubSignUpPage(userId: userId);
          break;
        case 'Scout':
          nextPage = ScoutSignUpPage(userId: userId);
          break;
        case 'Footballer':
          nextPage = FootballerSignUpPage(userId: userId);
          break;
        default:
          throw Exception('Invalid category selected');
      }

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => nextPage),
      );
    } catch (err) {
      final message = (err is AuthException) ? err.message : err.toString();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $message')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  InputDecoration _inputDecoration(String hint, IconData icon) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.white54),
      prefixIcon: Icon(icon, color: Colors.white54),
      filled: true,
      fillColor: Colors.grey[800],
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide.none,
      ),
    );
=======
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/');
        break;
      case 1:
        Navigator.pushNamed(context, '/stories');
        break;
      case 2:
        Navigator.pushNamed(context, '/news');
        break;
      case 3:
        Navigator.pushNamed(context, '/profile');
        break;
    }
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      if (_selectedCategory == 'Club') {
        try {
          // Register the user in Firebase Authentication
          await _auth.createUserWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim(),
          );
        // Navigate to the ClubSignUpPage if the category is "Club"
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ClubSignUpPage(),
          ),
        );
        } catch (e) {
          // Handle errors (e.g., email already in use, weak password)
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${e.toString()}')),
          );
        }
      } else if (_selectedCategory == 'Scout') {
        try {
          // Register the user in Firebase Authentication
          await _auth.createUserWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim(),
          );

          // Navigate to the ScoutSignUpPage if the category is "Scout"
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ScoutSignUpPage(),
            ),
          );
        } catch (e) {
          // Handle errors (e.g., email already in use, weak password)
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${e.toString()}')),
          );
        }
      } else {
        try {
          // Register the user in Firebase Authentication for other categories
          await _auth.createUserWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim(),
          );

          // Navigate to Success Page if registration is successful
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SuccessPage()),
          );
        } catch (e) {
          // Handle errors (e.g., email already in use, weak password)
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${e.toString()}')),
          );
        }
      }
    }
>>>>>>> 6cac91beaada61b3ffc53a7521518f9a73ed764c
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.black],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
<<<<<<< HEAD
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  Image.asset('assets/images/logo.png', height: 40, width: 40),
                  const SizedBox(height: 20),
                  const Text('Welcome to', style: TextStyle(color: Colors.white, fontSize: 20)),
                  const Text('GOAT', style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pushNamed(context, '/login'),
                        child: const Text('Login', style: TextStyle(color: Colors.white, fontSize: 18)),
                      ),
                      const VerticalDivider(color: Colors.white),
                      const Text('Sign up', style: TextStyle(color: Colors.white, fontSize: 18)),
                      const SizedBox(width: 6),
                      const CircleAvatar(radius: 4, backgroundColor: Colors.yellow),
                    ],
                  ),
                  const SizedBox(height: 30),

                  // Name
                  TextFormField(
                    controller: _nameController,
                    decoration: _inputDecoration('Full Name', Icons.person),
                    style: const TextStyle(color: Colors.white),
                    validator: (v) => (v ?? '').isEmpty ? 'Enter your name' : null,
                  ),
                  const SizedBox(height: 20),

                  // Email
                  TextFormField(
                    controller: _emailController,
                    decoration: _inputDecoration('Email', Icons.email),
                    style: const TextStyle(color: Colors.white),
                    validator: (v) {
                      if ((v ?? '').isEmpty) return 'Enter your email';
                      return RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(v!) ? null : 'Invalid email';
                    },
                  ),
                  const SizedBox(height: 20),

                  // Password
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: _inputDecoration('Password', Icons.lock),
                    style: const TextStyle(color: Colors.white),
                    validator: (v) => (v ?? '').length < 8 ? 'Password min 8 chars' : null,
                  ),
                  const SizedBox(height: 20),

                  // Category dropdown
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[800],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    dropdownColor: Colors.grey[800],
                    value: _selectedCategory,
                    hint: const Text('Category', style: TextStyle(color: Colors.white54)),
                    items: ['Footballer', 'Scout', 'Club']
                        .map((c) => DropdownMenuItem(value: c, child: Text(c, style: const TextStyle(color: Colors.white))))
                        .toList(),
                    onChanged: (v) => setState(() => _selectedCategory = v),
                    validator: (v) => v == null ? 'Select category' : null,
                  ),
                  const SizedBox(height: 30),

                  // Submit
                  ElevatedButton(
                    onPressed: _isLoading ? null : _submitForm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.yellow,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    ),
                    child: _isLoading
                        ? const CircularProgressIndicator(color: Colors.black)
                        : const Text('Sign up', style: TextStyle(color: Colors.black, fontSize: 18)),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
=======
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                Center(
                  child: Image.asset(
                    'assets/images/logo.png',
                    height: 40,
                    width: 40,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Welcome to',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                const Text(
                  'GOAT',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/login');
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                    const VerticalDivider(color: Colors.white),
                    Column(
                      children: [
                        const Text(
                          'Sign up',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        const SizedBox(height: 4),
                        const CircleAvatar(
                          radius: 4,
                          backgroundColor: Colors.yellow,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    hintText: 'Full name',
                    hintStyle: const TextStyle(color: Colors.white54),
                    prefixIcon: const Icon(Icons.person, color: Colors.white54),
                    filled: true,
                    fillColor: Colors.grey[800],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  style: const TextStyle(color: Colors.white),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your full name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    hintStyle: const TextStyle(color: Colors.white54),
                    prefixIcon: const Icon(Icons.email, color: Colors.white54),
                    filled: true,
                    fillColor: Colors.grey[800],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  style: const TextStyle(color: Colors.white),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    final emailRegex = RegExp(
                        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
                    if (!emailRegex.hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    hintStyle: const TextStyle(color: Colors.white54),
                    prefixIcon: const Icon(Icons.lock, color: Colors.white54),
                    filled: true,
                    fillColor: Colors.grey[800],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  style: const TextStyle(color: Colors.white),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    if (value.length < 8) {
                      return 'Password must be at least 8 characters long';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[800],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  dropdownColor: Colors.grey[800],
                  value: _selectedCategory,
                  hint: const Text(
                    'Category',
                    style: TextStyle(color: Colors.white54),
                  ),
                  icon:
                      const Icon(Icons.arrow_drop_down, color: Colors.white54),
                  items: ['Footballer', 'Scout', 'Club']
                      .map((category) => DropdownMenuItem<String>(
                            value: category,
                            child: Text(
                              category,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedCategory = value;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Please select a category';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30),
                Center(
                  child: ElevatedButton(
                    onPressed: _submitForm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.yellow,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 15),
                    ),
                    child: const Text(
                      'Sign up',
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                  ),
                ),
              ],
>>>>>>> 6cac91beaada61b3ffc53a7521518f9a73ed764c
            ),
          ),
        ),
      ),
<<<<<<< HEAD
      bottomNavigationBar: BottomNavbar(selectedIndex: _navIndex, onItemTapped: _onNavTapped),
=======
      bottomNavigationBar: BottomNavbar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
>>>>>>> 6cac91beaada61b3ffc53a7521518f9a73ed764c
    );
  }
}
