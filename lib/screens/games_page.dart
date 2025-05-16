import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../widgets/navbar/bottom_navbar.dart';

enum GameStatusFilter { all, inProgress, completed }

class GamificationDashboard extends StatefulWidget {
  const GamificationDashboard({Key? key}) : super(key: key);

  @override
  State<GamificationDashboard> createState() => _GamificationDashboardState();
}

class _GamificationDashboardState extends State<GamificationDashboard>
    with SingleTickerProviderStateMixin {
  final supabase = Supabase.instance.client;
  int _selectedIndex = 0;

  Map<String, dynamic>? xpData;
  List<Map<String, dynamic>> missionsWithStatus = [];
  List<dynamic> achievements = [];
  List<dynamic> skills = [];
  int streakCount = 0;
  int rank = 0;
  GameStatusFilter _missionFilter = GameStatusFilter.all;

  @override
  void initState() {
    super.initState();
    _fetchGamificationData();
  }

  Future<void> _fetchGamificationData() async {
    final userId = supabase.auth.currentUser?.id;
    if (userId == null) return;

    try {
      final xpRes = await supabase
          .from('player_xp_progress')
          .select()
          .eq('player_id', userId)
          .maybeSingle();

      final badgeRes = await supabase
          .from('player_badges')
          .select()
          .eq('player_id', userId);

      final skillRes = await supabase
          .from('player_skills')
          .select()
          .eq('player_id', userId);

      final streakRes = await supabase
          .from('daily_streaks')
          .select('streak_count')
          .eq('player_id', userId)
          .maybeSingle();

      final rankRes = await supabase.rpc('get_player_rank', params: {'player_id_input': userId});

      final missions = await supabase
          .from('games')
          .select('*, player_games(status)')
          .eq('type', 'mission')
          .order('created_at');

      final List<Map<String, dynamic>> missionsFormatted = (missions as List<dynamic>)
          .map((item) {
            final game = item as Map<String, dynamic>;
            final statusList = game['player_games'] as List<dynamic>? ?? [];
            final status = statusList.isNotEmpty ? statusList[0]['status'] : 'not_started';
            return {
              ...game,
              'status': status,
            };
          }).toList();

      setState(() {
        xpData = xpRes;
        achievements = badgeRes;
        skills = skillRes;
        missionsWithStatus = missionsFormatted;
        streakCount = streakRes?['streak_count'] ?? 0;
        rank = rankRes ?? 0;
      });
    } catch (e) {
      debugPrint("Error fetching data: $e");
    }
  }

  Future<void> completeGame(Map<String, dynamic> game) async {
    final userId = supabase.auth.currentUser?.id;
    if (userId == null) return;

    await supabase.from('player_games').upsert({
      'player_id': userId,
      'game_id': game['id'],
      'status': 'completed',
      'completed_at': DateTime.now().toIso8601String(),
    });

    _fetchGamificationData(); // refresh data
  }

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
    const routes = ['/', '/stories', '/news_home', '/profile'];
    if (index < routes.length) Navigator.pushNamed(context, routes[index]);
  }

  Widget _buildMissionFilterChips() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: GameStatusFilter.values.map((filter) {
        String label = switch (filter) {
          GameStatusFilter.all => "All",
          GameStatusFilter.inProgress => "In Progress",
          GameStatusFilter.completed => "Completed",
        };
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: ChoiceChip(
            label: Text(label),
            selected: _missionFilter == filter,
            onSelected: (_) => setState(() => _missionFilter = filter),
          ),
        );
      }).toList(),
    );
  }

  List<Map<String, dynamic>> _filteredMissions() {
    return missionsWithStatus.where((m) {
      if (_missionFilter == GameStatusFilter.all) return true;
      return m['status'] == _missionFilter.name;
    }).toList();
  }

  Widget _buildMissionsList() {
    final filtered = _filteredMissions();
    if (filtered.isEmpty) {
      return const Center(
        child: Text("No missions found", style: TextStyle(color: Colors.white54)),
      );
    }

    return ListView.builder(
      itemCount: filtered.length,
      itemBuilder: (_, i) {
        final m = filtered[i];
        final status = m['status'];

        return Card(
          color: Colors.grey[850],
          child: ListTile(
            title: Text(m['title'], style: const TextStyle(color: Colors.white)),
            subtitle: Text(
              "${m['description']}\nXP: ${m['xp_reward']}",
              style: const TextStyle(color: Colors.white70),
            ),
            trailing: status == 'completed'
                ? const Icon(Icons.check_circle, color: Colors.green)
                : ElevatedButton(
                    onPressed: () => completeGame(m),
                    child: Text(status == 'in_progress' ? "Complete" : "Start"),
                  ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isLoggedIn = Supabase.instance.client.auth.currentUser != null;

    if (!isLoggedIn) {
      return const Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Text("Please log in to view your dashboard", style: TextStyle(color: Colors.white)),
        ),
      );
    }

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: const Text("El Goat: Player Dashboard"),
          backgroundColor: Colors.black,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildXPCard(),
              const SizedBox(height: 16),
              _buildStreakAndRank(),
              const SizedBox(height: 16),
              const TabBar(
                labelColor: Colors.white,
                unselectedLabelColor: Colors.white54,
                indicatorColor: Colors.amber,
                tabs: [
                  Tab(icon: Icon(Icons.emoji_events), text: 'Achievements'),
                  Tab(icon: Icon(Icons.flag), text: 'Missions'),
                  Tab(icon: Icon(Icons.star), text: 'Skills'),
                ],
              ),
              const SizedBox(height: 10),
              Expanded(
                child: TabBarView(
                  children: [
                    _buildList(achievements.map((b) => "🏅 ${b['badge_type']} - ${b['level']}").toList()),
                    Column(
                      children: [
                        _buildMissionFilterChips(),
                        const SizedBox(height: 8),
                        Expanded(child: _buildMissionsList()),
                      ],
                    ),
                    _buildList(skills.map((s) => "⚡ ${s['skill']}: ${s['level']}").toList()),
                  ],
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: BottomNavbar(
          selectedIndex: _selectedIndex,
          onItemTapped: _onItemTapped,
        ),
      ),
    );
  }

  Widget _buildXPCard() {
    final level = xpData?['level'] ?? 1;
    final currentXp = xpData?['current_xp'] ?? 0;
    final nextXp = xpData?['next_level_xp'] ?? 100;
    final progress = currentXp / nextXp;

    return Card(
      elevation: 2,
      color: Colors.grey[900],
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Level $level - ${_getLevelTitle(level)}",
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
            const SizedBox(height: 10),
            LinearProgressIndicator(
              value: progress.clamp(0.0, 1.0),
              backgroundColor: Colors.grey[800],
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.greenAccent),
              minHeight: 8,
            ),
            const SizedBox(height: 10),
            Text("XP: $currentXp / $nextXp", style: const TextStyle(color: Colors.white70)),
          ],
        ),
      ),
    );
  }

  Widget _buildStreakAndRank() {
    return Row(
      children: [
        Expanded(
          child: Card(
            color: Colors.grey[850],
            child: ListTile(
              leading: const Icon(Icons.local_fire_department, color: Colors.red),
              title: const Text("Daily Streak", style: TextStyle(color: Colors.white)),
              subtitle: Text("🔥 $streakCount Days", style: const TextStyle(color: Colors.white70)),
            ),
          ),
        ),
        Expanded(
          child: Card(
            color: Colors.grey[850],
            child: ListTile(
              leading: const Icon(Icons.leaderboard, color: Colors.blue),
              title: const Text("Weekly Rank", style: TextStyle(color: Colors.white)),
              subtitle: Text("#$rank Global", style: const TextStyle(color: Colors.white70)),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildList(List<String> items) {
    if (items.isEmpty) {
      return const Center(
        child: Text("Nothing to show yet", style: TextStyle(color: Colors.white54)),
      );
    }

    return ListView(
      children: items
          .map((e) => Card(
                color: Colors.grey[850],
                child: ListTile(
                  title: Text(e, style: const TextStyle(color: Colors.white)),
                ),
              ))
          .toList(),
    );
  }

  String _getLevelTitle(int level) {
    if (level < 5) return "Beginner";
    if (level < 10) return "Rising Star";
    if (level < 20) return "Elite Prospect";
    return "GOAT Mode";
  }
}
