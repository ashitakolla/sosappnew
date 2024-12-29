// lib/pagestosimulate/self_defense_page.dart
import 'package:flutter/material.dart';

class SelfDefensePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Self-defense Techniques'),
        backgroundColor: Color(0xff1f597c),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Self-defense Techniques',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xff1f597c)),
            ),
            SizedBox(height: 16),
            Text(
              '1. Use your surroundings: Utilize objects around you to defend yourself (e.g., keys, bags).',
              style: TextStyle(fontSize: 18, color: Color(0xff1f597c)),
            ),
            SizedBox(height: 8),
            Text(
              '2. Strike vulnerable areas: Aim for the eyes, nose, throat, and groin to disable the attacker.',
              style: TextStyle(fontSize: 18, color: Color(0xff1f597c)),
            ),
            SizedBox(height: 8),
            Text(
              '3. Create distance: If possible, run to a safe location and call for help.',
              style: TextStyle(fontSize: 18, color: Color(0xff1f597c)),
            ),
            SizedBox(height: 8),
            Text(
              '4. Use self-defense training: If you have prior training, apply techniques to disable the attacker and escape.',
              style: TextStyle(fontSize: 18, color: Color(0xff1f597c)),
            ),
          ],
        ),
      ),
    );
  }
}
