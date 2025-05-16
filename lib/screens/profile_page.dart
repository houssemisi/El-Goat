import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../widgets/navbar/bottom_navbar.dart';
import '../widgets/profile_quick_button.dart';
import '../widgets/fifa_player_card.dart';
import '../screens/chat_page.dart';
import 'dart:io';

class FootballerProfilePage extends StatefulWidget {
  const FootballerProfilePage({Key? key}) : super(key: key);

  @override
  _FootballerProfilePageState createState() => _FootballerProfilePageState();
}

class _FootballerProfilePageState extends State<FootballerProfilePage> {
  bool _loading = true;
  Map<String, dynamic>? _profile;
  final List<String> _uploadedImages = [];
  final ImagePicker _picker = ImagePicker();
  int _selectedIndex = 3;

  @override
  void initState() {
    super.initState();
    _fetchFootballerProfile();
  }

  Future<void> _fetchFootballerProfile() async {
    final userId = Supabase.instance.client.auth.currentUser?.id;
    if (userId == null) {
      setState(() => _loading = false);
      return;
    }

    final profileResponse = await Supabase.instance.client
        .from('footballer_profiles')
        .select()
        .eq('user_id', userId)
        .order('created_at', ascending: false)
        .limit(1)
        .maybeSingle();

    setState(() {
      _profile = profileResponse is Map<String, dynamic> ? profileResponse : null;
      _loading = false;
    });
  }

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
    const routes = ['/', '/stories', '/news_reels', '/profile'];
    if (index < routes.length) Navigator.pushNamed(context, routes[index]);
  }

  Future<void> _uploadImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) setState(() => _uploadedImages.add(image.path));
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(
        backgroundColor: Colors.black,
        body: Center(child: CircularProgressIndicator()),
      );
    }
    if (_profile == null) {
      Future.microtask(() {
        Navigator.pushReplacementNamed(context, '/login_required');
      });
      return const SizedBox.shrink();
    }

    final data = _profile!;
    final name = data['full_name'] ?? 'Unnamed';
    final image = 'assets/images/player_avatar.jpeg';
    final club = data['current_club'] ?? 'None';
    final position = data['position'] ?? 'Unknown';
    final isScoutApproved = data['is_scout_approved'] == true;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text('Footballer Profile', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.message, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ChatScreen(
                    otherUserId: data['user_id'],
                    otherUserName: name,
                    otherUserImage: image,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ⚽ Header banner + avatar
            Stack(
              children: [
                Container(
                  height: 180,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/football_field.jpeg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: 16,
                  child: CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage(image),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // 🔤 Name & edit
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
                const Icon(Icons.edit, color: Colors.white),
              ],
            ),
            const SizedBox(height: 8),
            Text('Position: $position • Club: $club', style: const TextStyle(color: Colors.grey)),

            // ✅ Scout Approved Badge
            if (isScoutApproved)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Row(
                  children: [
                    Image.asset('assets/images/scout_badge.png', width: 40),
                    const SizedBox(width: 10),
                    const Text(
                      "Scout Approved",
                      style: TextStyle(
                        color: Colors.amberAccent,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

            const SizedBox(height: 12),

            // 🎯 Quick buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ProfileQuickButton(icon: Icons.favorite_border, label: 'Favorites', onTap: () => Navigator.pushNamed(context, '/favorites')),
                ProfileQuickButton(icon: Icons.notifications_none, label: 'Notifications', onTap: () => Navigator.pushNamed(context, '/notifications')),
                ProfileQuickButton(icon: Icons.star_border, label: 'Ratings', onTap: () => Navigator.pushNamed(context, '/ratings')),
              ],
            ),
            const SizedBox(height: 20),

            // 🎮 FIFA Card
            FifaPlayerCard(
              playerName: name,
              overallRating: 89,
              position: position,
              playerImagePath: image,
              clubLogoPath: 'assets/images/club_logo.jpeg',
              stats: {'PAC': 85, 'SHO': 90, 'PAS': 82, 'DRI': 88, 'DEF': 40, 'PHY': 78},
            ),
            const SizedBox(height: 24),

            // 🛤 Journey Upload
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

            // 🖼 Uploaded journey gallery
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
      bottomNavigationBar: BottomNavbar(selectedIndex: _selectedIndex, onItemTapped: _onItemTapped),
    );
  }
}
