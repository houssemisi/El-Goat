import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:supabase_flutter/supabase_flutter.dart';
import '../widgets/navbar/bottom_navbar.dart';
import '../screens/chat_page.dart';

class ScoutProfilePage extends StatefulWidget {
  const ScoutProfilePage({Key? key}) : super(key: key);

  @override
  _ScoutProfilePageState createState() => _ScoutProfilePageState();
}

class _ScoutProfilePageState extends State<ScoutProfilePage> {
  bool _loading = true;
  Map<String, dynamic>? _profile;

  @override
  void initState() {
    super.initState();
    _fetchProfile();
  }

  Future<void> _fetchProfile() async {
    final userId = Supabase.instance.client.auth.currentUser?.id;
    if (userId == null) {
      setState(() => _loading = false);
      return;
    }
    final response = await Supabase.instance.client
        .from('scout_profiles')
        .select()
        .eq('user_id', userId)
        .maybeSingle();
    setState(() {
      _profile = (response is Map<String, dynamic>) ? response : null;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    if (_profile == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Scout Profile')),
        body: const Center(child: Text('No profile data found.')),
      );
    }

    final data = _profile!;
    final name         = data['full_name'] as String? ?? '';
    final bio          = data['bio'] as String? ?? '';
    final country      = data['country'] as String? ?? '';
    final city         = data['city'] as String? ?? '';
    final level        = data['scouting_level'] as String? ?? '';
    final experience   = data['years_experience']?.toString() ?? '0';
    final lastSeen     = data['last_seen'] as String? ?? '';
    final followed     = (data['followed_players'] as List<dynamic>?)?.cast<String>() ?? [];

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
=======
import '../widgets/navbar/bottom_navbar.dart'; // Import the BottomNavbar widget

class ScoutProfilePage extends StatelessWidget {
  const ScoutProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
>>>>>>> 6cac91beaada61b3ffc53a7521518f9a73ed764c

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
<<<<<<< HEAD
        title: Text(name, style: const TextStyle(color: Colors.white)),
=======
        title: const Text(
          "Profil Scout",
          style: TextStyle(color: Colors.white),
        ),
>>>>>>> 6cac91beaada61b3ffc53a7521518f9a73ed764c
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.message, color: Colors.white),
            onPressed: () {
<<<<<<< HEAD
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ChatScreen(
                    otherUserId: data['user_id'] as String,
                    otherUserName: name,
                    otherUserImage: 'assets/images/scout.jpeg',
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
<<<<<<< HEAD
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Avatar & Basic Info
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/images/scout.jpeg'),
                  ),
                  const SizedBox(height: 12),
                  Text(name, style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 6),
                  Text('$country – $city', style: const TextStyle(color: Colors.grey)),
                  const SizedBox(height: 4),
                  Text('Last seen: $lastSeen', style: const TextStyle(color: Colors.greenAccent)),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Bio Section
            SectionCard(
              title: 'Bio',
              child: Text(bio, style: const TextStyle(color: Colors.white)),
            ),
            const SizedBox(height: 16),

            // Scouting Details
            Row(
              children: [
                Expanded(
                  child: SectionCard(
                    title: 'Level & Experience',
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Level: $level', style: const TextStyle(color: Colors.white)),
                        Text('Experience: $experience yrs', style: const TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: SectionCard(
                    title: 'Followed Players',
                    child: Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: followed.map((p) => Chip(label: Text(p))).toList(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Detection Criteria
            SectionCard(
              title: 'Detection Criteria',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Prefers: ${data['preferred_positions']?.join(', ') ?? ''}', style: const TextStyle(color: Colors.white)),
                  Text('Max Age: ${data['max_age'] ?? ''}', style: const TextStyle(color: Colors.white)),
                  Text('Level: ${data['target_level'] ?? ''}', style: const TextStyle(color: Colors.white)),
                  Text('Foot: ${data['preferred_foot'] ?? ''}', style: const TextStyle(color: Colors.white)),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Action Buttons
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ChatScreen(
                            otherUserId: data['user_id'] as String,
                            otherUserName: name,
                            otherUserImage: 'assets/images/scout.jpeg',
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Icons.message),
                    label: const Text('Message'),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.person_add),
                    label: const Text('Propose Player'),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.greenAccent),
                  ),
                ],
=======
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Header
            Center(
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage(
                        'assets/images/scout.jpeg'), // Replace with your image asset
                  ),
                  const SizedBox(height: 10),
                  Text(
                    args['name'] ?? 'Jean Dupont',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const Text(
                    "@ScoutJD",
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    args['bio'] ?? "No bio provided",
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "${args['city'] ?? 'Montréal'}, ${args['country'] ?? 'Canada'}",
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Map Section
            Container(
              height: 200,
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(
                child: Text(
                  "Carte interactive (à intégrer)",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // What I'm Looking For
            const Text(
              "Ce que je recherche",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.yellow,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "\"Ailiers rapides avec bonne vision de jeu & défenseurs centraux techniques (U15–U20).\"",
              style: TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 20),

            // Detection Criteria
            const Text(
              "Critères de détection",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.yellow,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Postes ciblés : Ailier, Défenseur central",
              style: TextStyle(color: Colors.white),
            ),
            const Text(
              "Âge max : 20 ans",
              style: TextStyle(color: Colors.white),
            ),
            const Text(
              "Niveau : Semi-pro à Pro",
              style: TextStyle(color: Colors.white),
            ),
            const Text(
              "Pied préféré : Droit / Gauche",
              style: TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 20),

            // Followed Players
            const Text(
              "Joueurs suivis",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.yellow,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              height: 100,
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(
                child: Text(
                  "Liste des joueurs suivis (à intégrer)",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Last Activity
            const Text(
              "Dernière activité",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.yellow,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Actif il y a 3h",
              style: TextStyle(color: Colors.white),
            ),
            const Text(
              "Dernière recherche : \"Tournoi U17 Québec\"",
              style: TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 20),

            // Contact Section
            const Text(
              "Contact",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.yellow,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                  ),
                  child: const Text("Envoyer un message"),
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                  ),
                  child: const Text("Proposer un joueur"),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Verified Identity
            const Center(
              child: Text(
                "Identité vérifiée – Club affilié confirmé",
                style: TextStyle(color: Colors.grey),
>>>>>>> 6cac91beaada61b3ffc53a7521518f9a73ed764c
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavbar(
<<<<<<< HEAD
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
=======
        selectedIndex: 3, // Set the selected index for the Scout Profile page
        onItemTapped: (index) {
          switch (index) {
            case 0:
              Navigator.pushNamed(context, '/');
              break;
            case 1:
              Navigator.pushNamed(context, '/stories');
              break;
            case 2:
              Navigator.pushNamed(context, '/news_home');
              break;
            case 3:
              // Stay on the current page
              break;
          }
        },
>>>>>>> 6cac91beaada61b3ffc53a7521518f9a73ed764c
      ),
    );
  }
}
<<<<<<< HEAD

/// Reusable card for sections
class SectionCard extends StatelessWidget {
  final String title;
  final Widget child;

  const SectionCard({Key? key, required this.title, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(color: Colors.yellow, fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          child,
        ],
      ),
    );
  }
}
=======
>>>>>>> 6cac91beaada61b3ffc53a7521518f9a73ed764c
