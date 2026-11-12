import 'package:flutter/material.dart';

import '../models/language.dart';

/// Shows the full details of ONE selected language.
class DetailScreen extends StatelessWidget {
  final Language language;

  const DetailScreen({super.key, required this.language});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(language.name),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      // SingleChildScrollView lets the page scroll in landscape mode
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Banner image loaded from the assets folder
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                language.image,
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
                // Placeholder if the image cannot be loaded
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 200,
                  color: Colors.grey.shade300,
                  child: const Center(
                    child: Icon(Icons.broken_image, size: 60),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              language.name,
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // Card holding all labeled information
            Card(
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _InfoRow(
                        icon: Icons.person,
                        label: 'Creator',
                        value: language.creator),
                    _InfoRow(
                        icon: Icons.calendar_today,
                        label: 'Year Released',
                        value: language.year.toString()),
                    _InfoRow(
                        icon: Icons.category,
                        label: 'Type',
                        value: language.type),
                    _InfoRow(
                        icon: Icons.build,
                        label: 'Used For',
                        value: language.usedFor),
                    _InfoRow(
                        icon: Icons.description,
                        label: 'Description',
                        value: language.description),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Reusable row: icon + bold label + value text.
class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Theme.of(context).colorScheme.primary),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 14)),
                const SizedBox(height: 2),
                Text(value, style: const TextStyle(fontSize: 16)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
