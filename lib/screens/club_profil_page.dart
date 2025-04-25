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

class ClubProfilePage extends StatefulWidget {
  const ClubProfilePage({Key? key}) : super(key: key);

  @override
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
    }
  }

  @override
  Widget build(BuildContext context) {
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
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color.fromARGB(255, 2, 75, 235),
                    ),
                    child: const Text("S’ABONNER"),
                  ),
                ],
              ),
            ),
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
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Postuler Button
            Center(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
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
      bottomNavigationBar: BottomNavbar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
