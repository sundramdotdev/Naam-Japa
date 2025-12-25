import 'package:flutter/material.dart';

class LeaderboardPage extends StatelessWidget {
  const LeaderboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Leaderboard")),
      body: ListView(
        children: const [
          ListTile(
            leading: CircleAvatar(child: Text("1")),
            title: Text("Devotee A"),
            trailing: Text("10,234"),
          ),
          ListTile(
            leading: CircleAvatar(child: Text("2")),
            title: Text("Devotee B"),
            trailing: Text("8,980"),
          ),
        ],
      ),
    );
  }
}
