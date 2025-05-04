<<<<<<< HEAD
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:device_preview/device_preview.dart';

import 'screens/home_page.dart';
import 'screens/news_home_page.dart';
import 'screens/stories_page.dart';
import 'screens/news_reels_page.dart';
import 'screens/registration_page.dart';
import 'screens/login.dart';
import 'screens/accueil_page.dart';
import 'screens/profile_page.dart';
import 'screens/scout_profile_page.dart';
import 'screens/club_profil_page.dart';
import 'screens/chat_page.dart';
import 'screens/games_page.dart';
import 'screens/clubsigup_page.dart';
import 'screens/scoutsignup_page.dart';
import 'screens/footballersignup_page.dart';
import 'screens/favorites_page.dart';
import 'screens/notifications_page.dart';
import 'screens/ratings_page.dart';
import 'theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://nwmfqbvxdhcgawxfvhsg.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im53bWZxYnZ4ZGhjZ2F3eGZ2aHNnIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDU2NjAyMDcsImV4cCI6MjA2MTIzNjIwN30.U0hCS3Q9oWaAGKBhmFHvAGU_ZeLMR6Wh0nvTFBBtoMQ',
  );

  AppLifecycleReactor().start();

  runApp(
    DevicePreview(
      enabled: kDebugMode,
      builder: (_) => const MyApp(),
    ),
  );
}

class AppLifecycleReactor with WidgetsBindingObserver {
  void start() => WidgetsBinding.instance.addObserver(this);

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _updateLastSeen();
    }
  }

  Future<void> _updateLastSeen() async {
    final userId = Supabase.instance.client.auth.currentUser?.id;
    if (userId == null) return;

    for (final table in [
      'footballer_profiles',
      'scout_profiles',
      'club_profiles',
    ]) {
      await Supabase.instance.client
          .from(table)
          .update({'last_seen': DateTime.now().toIso8601String()})
          .eq('user_id', userId);
    }
  }
=======
import 'package:firebase_core/firebase_core.dart';
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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(DevicePreview(
    enabled: !kReleaseMode,
    builder: (context) => const MyApp(),
  ));
>>>>>>> 6cac91beaada61b3ffc53a7521518f9a73ed764c
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
<<<<<<< HEAD
      title: 'El Goat',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
      initialRoute: '/',
      routes: {
        '/': (ctx) => const HomePage(),
        '/news_home': (ctx) => NewsHomePage(toggleTheme: () {}),
        '/stories': (ctx) => const StoriesPage(),
        '/news_reels': (ctx) => const NewsReelsPage(),
        '/registration': (ctx) => const RegistrationPage(),
        '/login': (ctx) => const LoginPage(),
        '/accueil': (ctx) => const AcceuilPage(),
        '/profile': (ctx) => FootballerProfilePage(
              userId: Supabase.instance.client.auth.currentUser!.id,
              userName: Supabase.instance.client.auth.currentUser!.userMetadata?['name'] ?? 'Unknown',
              userImage: Supabase.instance.client.auth.currentUser!.userMetadata?['image'] ?? '',
            ),
        '/scout_profile': (ctx) => const ScoutProfilePage(),
        '/club_profile': (ctx) => const ClubProfilePage(),
        '/chat': (ctx) => const ChatScreen(
              otherUserId: '',
              otherUserName: '',
              otherUserImage: '',
            ),
        '/games': (ctx) => const GamificationDashboard(),
        '/clubsignup': (ctx) => ClubSignUpPage(
              userId: Supabase.instance.client.auth.currentUser!.id,
            ),
        '/scoutsignup': (ctx) => ScoutSignUpPage(
              userId: Supabase.instance.client.auth.currentUser!.id,
            ),
        '/footballersignup': (ctx) => FootballerSignUpPage(
              userId: Supabase.instance.client.auth.currentUser!.id,
            ),
        '/favorites': (ctx) => const FavoritesPage(),
        '/notifications': (ctx) => const NotificationsPage(),
        '/ratings': (ctx) => const RatingsPage(),
=======
      title: 'Flutter Demo',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light, // Change to ThemeMode.dark for dark mode
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/news_home': (context) =>
            NewsHomePage(toggleTheme: () {}), // Add NewsHomePage route
        '/stories': (context) => const StoriesPage(),
        '/registration': (context) => const RegistrationPage(),
        '/login': (context) => const LoginPage(),
        '/accueil': (context) => const AcceuilPage(), // Add AccueilPage route
        '/news_reels': (context) => const NewsReelsPage(), // Add this route
        '/profile': (context) => ProfilePage(),
        '/club_profile': (context) => const ClubProfilePage(),
        '/scout_profile': (context) => const ScoutProfilePage(),
        '/chat': (context) => const ChatScreen(),
        '/games': (context) => const GamificationDashboard(),
        '/clubsigup': (context) => const ClubSignUpPage(),
        '/scoutsignup': (context) => const ScoutSignUpPage(),
>>>>>>> 6cac91beaada61b3ffc53a7521518f9a73ed764c
      },
      builder: DevicePreview.appBuilder,
      locale: DevicePreview.locale(context),
    );
  }
<<<<<<< HEAD
}
=======
}
>>>>>>> 6cac91beaada61b3ffc53a7521518f9a73ed764c
