import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:device_preview/device_preview.dart';
import 'screens/home_page.dart' hide NewsPage;
import 'screens/news_page.dart';
import 'screens/news_home_page.dart';
import 'screens/accueil_page.dart';
import 'screens/registration_page.dart';
import 'screens/login.dart';
import 'screens/stories_page.dart';
import 'theme/app_theme.dart';

void main() {
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
        '/news': (context) => const NewsPage(), // Add NewsPage route
        '/news_home': (context) =>
            NewsHomePage(toggleTheme: () {}), // Add NewsHomePage route
        '/stories': (context) => const StoriesPage(),
        '/registration': (context) => const RegistrationPage(),
        '/login': (context) => const LoginPage(),
        '/accueil': (context) => const AcceuilPage(), // Add AccueilPage route
      },
      builder: DevicePreview.appBuilder,
      locale: DevicePreview.locale(context),
    );
  }
}
