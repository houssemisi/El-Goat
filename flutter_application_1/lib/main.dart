import 'package:flutter/material.dart';
import 'home_page.dart';
import 'news_page.dart';
import 'stories_page.dart';
import 'registration_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/news': (context) => const NewsPage(),
        '/stories': (context) => const StoriesPage(),
        '/registration': (context) => const RegistrationPage(),
      },
    );
  }
}
