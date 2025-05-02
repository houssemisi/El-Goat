import 'package:firebase_core/firebase_core.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter_application_1/screens/chat_page.dart';
import 'package:flutter_application_1/screens/club_profil_page.dart';
import 'package:flutter_application_1/screens/games_page.dart';
import 'package:flutter_application_1/screens/profile_page.dart';
import 'package:flutter_application_1/screens/scout_profile_page.dart';
import 'screens/home_page.dart';
import 'screens/news_home_page.dart';
import 'screens/accueil_page.dart';
import 'screens/registration_page.dart';
import 'screens/login.dart';
import 'screens/stories_page.dart';
import 'screens/news_reels_page.dart';
import 'theme/app_theme.dart';
import '../screens/clubsigup_page.dart';
import '../screens/scoutsignup_page.dart';
import '../screens/footballersignup_page.dart';
import '../screens/favorites_page.dart';
import '../screens/notifications_page.dart';
import '../screens/ratings_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://nwmfqbvxdhcgawxfvhsg.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im53bWZxYnZ4ZGhjZ2F3eGZ2aHNnIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDU2NjAyMDcsImV4cCI6MjA2MTIzNjIwN30.U0hCS3Q9oWaAGKBhmFHvAGU_ZeLMR6Wh0nvTFBBtoMQ',
  );

  final response = await Supabase.instance.client
      .from('users')
      .select()
      .limit(1);
  print(response);

  AppLifecycleReactor().start();

  runApp(MyApp());
}

class AppLifecycleReactor with WidgetsBindingObserver {
  void start() {
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _updateLastSeen();
    }
  }

  Future<void> _updateLastSeen() async {
    final userId = Supabase.instance.client.auth.currentUser?.id;
    if (userId == null) return;

    for (final table in ['footballer_profiles', 'scout_profiles', 'club_profiles']) {
      await Supabase.instance.client
          .from(table)
          .update({'last_seen': DateTime.now().toIso8601String()})
          .eq('user_id', userId);
    }
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/news_home': (context) => NewsHomePage(toggleTheme: () {}),
        '/stories': (context) => const StoriesPage(),
        '/registration': (context) => const RegistrationPage(),
        '/login': (context) => const LoginPage(),
        '/accueil': (context) => const AcceuilPage(),
        '/news_reels': (context) => const NewsReelsPage(),
        '/profile': (context) => FootballerProfilePage(
              userId: '12345',
              userName: 'John Doe',
              userImage: 'https://example.com/image.jpg',
            ),
        '/club_profile': (context) => const ClubProfilePage(),
        '/scout_profile': (context) => const ScoutProfilePage(),
        '/chat': (context) => ChatScreen(
              otherUserId: '12345',
              otherUserName: 'John Doe',
              otherUserImage: 'https://example.com/image.jpg',
            ),
        '/games': (context) => const GamificationDashboard(),
        '/clubsigup': (context) => ClubSignUpPage(userId: '12345'),
        '/scoutsignup': (context) => ScoutSignUpPage(userId: '12345'),
        '/footballersignup': (context) => FootballerSignUpPage(userId: '12345'),
        '/favorites': (context) => const FavoritesPage(),
        '/notifications': (context) => const NotificationsPage(),
        '/ratings': (context) => const RatingsPage(),
      },
      builder: DevicePreview.appBuilder,
      locale: DevicePreview.locale(context),
    );
  }
}
