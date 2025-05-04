import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:supabase_flutter/supabase_flutter.dart';
import '../services/supabase_auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
=======
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Authentication

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
>>>>>>> 6cac91beaada61b3ffc53a7521518f9a73ed764c

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
<<<<<<< HEAD
  bool _isLoading = false;

  void _login() async {
  setState(() => _isLoading = true);
  try {
    final AuthResponse res = await Supabase.instance.client.auth.signInWithPassword(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    );
    debugPrint('▶️ signIn response.user: ${res.user}');
    if (res.session == null || res.user == null) {
      throw AuthException('Authentication failed: No session or user returned');
    }
    // At this point session exists:
    Navigator.pushReplacementNamed(context, '/');
  } on AuthException catch (err) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(err.message)),
    );
  } catch (err) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Unexpected error: $err')),
    );
  } finally {
    setState(() => _isLoading = false);
  }
}

=======
  final FirebaseAuth _auth =
      FirebaseAuth.instance; // Firebase Authentication instance
  bool _isLoading = false;

  void _login() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      Navigator.pushNamed(context, '/'); // Navigate to Home Page
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
>>>>>>> 6cac91beaada61b3ffc53a7521518f9a73ed764c

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
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/goat.png',
                    height: 40,
                    width: 40,
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
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          const Text(
                            'Login',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          const SizedBox(height: 4),
                          const CircleAvatar(
                            radius: 4,
                            backgroundColor: Colors.yellow,
                          ),
                        ],
                      ),
                      const SizedBox(width: 10),
                      Container(height: 10, width: 1, color: Colors.white),
                      const SizedBox(width: 10),
                      GestureDetector(
                        onTap: () => Navigator.pushNamed(context, '/registration'),
                        child: const Text(
                          'Sign up',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _emailController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Email',
                      hintStyle: const TextStyle(color: Colors.white54),
                      filled: true,
                      fillColor: Colors.grey[800],
                      prefixIcon: const Icon(Icons.email, color: Colors.white),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Password',
                      hintStyle: const TextStyle(color: Colors.white54),
                      filled: true,
                      fillColor: Colors.grey[800],
                      prefixIcon: const Icon(Icons.lock, color: Colors.white),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _isLoading ? null : _login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.yellow,
                      padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: _isLoading
                        ? const CircularProgressIndicator(color: Colors.black)
                        : const Text(
                            'Login',
                            style: TextStyle(color: Colors.black, fontSize: 18),
                          ),
                  ),
                ],
              ),
=======
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Image.asset(
                    'assets/images/goat.png', // Replace with your actual image path
                    height: 40,
                    width: 40,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Welcome to",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                const Text(
                  "GOAT",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        const Text("Login",
                            style:
                                TextStyle(color: Colors.white, fontSize: 16)),
                        const SizedBox(height: 4),
                        const CircleAvatar(
                          radius: 4,
                          backgroundColor: Colors.yellow,
                        ),
                      ],
                    ),
                    const SizedBox(width: 10),
                    Container(
                      height: 10,
                      width: 1,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/registration');
                      },
                      child: const Text("Sign up",
                          style: TextStyle(color: Colors.white, fontSize: 16)),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _emailController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: "Email",
                    hintStyle: const TextStyle(color: Colors.white54),
                    filled: true,
                    fillColor: Colors.grey[800],
                    prefixIcon: const Icon(Icons.email, color: Colors.white),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none),
                  ),
                ),
                const SizedBox(height: 15),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: "Password",
                    hintStyle: const TextStyle(color: Colors.white54),
                    filled: true,
                    fillColor: Colors.grey[800],
                    prefixIcon: const Icon(Icons.lock, color: Colors.white),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _isLoading ? null : _login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.yellow,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 80, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(
                          color: Colors.black,
                        )
                      : const Text("Login",
                          style: TextStyle(color: Colors.black, fontSize: 18)),
                ),
              ],
>>>>>>> 6cac91beaada61b3ffc53a7521518f9a73ed764c
            ),
          ),
        ),
      ),
    );
  }
}
