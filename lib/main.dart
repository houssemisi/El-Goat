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
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      },
      builder: DevicePreview.appBuilder,
      locale: DevicePreview.locale(context),
    );
  }
}
