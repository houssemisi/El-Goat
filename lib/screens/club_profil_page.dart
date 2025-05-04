// lib/screens/club_profile_page.dart
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../widgets/navbar/bottom_navbar.dart';

class ClubProfilePage extends StatefulWidget {
  const ClubProfilePage({Key? key}) : super(key: key);

  @override
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
    }
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
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                    ),
                    child: const Text('SUBSCRIBE'),
                  ),
                ],
              ),
            ),
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
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Center(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
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
      bottomNavigationBar: BottomNavbar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }

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

