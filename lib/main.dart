import 'package:flutter/material.dart';
import 'home_page.dart';
import 'stats_page.dart';
import 'leaderboard_page.dart';
import 'settings_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Radha Naam Japa',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var currentIndex = 0;
  int todayCount = 0;
  int totalCount = 0;

  void updateCount(int count) {
    setState(() {
      todayCount = count;
      totalCount++;
    });
  }

  void resetCounter() {
    setState(() {
      todayCount = 0;
    });
  }

  late final pages = [
    HomePage(onCountChanged: updateCount),
    const StatsPage(),
    const LeaderboardPage(),
    SettingsPage(onReset: resetCounter),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        selectedItemColor: Colors.deepOrange,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() => currentIndex = index);
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: "Stats",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.emoji_events),
            label: "Rank",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Settings",
          ),
        ],
      ),
    );
  }
}
