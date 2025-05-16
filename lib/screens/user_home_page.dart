import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../widgets/navbar/bottom_navbar.dart';
import '../screens/profile_page.dart';

class UserHomePage extends StatefulWidget {
  const UserHomePage({super.key});

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  int _selectedIndex = 0;
  final SupabaseClient supabase = Supabase.instance.client;

  late Future<List<Map<String, dynamic>>> _featuredPlayers;
  late Future<List<Map<String, dynamic>>> _newsArticles;
  late Future<List<Map<String, dynamic>>> _reels;

  @override
  void initState() {
    super.initState();
    _featuredPlayers = fetchFeaturedPlayers();
    _newsArticles = fetchNewsArticles();
    _reels = fetchReels();
  }

  Future<List<Map<String, dynamic>>> fetchFeaturedPlayers() async {
    final response = await supabase
        .from('footballer_profiles')
        .select('id, name, avatar_url, club, position')
        .limit(10)
        .order('created_at', ascending: false);
    return List<Map<String, dynamic>>.from(response);
  }

  Future<List<Map<String, dynamic>>> fetchNewsArticles() async {
    final response = await supabase
        .from('news_articles')
        .select('title, image_url, published_at')
        .order('published_at', ascending: false)
        .limit(5);
    return List<Map<String, dynamic>>.from(response);
  }

  Future<List<Map<String, dynamic>>> fetchReels() async {
    final response = await supabase
        .from('reels')
        .select('media_url, posted_by, type')
        .order('created_at', ascending: true)
        .limit(5);
    return List<Map<String, dynamic>>.from(response);
  }

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          children: [
            // 🔝 Welcome & Actions
            const Text(
              "Welcome Back 👋",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.search),
                  label: const Text("Recherche Personnalisée"),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blueGrey[700]),
                ),
                const SizedBox(width: 10),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.emoji_events),
                  label: const Text("Gamification"),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.orange[700]),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // 📘 Explore Stories
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/stories');
              },
              child: Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.deepPurpleAccent,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Center(
                  child: Text(
                    "✨ Explore Success Stories",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),

            // 🌟 Featured Players
            const Text(
              "🔥 Featured Players",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 12),
            FutureBuilder<List<Map<String, dynamic>>>(
              future: _featuredPlayers,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }

                if (snapshot.hasError || (snapshot.data?.isEmpty ?? true)) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Center(
                      child: Text(
                        "No players to show right now.",
                        style: TextStyle(color: Colors.white54),
                      ),
                    ),
                  );
                }

                final players = snapshot.data!;
                return SizedBox(
                  height: 110,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: players.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 16),
                    itemBuilder: (context, index) {
                      final p = players[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const FootballerProfilePage(),
                            ),
                          );
                        },
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 35,
                              backgroundImage: p['avatar_url'] != null
                                  ? NetworkImage(p['avatar_url'])
                                  : const AssetImage("assets/images/club_logo.jpeg")
                                      as ImageProvider,
                            ),
                            const SizedBox(height: 6),
                            Text(
                              p['name'] ?? '',
                              style: const TextStyle(color: Colors.white70),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                );
              },
            ),
            const SizedBox(height: 30),

            // 🗞 Latest News
            const Text(
              "🗞 Latest News",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 12),
            FutureBuilder<List<Map<String, dynamic>>>(
              future: _newsArticles,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                final news = snapshot.data!;
                return Column(
                  children: news.map((article) {
                    return ListTile(
                      contentPadding: const EdgeInsets.symmetric(vertical: 6),
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: Image.network(
                          article['image_url'] ?? '',
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text(article['title'] ?? '',
                          style: const TextStyle(color: Colors.white)),
                      subtitle: Text(article['published_at'] ?? '',
                          style: const TextStyle(color: Colors.white38)),
                    );
                  }).toList(),
                );
              },
            ),
            const SizedBox(height: 30),

            // 🎬 Latest Reels
            const Text(
              "🎥 Latest Reels",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 12),
            FutureBuilder<List<Map<String, dynamic>>>(
              future: _reels,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                final reels = snapshot.data!;
                return SizedBox(
                  height: 120,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: reels.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 12),
                    itemBuilder: (context, index) {
                      final reel = reels[index];
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          reel['media_url'] ?? '',
                          width: 120,
                          height: 120,
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  ),
                );
              },
            ),
            const SizedBox(height: 30),
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
