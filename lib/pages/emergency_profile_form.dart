import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/emergency_profile.dart';

class EmergencyProfileForm extends StatefulWidget {
  @override
  _EmergencyProfileFormState createState() => _EmergencyProfileFormState();
}

class _EmergencyProfileFormState extends State<EmergencyProfileForm> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String bloodType = '';
  String allergies = '';
  String medicalConditions = '';
  String emergencyContact = '';

  Future<void> saveProfile() async {
    final profile = EmergencyProfile(
      name: name,
      bloodType: bloodType,
      allergies: allergies,
      medicalConditions: medicalConditions,
      emergencyContact: emergencyContact,
    );

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('emergencyProfile', profile.toJson().toString());

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Profile saved successfully!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Emergency Health Profile'),
        backgroundColor: Color(0xff1f597c),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'Name'),
                  onSaved: (value) => name = value!,
                  validator: (value) => value!.isEmpty ? 'Please enter your name' : null,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Blood Type'),
                  onSaved: (value) => bloodType = value!,
                  validator: (value) => value!.isEmpty ? 'Please enter your blood type' : null,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Allergies'),
                  onSaved: (value) => allergies = value!,
                  validator: (value) => value!.isEmpty ? 'Please list any allergies' : null,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Medical Conditions'),
                  onSaved: (value) => medicalConditions = value!,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Emergency Contact'),
                  onSaved: (value) => emergencyContact = value!,
                  validator: (value) => value!.isEmpty ? 'Please enter an emergency contact' : null,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      saveProfile();
                    }
                  },
                  child: Text('Save Profile'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
