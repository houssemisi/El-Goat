// lib/screens/home_page.dart
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../widgets/navbar/bottom_navbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const Color _accent = Color(0xFFFFD600);
  int _selectedIndex = 0;
  String? _userName;
  String? _userEmail;

  @override
  void initState() {
    super.initState();
    final user = Supabase.instance.client.auth.currentUser;
    _userName = user?.userMetadata?['name'] ?? 'Guest';
    _userEmail = user?.email ?? '';
  }

  void _onNavTapped(int idx) async {
    setState(() => _selectedIndex = idx);
    if (idx == 3) {
      final userId = Supabase.instance.client.auth.currentUser?.id;
      if (userId == null) {
        Navigator.pushNamed(context, '/login_required');
        return;
      }
      final roleResponse = await Supabase.instance.client
          .from('user_roles')
          .select('role')
          .eq('user_id', userId)
          .maybeSingle();
      final role = roleResponse?['role'];
      if (role == null) {
        Navigator.pushNamed(context, '/login_required');
      } else {
        Navigator.pushNamed(context, '/${role}_profile');
      }
    } else {
      const routes = ['/', '/stories', '/news_home', '/profile'];
      if (idx < routes.length) Navigator.pushNamed(context, routes[idx]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      drawer: Drawer(
  child: Container(
    decoration: const BoxDecoration(
      gradient: LinearGradient(colors: [Colors.black87, Colors.black]),
    ),
    child: Column(
      children: [
        Expanded(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              UserAccountsDrawerHeader(
                decoration: const BoxDecoration(color: Colors.transparent),
                accountName: Text(_userName ?? '', style: const TextStyle(color: Colors.white)),
                accountEmail: Text(_userEmail ?? '', style: const TextStyle(color: Colors.white70)),
                currentAccountPicture: const CircleAvatar(
                  backgroundImage: AssetImage('assets/images/logo.png'),
                  backgroundColor: Colors.black,
                ),
              ),
              _drawerItem(Icons.home, 'Home', '/'),
              _drawerItem(Icons.book, 'Stories', '/stories'),
              _drawerItem(Icons.article, 'News', '/news_home'),
              ListTile(
                leading: const Icon(Icons.person, color: Colors.white),
                title: const Text('Profile', style: TextStyle(color: Colors.white)),
                onTap: () => _onNavTapped(3),
              ),
            ],
          ),
        ),
        const Divider(color: Colors.grey),
        ListTile(
          leading: const Icon(Icons.contact_mail, color: Colors.white),
          title: const Text('Contact', style: TextStyle(color: Colors.white)),
          onTap: () => Navigator.pushNamed(context, '/contact'),
        ),
        ListTile(
          leading: const Icon(Icons.settings, color: Colors.white),
          title: const Text('Settings', style: TextStyle(color: Colors.white)),
          onTap: () => Navigator.pushNamed(context, '/settings'),
        ),
      ],
    ),
  ),
),
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: Builder(
          builder: (ctx) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () => Scaffold.of(ctx).openDrawer(),
          ),
        ),
        title: Image.asset(
          'assets/images/logo.png',
          height: 40,
          fit: BoxFit.contain,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {
              showSearch(
                context: context,
                delegate: CustomSearchDelegate(),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                const Spacer(),
                TextButton(
                  onPressed: () => Navigator.pushNamed(context, '/login'),
                  child: const Text('Login', style: TextStyle(color: Colors.white)),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, '/registration'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _accent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  ),
                  child: const Text('Sign Up', style: TextStyle(color: Colors.black)),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _sectionTitle('Explore Stories'),
                  _horizontalScroll(5, 'assets/images/', '.jpg', (i) => 'Story ${i+1}'),
                  _sectionTitle('Join as'),
                  _roleRow(),
                  _sectionTitle('Featured Players'),
                  _horizontalScroll(8, 'assets/images/player', '.jpeg', (_) => ''),
                  _sectionTitle('Latest News'),
                  ...List.generate(3, (i) => ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                    leading: const Icon(Icons.article, color: Colors.white),
                    title: GestureDetector(
                      onTap: () => Navigator.pushNamed(context, '/news_home'),
                      child: Text('News Headline ${i+1}', style: const TextStyle(color: Colors.white)),
                    ),
                    subtitle: Text('Brief description…', style: TextStyle(color: Colors.grey[400])),
                    onTap: () => Navigator.pushNamed(context, '/news_detail', arguments: {'id': '$i'}),
                  )),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavbar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onNavTapped,
      ),
    );
  }

  ListTile _drawerItem(IconData icon, String text, String route) => ListTile(
    leading: Icon(icon, color: Colors.white),
    title: Text(text, style: const TextStyle(color: Colors.white)),
    onTap: () => Navigator.pushReplacementNamed(context, route),
  );

  Widget _sectionTitle(String title) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: Text(title, style: TextStyle(color: _accent, fontSize: 20, fontWeight: FontWeight.bold)),
  );

  Widget _horizontalScroll(int count, String path, String ext, String Function(int) label) => SizedBox(
    height: 120,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: count,
      itemBuilder: (_, i) => Container(
        margin: const EdgeInsets.only(right: 12),
        width: 80,
        child: Column(
          children: [
            CircleAvatar(radius: 32, backgroundImage: AssetImage('$path${i+1}$ext')),
            const SizedBox(height: 6),
            Text(label(i), style: const TextStyle(color: Colors.white, fontSize: 12), overflow: TextOverflow.ellipsis),
          ],
        ),
      ),
    ),
  );

  Widget _roleRow() => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Row(
      children: [
        _RoleCard(icon: Icons.sports_soccer, label: 'Footballer', onTap: () => Navigator.pushNamed(context, '/registration')),
        const SizedBox(width: 12),
        _RoleCard(icon: Icons.search, label: 'Scout', onTap: () => Navigator.pushNamed(context, '/registration')),
        const SizedBox(width: 12),
        _RoleCard(icon: Icons.business, label: 'Club', onTap: () => Navigator.pushNamed(context, '/registration')),
      ],
    ),
  );
}

class CustomSearchDelegate extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () => query = '',
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(child: Text(query));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ListView(children: const []);
  }
}

class _RoleCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _RoleCard({Key? key, required this.icon, required this.label, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 36, color: Colors.white),
              const SizedBox(height: 8),
              Text(label, style: const TextStyle(color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }
}