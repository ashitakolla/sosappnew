import 'package:flutter/material.dart';
import 'medical_records_form_page.dart'; // Import the form page

class MedicalRecordsPage extends StatefulWidget {
  @override
  _MedicalRecordsPageState createState() => _MedicalRecordsPageState();
}

class _MedicalRecordsPageState extends State<MedicalRecordsPage> {
  String name = '';
  String age = '';
  String gender = '';
  String contactInfo = '';
  String profilePicture = 'assets/profile.jpg'; // Assuming you have an image in assets
  String bloodType = '';
  String allergies = '';
  String dob = '';
  String emergencyContact = '';
  String medicalHistory = '';
  String medications = '';
  String currentConditions = '';

  // Method to navigate to the edit form and get updated data
  void _editMedicalRecords() async {
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

    // If updated records are not null, update the state with the new data
    if (updatedRecords != null) {
      setState(() {
        bloodType = updatedRecords['bloodType'] ?? '';
        allergies = updatedRecords['allergies'] ?? '';
        dob = updatedRecords['dob'] ?? '';
        emergencyContact = updatedRecords['emergencyContact'] ?? '';
        medicalHistory = updatedRecords['medicalHistory'] ?? '';
        medications = updatedRecords['medications'] ?? '';
        currentConditions = updatedRecords['currentConditions'] ?? '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff1f597c),
        title: Text(
          'Medical Records',
          style: TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: Color(0xffbdd0d6),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Patient Details Section
            Row(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage(profilePicture),
                ),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Name: $name', style: TextStyle(fontSize: 18)),
                    Text('Age: $age', style: TextStyle(fontSize: 18)),
                    Text('Gender: $gender', style: TextStyle(fontSize: 18)),
                    Text('Contact Info: $contactInfo', style: TextStyle(fontSize: 18)),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),

            // Medical Records Section
            Text(
              'Medical Records:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xff1f597c),
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
                backgroundColor: Colors.white,
                foregroundColor: Color(0xff1f597c),
              ),
              child: Text('Edit Medical Records'),
            ),
          ],
        ),
      ),
    );
  }
}
