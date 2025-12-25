import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'floating_text.dart';

class HomePage extends StatefulWidget {
  final Function(int) onCountChanged;

  const HomePage({super.key, required this.onCountChanged});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int count = 0;       // japa count (0–108)
  int malaCount = 0;  // mala count
  int lifetimeJapa = 0;   // lifetime japa
  int lifetimeMala = 0;   // lifetime mala
  List<FloatingText> floatingTexts = [];

  // 🔥 User custom japa text
  String japaText = "सीताराम";

  @override
  void initState() {
    super.initState();
    loadData();
  }

  // 🔹 Load saved data
  Future<void> loadData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      count = prefs.getInt('japa_count') ?? 0;
      malaCount = prefs.getInt('mala_count') ?? 0;
      lifetimeJapa = prefs.getInt('lifetime_japa') ?? 0;
      lifetimeMala = prefs.getInt('lifetime_mala') ?? 0;
      japaText = prefs.getString('japa_name') ?? "सीताराम";
    });
  }

  // 🔹 Save data
  Future<void> saveData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('japa_count', count);
    await prefs.setInt('mala_count', malaCount);
    await prefs.setInt('lifetime_japa', lifetimeJapa);
    await prefs.setInt('lifetime_mala', lifetimeMala);
  }

  void onTapScreen(TapDownDetails details) {
  setState(() {
    // current japa
    count++;

    // lifetime japa
    lifetimeJapa++;

    // 108 = 1 mala
    if (count >= 108) {
      count = 0;
      malaCount++;
      lifetimeMala++;
    }

    saveData();

    floatingTexts.add(
      FloatingText(
        text: japaText,
        position: details.globalPosition,
      ),
    );
  });
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTapDown: onTapScreen,
        child: Stack(
          children: [
            /// 🌈 Gradient Background
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFFFFE0B2),
                    Color(0xFFFFCC80),
                    Color(0xFFFFAB40),
                  ],
                ),
              ),
            ),

            /// 🕉 Center Japa Text
            Center(
              child: Text(
                japaText,
                style: TextStyle(
                  fontSize: 72,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepOrange.shade700,
                ),
              ),
            ),

            /// 🔢 Japa + Mala Counter
            Positioned(
              top: 50,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 22,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.75),
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "Japa : $count / 108",
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.deepOrange,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Mala : $malaCount",
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.brown,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            /// ✨ Floating Texts
            ...floatingTexts,
          ],
        ),
      ),
    );
  }
}
