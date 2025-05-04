import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
<<<<<<< HEAD
import 'package:supabase_flutter/supabase_flutter.dart';
import '../widgets/navbar/bottom_navbar.dart';
import '../widgets/profile_quick_button.dart';
import '../widgets/fifa_player_card.dart';
import '../screens/chat_page.dart';
import 'dart:io';

class FootballerProfilePage extends StatefulWidget {
  final String userId;
  final String userName;
  final String userImage;

  const FootballerProfilePage({
    Key? key,
    required this.userId,
    required this.userName,
    required this.userImage,
  }) : super(key: key);

  @override
  _FootballerProfilePageState createState() => _FootballerProfilePageState();
}

class _FootballerProfilePageState extends State<FootballerProfilePage> {
  int _selectedIndex = 3;
  final List<String> _uploadedImages = [];
  final ImagePicker _picker = ImagePicker();

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/');
        break;
      case 1:
        Navigator.pushNamed(context, '/stories');
        break;
      case 2:
        Navigator.pushNamed(context, '/news_reels');
        break;
      case 3:
        // remain on profile
=======
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
>>>>>>> 6cac91beaada61b3ffc53a7521518f9a73ed764c
        break;
    }
  }

  Future<void> _uploadImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
<<<<<<< HEAD
    if (image != null) setState(() => _uploadedImages.add(image.path));
=======
    if (image != null) {
      setState(() {
        _uploadedImages.add(image.path); // Add the image path to the list
      });
    }
>>>>>>> 6cac91beaada61b3ffc53a7521518f9a73ed764c
  }

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    final currentUser = Supabase.instance.client.auth.currentUser;

=======
>>>>>>> 6cac91beaada61b3ffc53a7521518f9a73ed764c
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
<<<<<<< HEAD
        title: const Text('Profil', style: TextStyle(color: Colors.white)),
=======
        title: const Text(
          'Profil',
          style: TextStyle(color: Colors.white),
        ),
>>>>>>> 6cac91beaada61b3ffc53a7521518f9a73ed764c
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.message, color: Colors.white),
            onPressed: () {
<<<<<<< HEAD
              if (currentUser == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Vous devez être connecté pour discuter')),
                );
                return;
              }
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ChatScreen(
                    otherUserId: widget.userId,
                    otherUserName: widget.userName,
                    otherUserImage: widget.userImage,
                  ),
                ),
              );
=======
              Navigator.pushNamed(context, '/chat'); // Navigate to ChatScreen
>>>>>>> 6cac91beaada61b3ffc53a7521518f9a73ed764c
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
<<<<<<< HEAD
            // Cover image + profile avatar
            Stack(
              children: [
                Container(
                  height: 200,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/football_field.jpeg'),
                      fit: BoxFit.cover,
=======
            // Cover Image and Profile Picture
            Stack(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      // Expand image functionality
                    });
                  },
                  child: Container(
                    height: 200,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/football_field.jpeg'),
                        fit: BoxFit.cover,
                      ),
>>>>>>> 6cac91beaada61b3ffc53a7521518f9a73ed764c
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: 20,
<<<<<<< HEAD
                  child: CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.grey[800],
                    backgroundImage: FileImage(File(widget.userImage)),
=======
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        // Expand image functionality
                      });
                    },
                    child: CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.grey[800],
                      child: const Text(
                        'K',
                        style: TextStyle(fontSize: 40, color: Colors.white),
                      ),
                    ),
