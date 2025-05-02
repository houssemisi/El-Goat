import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../widgets/navbar/bottom_navbar.dart';
import '../screens/chat_page.dart';

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

class ClubProfilePage extends StatefulWidget {
  const ClubProfilePage({Key? key}) : super(key: key);

  @override
  State<ClubProfilePage> createState() => _ClubProfilePageState();
}

class _ClubProfilePageState extends State<ClubProfilePage> {
  int _selectedIndex = 0;

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
        Navigator.pushNamed(context, '/news_reels');
        break;
      case 3:
        Navigator.pushNamed(context, '/profile');
        break;
    }
  }

  Future<String> getCurrentUserRole() async {
    final userId = Supabase.instance.client.auth.currentUser!.id;

    final scout = await Supabase.instance.client
        .from('scout_profiles')
        .select()
        .eq('user_id', userId)
        .maybeSingle();
    if (scout != null) return 'scout';

    final footballer = await Supabase.instance.client
        .from('footballer_profiles')
        .select()
        .eq('user_id', userId)
        .maybeSingle();
    if (footballer != null) return 'footballer';

    final club = await Supabase.instance.client
        .from('club_profiles')
        .select()
        .eq('user_id', userId)
        .maybeSingle();
    if (club != null) return 'club';

    return 'normal';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "Profil du Club",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          FutureBuilder<String>(
            future: getCurrentUserRole(),
            builder: (context, snapshot) {
              if (!snapshot.hasData || snapshot.data == 'normal') return const SizedBox();
              return IconButton(
                icon: const Icon(Icons.message, color: Colors.white),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ChatScreen(
                        otherUserId: 'RECEIVER_ID_HERE',
                        otherUserName: 'Receiver Name',
                        otherUserImage: 'assets/images/player1.jpeg',
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/images/club_logo.jpeg'),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Paris FC",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  const SizedBox(height: 5),
                  const Text("25 joueurs sous contrat", style: TextStyle(color: Colors.grey)),
                  const Text("5 titres remportés", style: TextStyle(color: Colors.grey)),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Color.fromARGB(255, 2, 75, 235),
                    ),
                    child: const Text("S’ABONNER"),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    height: 200,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.grey[900],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text("Informations Générales", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.yellow)),
                          SizedBox(height: 10),
                          Text("Localisation : Paris, France", style: TextStyle(color: Colors.white)),
                          Text("Division actuelle : Ligue 2", style: TextStyle(color: Colors.white)),
                          Text("Nombre de membres du staff : 15", style: TextStyle(color: Colors.white)),
                          Text("Stade officiel : Stade Charléty (20,000 places)", style: TextStyle(color: Colors.white)),
                          Text("Année de création : 1969", style: TextStyle(color: Colors.white)),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Container(
                    height: 200,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.grey[900],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text("Statut de Recrutement", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.yellow)),
                          SizedBox(height: 10),
                          Text("Recherche de joueurs ?  Oui", style: TextStyle(color: Colors.white)),
                          Text("Postes recherchés : Défenseur, Milieu, Attaquant", style: TextStyle(color: Colors.white)),
                          Text("Critères : U18, semi-pro, pro", style: TextStyle(color: Colors.white)),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
                child: const Text("Postuler"),
              ),
            ),
            const SizedBox(height: 20),
            const Text("Dernières Nouvelles", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.yellow)),
            const SizedBox(height: 10),
            const Text("Annonces officielles : Match contre Lyon ce samedi.", style: TextStyle(color: Colors.white)),
            const Text("Prochains événements : Essais ouverts le 15 avril.", style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavbar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
