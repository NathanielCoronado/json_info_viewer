import 'package:flutter/material.dart';

import '../models/language.dart';
import '../services/data_service.dart';
import 'detail_screen.dart';

/// Main screen: loads the JSON data and shows each record as a card.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Holds the result of loading the JSON file
  late Future<List<Language>> _languagesFuture;

  @override
  void initState() {
    super.initState();
    // Load the JSON file once when the screen opens
    _languagesFuture = DataService.loadLanguages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Programming Languages'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      // FutureBuilder waits for the data, then rebuilds the screen
      body: FutureBuilder<List<Language>>(
        future: _languagesFuture,
        builder: (context, snapshot) {
          // STATE 1: still loading -> show a spinner
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // STATE 2: error -> show an error message
          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.error_outline,
                        color: Colors.red, size: 60),
                    const SizedBox(height: 12),
                    Text(
                      'Failed to load data.\n${snapshot.error}',
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          }

          // STATE 3: data is ready -> show the list
          final languages = snapshot.data ?? [];

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: languages.length,
            itemBuilder: (context, index) {
              final language = languages[index];

              // One Card per language
              return Card(
                elevation: 3,
                margin: const EdgeInsets.symmetric(vertical: 6),
                child: ListTile(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  // Local image from the assets folder
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      language.image,
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover, // fills the box, crops extra parts
                      // Shows the first letter if the image fails to load
                      errorBuilder: (context, error, stackTrace) =>
                          CircleAvatar(child: Text(language.name[0])),
                    ),
                  ),
                  title: Text(
                    language.name,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                      'Created by ${language.creator}\nReleased: ${language.year}'),
                  isThreeLine: true,
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  // Open the detail screen and pass the selected language
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            DetailScreen(language: language),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
