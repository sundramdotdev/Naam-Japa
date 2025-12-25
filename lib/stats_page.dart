import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StatsPage extends StatefulWidget {
  const StatsPage({super.key});

  @override
  State<StatsPage> createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {
  int currentJapa = 0;
  int currentMala = 0;
  int lifetimeJapa = 0;
  int lifetimeMala = 0;

  @override
  void initState() {
    super.initState();
    loadStats();
  }

  Future<void> loadStats() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      currentJapa = prefs.getInt('japa_count') ?? 0;
      currentMala = prefs.getInt('mala_count') ?? 0;
      lifetimeJapa = prefs.getInt('lifetime_japa') ?? 0;
      lifetimeMala = prefs.getInt('lifetime_mala') ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Stats")),
      body: Column(
        children: [
          Expanded(
            child: statCard("Current Japa", "$currentJapa / 108"),
          ),
          Expanded(
            child: statCard("Current Mala", "$currentMala"),
          ),
          Expanded(
            child: statCard("Lifetime Japa", "$lifetimeJapa"),
          ),
          Expanded(
            child: statCard("Lifetime Mala", "$lifetimeMala"),
          ),
        ],
      ),
    );
  }

  Widget statCard(String title, String value) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFFFE0B2),
            Color(0xFFFFB74D),
          ],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.brown,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.deepOrange,
            ),
          ),
        ],
      ),
    );
  }
}
