import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _notificationsEnabled = true;
  bool _darkMode = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Settings', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text('Preferences', style: TextStyle(color: Colors.yellow, fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          SwitchListTile(
            title: const Text('Enable Notifications', style: TextStyle(color: Colors.white)),
            value: _notificationsEnabled,
            activeColor: Colors.yellow,
            onChanged: (val) => setState(() => _notificationsEnabled = val),
          ),
          SwitchListTile(
            title: const Text('Dark Mode', style: TextStyle(color: Colors.white)),
            value: _darkMode,
            activeColor: Colors.yellow,
            onChanged: (val) => setState(() => _darkMode = val),
          ),
          const SizedBox(height: 20),
          const Divider(color: Colors.grey),
          const SizedBox(height: 10),
          const Text('Account', style: TextStyle(color: Colors.yellow, fontSize: 18, fontWeight: FontWeight.bold)),
          ListTile(
            leading: const Icon(Icons.person, color: Colors.white),
            title: const Text('Edit Profile', style: TextStyle(color: Colors.white)),
            onTap: () => Navigator.pushNamed(context, '/edit_profile'),
          ),
          ListTile(
            leading: const Icon(Icons.lock, color: Colors.white),
            title: const Text('Change Password', style: TextStyle(color: Colors.white)),
            onTap: () => Navigator.pushNamed(context, '/change_password'),
          ),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.redAccent),
            title: const Text('Logout', style: TextStyle(color: Colors.redAccent)),
            onTap: () {
              // Add your logout logic
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
    );
  }
}
