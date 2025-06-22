import 'package:flutter/material.dart';
import 'medical_records_form_page.dart'; // Your form page

class MedicalRecordsPage extends StatefulWidget {
  @override
  _MedicalRecordsPageState createState() => _MedicalRecordsPageState();
}

class _MedicalRecordsPageState extends State<MedicalRecordsPage> {
  // Full Medical Record Fields
  String name = '';
  String age = '';
  String gender = '';
  String dob = '';
  String phone = '';
  String email = '';
  String emergencyContact = '';
  String bloodType = '';
  String allergies = '';
  String medications = '';
  String currentConditions = '';
  String medicalHistory = '';
  String surgeries = '';
  String insurance = '';
  String familyHistory = '';

  // Navigate to edit form and retrieve updated info
  void _editMedicalRecords() async {
    final updatedRecords = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MedicalRecordsForm(
          initialName: name,
          initialAge: age,
          initialGender: gender,
          initialDOB: dob,
          initialPhone: phone,
          initialEmail: email,
          initialEmergencyContact: emergencyContact,
          initialBloodType: bloodType,
          initialAllergies: allergies,
          initialMedications: medications,
          initialCurrentConditions: currentConditions,
          initialMedicalHistory: medicalHistory,
          initialSurgeries: surgeries,
          initialInsurance: insurance,
          initialFamilyHistory: familyHistory,
        ),
      ),
    );

    if (updatedRecords != null) {
      setState(() {
        name = updatedRecords['name'] ?? '';
        age = updatedRecords['age'] ?? '';
        gender = updatedRecords['gender'] ?? '';
        dob = updatedRecords['dob'] ?? '';
        phone = updatedRecords['phone'] ?? '';
        email = updatedRecords['email'] ?? '';
        emergencyContact = updatedRecords['emergencyContact'] ?? '';
        bloodType = updatedRecords['bloodType'] ?? '';
        allergies = updatedRecords['allergies'] ?? '';
        medications = updatedRecords['medications'] ?? '';
        currentConditions = updatedRecords['currentConditions'] ?? '';
        medicalHistory = updatedRecords['medicalHistory'] ?? '';
        surgeries = updatedRecords['surgeries'] ?? '';
        insurance = updatedRecords['insurance'] ?? '';
        familyHistory = updatedRecords['familyHistory'] ?? '';
      });
    }
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, bottom: 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Color(0xff1f597c),
        ),
      ),
    );
  }

  Widget _buildInfoText(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Text(
        '$label: ${value.isNotEmpty ? value : "Not Provided"}',
        style: TextStyle(fontSize: 16),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff1f597c),
        title: Text('Medical Records', style: TextStyle(color: Colors.white)),
      ),
      backgroundColor: Color(0xffe6eff1),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Personal Information'),
            _buildInfoText('Name', name),
            _buildInfoText('Age', age),
            _buildInfoText('Gender', gender),
            _buildInfoText('Date of Birth', dob),

            _buildSectionTitle('Contact Information'),
            _buildInfoText('Phone', phone),
            _buildInfoText('Email', email),
            _buildInfoText('Emergency Contact', emergencyContact),

            _buildSectionTitle('Medical Information'),
            _buildInfoText('Blood Type', bloodType),
            _buildInfoText('Allergies', allergies),
            _buildInfoText('Current Medications', medications),
            _buildInfoText('Current Conditions', currentConditions),
            _buildInfoText('Medical History', medicalHistory),
            _buildInfoText('Surgeries / Treatments', surgeries),
            _buildInfoText('Insurance Info', insurance),
            _buildInfoText('Family Medical History', familyHistory),

            SizedBox(height: 30),
            Center(
              child: ElevatedButton.icon(
                onPressed: _editMedicalRecords,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff1f597c),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                icon: Icon(Icons.edit),
                label: Text('Edit Medical Records'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
