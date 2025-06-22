import 'package:flutter/material.dart';
import '../services/user_session.dart';
import '../models/user.dart';

class EmergencyIdPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final User user = UserSession().currentUser;

    return Scaffold(
      appBar: AppBar(title: Text("Emergency ID")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Card(
          elevation: 6,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(user.name, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                Text("Blood Group: ${user.bloodGroup}"),
                Text("Emergency Contact: ${user.emergencyContact}"),
                Text("Phone: ${user.phone}"),
                Text("Address: ${user.address}"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
