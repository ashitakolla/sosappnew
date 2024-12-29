// lib/pagestosimulate/robbery_page.dart
import 'package:flutter/material.dart';

class RobberyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Robbery'),
        backgroundColor: Color(0xff1f597c),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Robbery Safety Tips',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xff1f597c)),
            ),
            SizedBox(height: 16),
            Text(
              '1. Stay calm and do not resist the robber.',
              style: TextStyle(fontSize: 18, color: Color(0xff1f597c)),
            ),
            SizedBox(height: 8),
            Text(
              '2. Comply with the robber’s demands and avoid making sudden movements.',
              style: TextStyle(fontSize: 18, color: Color(0xff1f597c)),
            ),
            SizedBox(height: 8),
            Text(
              '3. Observe and remember important details (e.g., appearance, clothing, weapon) without drawing attention.',
              style: TextStyle(fontSize: 18, color: Color(0xff1f597c)),
            ),
            SizedBox(height: 8),
            Text(
              '4. As soon as it is safe, call emergency services immediately.',
              style: TextStyle(fontSize: 18, color: Color(0xff1f597c)),
            ),
          ],
        ),
      ),
    );
  }
}
