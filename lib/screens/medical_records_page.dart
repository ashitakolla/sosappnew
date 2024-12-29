import 'package:flutter/material.dart';
import 'medical_records_form_page.dart'; // Import the form page

class MedicalRecordsPage extends StatefulWidget {
  @override
  _MedicalRecordsPageState createState() => _MedicalRecordsPageState();
}

class _MedicalRecordsPageState extends State<MedicalRecordsPage> {
  String bloodType = '';
  String allergies = '';
  String dob = '';
  String emergencyContact = '';
  String medicalHistory = '';
  String medications = '';
  String currentConditions = '';

  void _editMedicalRecords() async {
    // Navigate to the form page and get the updated values
    final updatedRecords = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MedicalRecordsForm(
          initialBloodType: bloodType,
          initialAllergies: allergies,
          initialDOB: dob,
          initialEmergencyContact: emergencyContact,
          initialMedicalHistory: medicalHistory,
          initialMedications: medications,
          initialCurrentConditions: currentConditions,
        ),
      ),
    );

    if (updatedRecords != null) {
      // Update the local state with the updated values
      setState(() {
        bloodType = updatedRecords['bloodType']!;
        allergies = updatedRecords['allergies']!;
        dob = updatedRecords['dob']!;
        emergencyContact = updatedRecords['emergencyContact']!;
        medicalHistory = updatedRecords['medicalHistory']!;
        medications = updatedRecords['medications']!;
        currentConditions = updatedRecords['currentConditions']!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff1f597c), // AppBar color (your color)
        title: Text(
          'Medical Records',
          style: TextStyle(
            color: Colors.white, // Text color in the AppBar
          ),
        ),
      ),
      backgroundColor: Color(0xffbdd0d6), // Background color for the entire page
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Medical Records:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xff1f597c), // Header text color matching AppBar
              ),
            ),
            SizedBox(height: 20),
            Text('Blood Type: $bloodType', style: TextStyle(fontSize: 18)),
            Text('Allergies: $allergies', style: TextStyle(fontSize: 18)),
            Text('Date of Birth: $dob', style: TextStyle(fontSize: 18)),
            Text('Emergency Contact: $emergencyContact', style: TextStyle(fontSize: 18)),
            Text('Medical History: $medicalHistory', style: TextStyle(fontSize: 18)),
            Text('Medications: $medications', style: TextStyle(fontSize: 18)),
            Text('Current Conditions: $currentConditions', style: TextStyle(fontSize: 18)),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: _editMedicalRecords,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white, // Button background color (white)
                foregroundColor: Color(0xff1f597c), // Text color for the button
              ),
              child: Text('Edit Medical Records'),
            ),
          ],
        ),
      ),
    );
  }
}
