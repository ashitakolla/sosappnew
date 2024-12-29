import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/emergency_profile.dart';

class EmergencyProfileDisplay extends StatelessWidget {
  Future<EmergencyProfile?> loadProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final profileString = prefs.getString('emergencyProfile');

    if (profileString != null) {
      final profileJson = Map<String, dynamic>.from(json.decode(profileString));
      return EmergencyProfile.fromJson(profileJson);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Emergency Profile'),
        backgroundColor: Color(0xff1f597c),
      ),
      body: FutureBuilder<EmergencyProfile?>(
        future: loadProfile(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: Text('No profile data found.'));
          }

          final profile = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Name: ${profile.name}', style: TextStyle(fontSize: 18)),
                Text('Blood Type: ${profile.bloodType}', style: TextStyle(fontSize: 18)),
                Text('Allergies: ${profile.allergies}', style: TextStyle(fontSize: 18)),
                Text('Medical Conditions: ${profile.medicalConditions}', style: TextStyle(fontSize: 18)),
                Text('Emergency Contact: ${profile.emergencyContact}', style: TextStyle(fontSize: 18)),
              ],
            ),
          );
        },
      ),
    );
  }
}
