import 'package:flutter/material.dart';
import '../widgets/navbar/bottom_navbar.dart'; // Import the BottomNavbar widget

class ScoutProfilePage extends StatelessWidget {
  const ScoutProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          IconButton(
            icon: const Icon(Icons.message, color: Colors.white),
            onPressed: () {
              Navigator.pushNamed(context, '/chat'); // Navigate to ChatScreen
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
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
                  const Text(
                    "Jean Dupont",
                    style: TextStyle(
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
                  const Text(
                    "FC Montréal – Recruteur Principal",
                    style: TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Montréal, Québec, Canada",
                    style: TextStyle(color: Colors.grey),
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
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavbar(
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
      ),
    );
  }
}
