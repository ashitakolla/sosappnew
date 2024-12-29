// lib/pagestosimulate/bleeding_page.dart
import 'package:flutter/material.dart';

class BleedingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bleeding'),
        backgroundColor: Color(0xff1f597c),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Bleeding First Aid Tips',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xff1f597c)),
            ),
            SizedBox(height: 16),
            Text(
              '1. Apply direct pressure on the wound using a clean cloth or bandage.',
              style: TextStyle(fontSize: 18, color: Color(0xff1f597c)),
            ),
            SizedBox(height: 8),
            Text(
              '2. If bleeding continues, apply more pressure and raise the limb (if possible) to slow blood flow.',
              style: TextStyle(fontSize: 18, color: Color(0xff1f597c)),
            ),
            SizedBox(height: 8),
            Text(
              '3. If the wound is severe, apply a tourniquet above the wound and seek emergency help.',
              style: TextStyle(fontSize: 18, color: Color(0xff1f597c)),
            ),
            SizedBox(height: 8),
            Text(
              '4. Keep the victim calm and reassure them while waiting for help to arrive.',
              style: TextStyle(fontSize: 18, color: Color(0xff1f597c)),
            ),
          ],
        ),
      ),
    );
  }
}
