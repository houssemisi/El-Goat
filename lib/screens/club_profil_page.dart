<<<<<<< HEAD
// lib/screens/club_profile_page.dart
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../widgets/navbar/bottom_navbar.dart';

=======
import 'package:flutter/material.dart';
import '../widgets/navbar/bottom_navbar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const ClubProfilePage(),
    );
  }
}

>>>>>>> 6cac91beaada61b3ffc53a7521518f9a73ed764c
class ClubProfilePage extends StatefulWidget {
  const ClubProfilePage({Key? key}) : super(key: key);

  @override
<<<<<<< HEAD
  _ClubProfilePageState createState() => _ClubProfilePageState();
}

class _ClubProfilePageState extends State<ClubProfilePage> {
  bool _loading = true;
  Map<String, dynamic>? _profile;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final userId = Supabase.instance.client.auth.currentUser?.id;
    if (userId == null) {
      // Not logged in
      setState(() => _loading = false);
      return;
    }

    final response = await Supabase.instance.client
        .from('club_profiles')
        .select()
        .eq('user_id', userId)
        .maybeSingle();

    if (response == null || response is! Map<String, dynamic>) {
      // No profile
      setState(() {
        _profile = null;
        _loading = false;
      });
    } else {
      setState(() {
        _profile = response;
        _loading = false;
      });
=======
  State<ClubProfilePage> createState() => _ClubProfilePageState();
}

class _ClubProfilePageState extends State<ClubProfilePage> {
  int _selectedIndex = 0; // Default selected index for BottomNavbar

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
        Navigator.pushNamed(context, '/profile'); // Navigate to Profile
        break;
>>>>>>> 6cac91beaada61b3ffc53a7521518f9a73ed764c
    }
  }

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    if (_loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (_profile == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Club Profile'),
        ),
        body: const Center(
          child: Text('No profile found.'),
        ),
      );
    }

    final data = _profile!;
    final clubName       = data['club_name'] as String? ?? '';
    final location       = data['location'] as String? ?? '';
    final website        = data['website'] as String? ?? '';
    final description    = data['description'] as String? ?? '';

    final playersCount   = data['players_count'] as int? ?? 0;
    final titlesCount    = data['titles_count']  as int? ?? 0;
    final recruitmentOpen= data['recruitment_open'] as bool? ?? false;
    final positions      = (data['positions'] as List<dynamic>?)?.cast<String>() ?? [];
    final criteria       = data['criteria'] as String? ?? '';
    final announcements  = data['announcements'] as String? ?? '';
    final events         = data['events'] as String? ?? '';

    int _selectedIndex = 3;
    void _onItemTapped(int idx) {
      switch (idx) {
        case 0: Navigator.pushNamed(context, '/'); break;
        case 1: Navigator.pushNamed(context, '/stories'); break;
        case 2: Navigator.pushNamed(context, '/news_home'); break;
        case 3: break;
      }
      setState(() => _selectedIndex = idx);
    }

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(clubName, style: const TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/images/club_logo.jpeg'),
                  ),
                  const SizedBox(height: 10),
                  Text(clubName, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
                  const SizedBox(height: 6),
                  Text('$playersCount players under contract', style: const TextStyle(color: Colors.grey)),
                  Text('$titlesCount titles won', style: const TextStyle(color: Colors.grey)),
=======
    return Scaffold(
      backgroundColor: Colors.black, // Black background
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "Profil du Club",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Club Header
            Center(
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage(
                        'assets/images/club_logo.jpeg'), // Replace with your image asset
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Paris FC",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // White text for visibility
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    "25 joueurs sous contrat",
                    style: TextStyle(color: Colors.grey), // Grey text
                  ),
                  const Text(
                    "5 titres remportés",
                    style: TextStyle(color: Colors.grey), // Grey text
                  ),
>>>>>>> 6cac91beaada61b3ffc53a7521518f9a73ed764c
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
<<<<<<< HEAD
                      foregroundColor: Colors.black,
                    ),
                    child: const Text('SUBSCRIBE'),
=======
                      foregroundColor: const Color.fromARGB(255, 2, 75, 235),
                    ),
                    child: const Text("S’ABONNER"),
