import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
        break;
    }
  }

  Future<void> _uploadImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) setState(() => _uploadedImages.add(image.path));
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = Supabase.instance.client.auth.currentUser;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text('Profil', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.message, color: Colors.white),
            onPressed: () {
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
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cover image + profile avatar
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
                    backgroundImage: FileImage(File(widget.userImage)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  const SizedBox(height: 5),
                  Row(
                    children: const [
                      Icon(Icons.flag, color: Colors.red, size: 20),
                      SizedBox(width: 5),
                      Text('Country', style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                  const SizedBox(height: 20),
                  LinearProgressIndicator(
                    value: 0.25,
                    backgroundColor: Colors.grey[800],
                    color: Colors.yellow,
                  ),
                  const SizedBox(height: 10),
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
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavbar(selectedIndex: _selectedIndex, onItemTapped: _onItemTapped),
    );
  }
}
