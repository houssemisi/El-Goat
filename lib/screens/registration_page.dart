import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../screens/clubsigup_page.dart';
import '../screens/scoutsignup_page.dart';
import '../screens/footballersignup_page.dart';
import '../screens/success_page.dart';
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

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

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
            'user_id':   userId,
            'name':      _nameController.text.trim(),
            'last_seen': DateTime.now().toIso8601String(),
          });
      if (insertResp.error != null) {
        throw insertResp.error!;
      }

      // 3️⃣ Navigate to the correct form page
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
          nextPage = const SuccessPage();
      }

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => nextPage),
      );
    } catch (err) {
      final message = (err is AuthException)
          ? err.message
          : err.toString();
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
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavbar(selectedIndex: _navIndex, onItemTapped: _onNavTapped),
    );
  }
}