>>>>>>> 6cac91beaada61b3ffc53a7521518f9a73ed764c
                  ),
                ],
              ),
            ),
<<<<<<< HEAD
            const SizedBox(height: 24),

            // Info sections
            Row(
              children: [
                Expanded(
                  child: _buildInfoCard(
                    title: 'General Info',
                    children: [
                      'Location: $location',
                      'Website: $website',
                      'Description: $description',
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildInfoCard(
                    title: 'Recruitment',
                    children: [
                      'Hiring? ${recruitmentOpen ? 'Yes' : 'No'}',
                      'Positions: ${positions.join(', ')}',
                      'Criteria: $criteria',
                    ],
=======
            const SizedBox(height: 20),

            // Two-Column Section
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left Section: Informations Générales
                Expanded(
                  child: Container(
                    height: 200, // Fixed height
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.grey[900], // Dark grey background
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Informations Générales",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color:
                                  Colors.yellow, // Yellow text for visibility
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Localisation : Paris, France",
                            style: TextStyle(color: Colors.white), // White text
                          ),
                          Text(
                            "Division actuelle : Ligue 2",
                            style: TextStyle(color: Colors.white), // White text
                          ),
                          Text(
                            "Nombre de membres du staff : 15",
                            style: TextStyle(color: Colors.white), // White text
                          ),
                          Text(
                            "Stade officiel : Stade Charléty (20,000 places)",
                            style: TextStyle(color: Colors.white), // White text
                          ),
                          Text(
                            "Année de création : 1969",
                            style: TextStyle(color: Colors.white), // White text
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10), // Space between columns

                // Right Section: Statut de Recrutement
                Expanded(
                  child: Container(
                    height: 200, // Fixed height
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.grey[900], // Dark grey background
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Statut de Recrutement",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color:
                                  Colors.yellow, // Yellow text for visibility
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Recherche de joueurs ?  Oui",
                            style: TextStyle(color: Colors.white), // White text
                          ),
                          Text(
                            "Postes recherchés : Défenseur, Milieu, Attaquant",
                            style: TextStyle(color: Colors.white), // White text
                          ),
                          Text(
                            "Critères : U18, semi-pro, pro",
                            style: TextStyle(color: Colors.white), // White text
                          ),
                        ],
                      ),
                    ),
>>>>>>> 6cac91beaada61b3ffc53a7521518f9a73ed764c
                  ),
                ),
              ],
            ),
<<<<<<< HEAD
            const SizedBox(height: 24),
=======
            const SizedBox(height: 20),

            // Postuler Button
>>>>>>> 6cac91beaada61b3ffc53a7521518f9a73ed764c
            Center(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
<<<<<<< HEAD
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                ),
                child: const Text('APPLY'),
              ),
            ),
            const SizedBox(height: 24),
            const Text('Latest News', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.yellow)),
            const SizedBox(height: 8),
            Text(announcements, style: const TextStyle(color: Colors.white)),
            Text(events, style: const TextStyle(color: Colors.white)),
          ],
        ),
      ),
=======
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
                child: const Text("Postuler"),
              ),
            ),
            const SizedBox(height: 20),

            // Latest News
            const Text(
              "Dernières Nouvelles",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.yellow, // Yellow text for visibility
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Annonces officielles : Match contre Lyon ce samedi.",
              style: TextStyle(color: Colors.white), // White text
            ),
            const Text(
              "Prochains événements : Essais ouverts le 15 avril.",
              style: TextStyle(color: Colors.white), // White text
            ),
          ],
        ),
      ),
      // Bottom Navigation Bar
>>>>>>> 6cac91beaada61b3ffc53a7521518f9a73ed764c
      bottomNavigationBar: BottomNavbar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
<<<<<<< HEAD

  Widget _buildInfoCard({required String title, required List<String> children}) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.grey[900], borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.yellow)),
          const SizedBox(height: 8),
          ...children.map((c) => Text(c, style: const TextStyle(color: Colors.white))),
        ],
      ),
    );
  }
}

=======
}
>>>>>>> 6cac91beaada61b3ffc53a7521518f9a73ed764c
