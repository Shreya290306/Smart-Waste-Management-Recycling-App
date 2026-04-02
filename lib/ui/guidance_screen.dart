import 'package:flutter/material.dart';

class GuidanceScreen extends StatelessWidget {
  const GuidanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: const [
        Text('Proper Disposal Guides', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        SizedBox(height: 20),
        _GuideCard(
          title: 'Organic Waste',
          icon: Icons.eco,
          color: Colors.green,
          description: 'Food scraps, yard waste, and other biodegradable materials. Best used for composting. Ensure no plastics are mixed in.',
        ),
        SizedBox(height: 10),
        _GuideCard(
          title: 'Plastic Waste',
          icon: Icons.recycling,
          color: Colors.blue,
          description: 'Recyclable plastics (PET, HDPE). Clean and dry them before disposal. Flatten bottles to save space.',
        ),
        SizedBox(height: 10),
        _GuideCard(
          title: 'E-Waste',
          icon: Icons.computer,
          color: Colors.red,
          description: 'Old electronics, batteries, and appliances. Do not throw in regular bins as they contain hazardous materials. Bring to designated centers.',
        ),
      ],
    );
  }
}

class _GuideCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final String description;

  const _GuideCard({required this.title, required this.icon, required this.color, required this.description});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: color.withAlpha(50), shape: BoxShape.circle),
              child: Icon(icon, color: color, size: 40),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text(description),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
