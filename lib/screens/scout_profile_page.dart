import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../widgets/navbar/bottom_navbar.dart';
import '../screens/chat_page.dart'; // Make sure the path is correct

class ScoutProfilePage extends StatelessWidget {
  const ScoutProfilePage({Key? key}) : super(key: key);

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

    return 'normal'; // fallback role
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final viewedUserId = args['userId'] ?? 'unknown-user-id';
    final viewedUserName = args['name'] ?? 'Scout';
    final viewedUserImage = 'assets/images/scout.jpeg';

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "Profil Scout",
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
                        otherUserId: viewedUserId,
                        otherUserName: viewedUserName,
                        otherUserImage: viewedUserImage,
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
                    backgroundImage: AssetImage('assets/images/scout.jpeg'),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    viewedUserName,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  const Text("@ScoutJD", style: TextStyle(color: Colors.grey)),
                  const SizedBox(height: 5),
                  Text(args['bio'] ?? "No bio provided", style: const TextStyle(color: Colors.grey)),
                  const SizedBox(height: 10),
                  Text(
                    "${args['city'] ?? 'Montréal'}, ${args['country'] ?? 'Canada'}",
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              height: 200,
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(
                child: Text("Carte interactive (à intégrer)", style: TextStyle(color: Colors.white)),
              ),
            ),
            const SizedBox(height: 20),
            const Text("Ce que je recherche", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.yellow)),
            const SizedBox(height: 10),
            const Text(
              "\"Ailiers rapides avec bonne vision de jeu & défenseurs centraux techniques (U15–U20).\"",
              style: TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 20),
            const Text("Critères de détection", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.yellow)),
            const SizedBox(height: 10),
            const Text("Postes ciblés : Ailier, Défenseur central", style: TextStyle(color: Colors.white)),
            const Text("Âge max : 20 ans", style: TextStyle(color: Colors.white)),
            const Text("Niveau : Semi-pro à Pro", style: TextStyle(color: Colors.white)),
            const Text("Pied préféré : Droit / Gauche", style: TextStyle(color: Colors.white)),
            const SizedBox(height: 20),
            const Text("Joueurs suivis", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.yellow)),
            const SizedBox(height: 10),
            Container(
              height: 100,
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(
                child: Text("Liste des joueurs suivis (à intégrer)", style: TextStyle(color: Colors.white)),
              ),
            ),
            const SizedBox(height: 20),
            const Text("Dernière activité", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.yellow)),
            const SizedBox(height: 10),
            const Text("Actif il y a 3h", style: TextStyle(color: Colors.white)),
            const Text("Dernière recherche : \"Tournoi U17 Québec\"", style: TextStyle(color: Colors.white)),
            const SizedBox(height: 20),
            const Text("Contact", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.yellow)),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.white, foregroundColor: Colors.black),
                  child: const Text("Envoyer un message"),
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.white, foregroundColor: Colors.black),
                  child: const Text("Proposer un joueur"),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Center(
              child: Text("Identité vérifiée – Club affilié confirmé", style: TextStyle(color: Colors.grey)),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavbar(
        selectedIndex: 3,
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
              break;
          }
        },
      ),
    );
  }
}
