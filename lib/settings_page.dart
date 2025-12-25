import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  final VoidCallback onReset;

  const SettingsPage({super.key, required this.onReset});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final TextEditingController _japaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadSavedJapaName();
  }

  // 🔹 Load saved name
  Future<void> loadSavedJapaName() async {
    final prefs = await SharedPreferences.getInstance();
    _japaController.text = prefs.getString('japa_name') ?? "सीताराम";
  }

  // 🔹 Save name
  Future<void> saveJapaName() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('japa_name', _japaController.text.trim());
    // ignore: use_build_context_synchronously
    Navigator.pop(context, true); // 👈 notify home page
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Settings")),
      body: ListView(
        children: [
          // 🔥 NEW: Custom Japa Name Section
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Japa Text (Naam)",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _japaController,
                  decoration: const InputDecoration(
                    hintText: "सीताराम / राधे / कृष्ण",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: saveJapaName,
                    child: const Text("Save Name"),
                  ),
                ),
              ],
            ),
          ),

          const Divider(),

          // 🔄 Existing Reset Counter (UNCHANGED)
          ListTile(
            leading: const Icon(Icons.refresh),
            title: const Text("Reset Counter"),
            onTap: widget.onReset,
          ),

          const Divider(),

          // 🚧 Coming soon (UNCHANGED)
          const ListTile(
            leading: Icon(Icons.vibration),
            title: Text("Vibration (Coming Soon)"),
          ),
          const ListTile(
            leading: Icon(Icons.dark_mode),
            title: Text("Dark Mode (Coming Soon)"),
          ),
        ],
      ),
    );
  }
}