>>>>>>> 6cac91beaada61b3ffc53a7521518f9a73ed764c
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
<<<<<<< HEAD
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
=======
            // Personal Information
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
>>>>>>> 6cac91beaada61b3ffc53a7521518f9a73ed764c
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
<<<<<<< HEAD
                    children: [
                      Text(widget.userName,
                          style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                      const Icon(Icons.edit, color: Colors.white),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Text('Age • Location', style: TextStyle(color: Colors.grey)),
=======
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
>>>>>>> 6cac91beaada61b3ffc53a7521518f9a73ed764c
                  const SizedBox(height: 5),
                  Row(
                    children: const [
                      Icon(Icons.flag, color: Colors.red, size: 20),
                      SizedBox(width: 5),
<<<<<<< HEAD
                      Text('Country', style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                  const SizedBox(height: 20),
                  LinearProgressIndicator(
                    value: 0.25,
=======
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
>>>>>>> 6cac91beaada61b3ffc53a7521518f9a73ed764c
                    backgroundColor: Colors.grey[800],
                    color: Colors.yellow,
                  ),
                  const SizedBox(height: 10),
<<<<<<< HEAD
                  const Text('Complétez votre profil (25%)', style: TextStyle(color: Colors.grey)),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ProfileQuickButton(icon: Icons.favorite_border, label: 'Favorites', onTap: () => Navigator.pushNamed(context, '/favorites')),
                      ProfileQuickButton(icon: Icons.notifications_none, label: 'Notifications', onTap: () => Navigator.pushNamed(context, '/notifications')),
                      ProfileQuickButton(icon: Icons.star_border, label: 'Ratings', onTap: () => Navigator.pushNamed(context, '/ratings')),
                    ],
                  ),
                  const SizedBox(height: 20),
                  FifaPlayerCard(
                    playerName: widget.userName,
                    overallRating: 89,
                    position: 'ST',
                    playerImagePath: widget.userImage,
                    clubLogoPath: 'assets/images/club_logo.jpeg',
                    stats: {'PAC': 85, 'SHO': 90, 'PAS': 82, 'DRI': 88, 'DEF': 40, 'PHY': 78},
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('My Journey', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                        const SizedBox(height: 10),
                        GestureDetector(
                          onTap: _uploadImage,
                          child: Container(
                            height: 100,
                            decoration: BoxDecoration(color: Colors.grey[800], borderRadius: BorderRadius.circular(10)),
                            child: const Center(child: Icon(Icons.add, color: Colors.white, size: 30)),
                          ),
                        ),
                        const SizedBox(height: 10),
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 10, mainAxisSpacing: 10),
                          itemCount: _uploadedImages.length,
                          itemBuilder: (ctx, i) => Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(image: FileImage(File(_uploadedImages[i])), fit: BoxFit.cover),
                            ),
                          ),
=======
                  const Text(
                    'Complétez votre profil (25%)',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // About Section and FIFA-Style Player Card
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // About Section
                  Expanded(
                    flex: 2,
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
                          onPressed: () {
                            // Add bio functionality
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                          ),
                          child: const Text('Ajouter ma bio'),
>>>>>>> 6cac91beaada61b3ffc53a7521518f9a73ed764c
                        ),
                      ],
                    ),
                  ),
<<<<<<< HEAD
=======
                  const SizedBox(width: 20),
                  // FIFA-Style Player Card
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.amber[700], // Gold background
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.5),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize:
                            MainAxisSize.min, // Adjust height dynamically
                        children: [
                          // Player Image
                          CircleAvatar(
                            radius: 40,
                            backgroundImage: const AssetImage(
                                'assets/images/player1.jpeg'), // Replace with player image
                            backgroundColor: Colors.grey[800],
                          ),
                          const SizedBox(height: 10),
                          // Player Name & Overall Rating
                          const Text(
                            "L. Yamal – 89 OVR",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 5),
                          // Position & Club Badge
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "ST",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Image.asset(
                                'assets/images/club_logo.jpeg', // Replace with club logo
                                width: 25,
                                height: 25,
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          // Player Stats
                          const Divider(color: Colors.white),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              // Left Column
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "PAC: 85",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    "SHO: 90",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    "PAS: 82",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              // Right Column
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "DRI: 88",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    "DEF: 40",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    "PHY: 78",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 5,
              width: 15,
            ),
            // My Journey Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
>>>>>>> 6cac91beaada61b3ffc53a7521518f9a73ed764c
                ],
              ),
            ),
          ],
        ),
      ),
<<<<<<< HEAD
      bottomNavigationBar: BottomNavbar(selectedIndex: _selectedIndex, onItemTapped: _onItemTapped),
=======
      bottomNavigationBar: BottomNavbar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
>>>>>>> 6cac91beaada61b3ffc53a7521518f9a73ed764c
    );
  }
}
