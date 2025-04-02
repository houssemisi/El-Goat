import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../widgets/navbar/bottom_navbar.dart';
import 'dart:io';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProfilePage(),
    );
  }
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _selectedIndex = 3; // Default selected index for Profile
  String _bio = ''; // Stores the user's bio
  final List<String> _uploadedImages = []; // Stores paths of uploaded images

  final ImagePicker _picker = ImagePicker();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/'); // Navigate to Home
        break;
      case 1:
        Navigator.pushNamed(context, '/stories'); // Navigate to Stories
        break;
      case 2:
        Navigator.pushNamed(context, '/news_reels'); // Navigate to News Reels
        break;
      case 3:
        // Stay on ProfilePage
        break;
    }
  }

  void _showBioDialog() {
    final TextEditingController bioController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Ajouter ma bio'),
          content: TextField(
            controller: bioController,
            maxLines: 3,
            style: const TextStyle(color: Colors.black), // Black text
            decoration: const InputDecoration(
              hintText: 'Écrivez quelque chose sur vous...',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: const Text('Annuler'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _bio = bioController.text; // Save the bio
                });
                Navigator.pop(context); // Close the dialog
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    const Color.fromARGB(255, 14, 140, 243), // Blue background
                foregroundColor: Colors.white, // White text
              ),
              child: const Text('Confirmer'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _uploadImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _uploadedImages.add(image.path); // Add the image path to the list
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text(
          'Profil',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cover Image and Profile Picture
            Stack(
              children: [
                Container(
                  height: 200,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/football_field.jpeg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: 20,
                  child: CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.grey[800],
                    child: const Text(
                      'K',
                      style: TextStyle(fontSize: 40, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Personal Information
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'Khalil SA',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Icon(Icons.edit, color: Colors.white),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    '23 ans • Toulouse, France',
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: const [
                      Icon(Icons.flag, color: Colors.red, size: 20),
                      SizedBox(width: 5),
                      Text(
                        'Tunisie',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Progress Bar
                  LinearProgressIndicator(
                    value: 0.25, // 25% progress
                    backgroundColor: Colors.grey[800],
                    color: Colors.yellow,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Complétez votre profil (25%)',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // About Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'À propos',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  _bio.isNotEmpty
                      ? Text(
                          _bio,
                          style: const TextStyle(color: Colors.grey),
                        )
                      : const Text(
                          'Dis-nous en plus sur toi',
                          style: TextStyle(color: Colors.grey),
                        ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: _showBioDialog,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                    ),
                    child: const Text('Ajouter ma bio'),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'My Journey',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: _uploadImage,
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.grey[800],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add, color: Colors.white, size: 30),
                            SizedBox(height: 5),
                            Text(
                              'Upload Image',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Display Uploaded Images
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: _uploadedImages.length,
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: FileImage(
                              File(_uploadedImages[index]),
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavbar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
