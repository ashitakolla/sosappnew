import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For Date formatting

class MedicalRecordsForm extends StatefulWidget {
  final String? initialBloodType;
  final String? initialAllergies;
  final String? initialDOB;
  final String? initialEmergencyContact;
  final String? initialMedicalHistory;
  final String? initialMedications;
  final String? initialCurrentConditions;

  MedicalRecordsForm({
    this.initialBloodType,
    this.initialAllergies,
    this.initialDOB,
    this.initialEmergencyContact,
    this.initialMedicalHistory,
    this.initialMedications,
    this.initialCurrentConditions,
  });

  @override
  _MedicalRecordsFormState createState() => _MedicalRecordsFormState();
}

class _MedicalRecordsFormState extends State<MedicalRecordsForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _bloodTypeController = TextEditingController();
  final TextEditingController _allergiesController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _emergencyContactController = TextEditingController();
  final TextEditingController _medicalHistoryController = TextEditingController();
  final TextEditingController _medicationsController = TextEditingController();
  final TextEditingController _currentConditionsController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _bloodTypeController.text = widget.initialBloodType ?? '';
    _allergiesController.text = widget.initialAllergies ?? '';
    _dobController.text = widget.initialDOB ?? '';
    _emergencyContactController.text = widget.initialEmergencyContact ?? '';
    _medicalHistoryController.text = widget.initialMedicalHistory ?? '';
    _medicationsController.text = widget.initialMedications ?? '';
    _currentConditionsController.text = widget.initialCurrentConditions ?? '';
  }

  // Date Picker Function for DOB
  Future<void> _selectDate(BuildContext context) async {
    DateTime currentDate = DateTime.now();
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: currentDate,
    );
    if (pickedDate != null && pickedDate != DateTime.now()) {
      setState(() {
        _dobController.text = DateFormat('MM/dd/yyyy').format(pickedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Medical Records'),
        
        backgroundColor: Color(0xff1f597c), // AppBar color matching MedicalRecordsPage
      ),
      body: Container(
        color: Color(0xffbdd0d6), // Background color matching MedicalRecordsPage
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Blood Type Picker
              DropdownButtonFormField<String>(
                value: _bloodTypeController.text.isNotEmpty
                    ? _bloodTypeController.text
                    : null,
                hint: Text('Select Blood Type'),
                onChanged: (String? newValue) {
                  setState(() {
                    _bloodTypeController.text = newValue!;
                  });
                },
                items: [
                  'O+', 'O-', 'A+', 'A-', 'B+', 'B-', 'AB+', 'AB-'
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),

              // Allergies Input
              TextFormField(
                controller: _allergiesController,
                decoration: InputDecoration(
                  labelText: 'Allergies',
                  labelStyle: TextStyle(color: Color.fromARGB(255, 0, 0, 0)), // Matching text color
                ),
              ),

              // Date of Birth Picker
              GestureDetector(
                onTap: () => _selectDate(context),
                child: AbsorbPointer(
                  child: TextFormField(
                    controller: _dobController,
                    decoration: InputDecoration(
                      labelText: 'Date of Birth',
                      hintText: 'MM/DD/YYYY',
                      labelStyle: TextStyle(color: Color.fromARGB(255, 0, 0, 0)), // Matching text color
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select your date of birth';
                      }
                      return null;
                    },
                  ),
                ),
              ),

              // Emergency Contact Input
              TextFormField(
                controller: _emergencyContactController,
                decoration: InputDecoration(
                  labelText: 'Emergency Contact',
                  labelStyle: TextStyle(color: Color.fromARGB(255, 0, 0, 0)), // Matching text color
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please provide an emergency contact';
                  }
                  return null;
                },
              ),

              // Medical History Input
              TextFormField(
                controller: _medicalHistoryController,
                decoration: InputDecoration(
                  labelText: 'Medical History',
                  labelStyle: TextStyle(color: Color.fromARGB(255, 0, 0, 0)), // Matching text color
                ),
              ),

              // Medications Input
              TextFormField(
                controller: _medicationsController,
                decoration: InputDecoration(
                  labelText: 'Medications',
                  labelStyle: TextStyle(color: Color.fromARGB(237, 0, 0, 0)), // Matching text color
                ),
              ),

              // Current Conditions Input
              TextFormField(
                controller: _currentConditionsController,
                decoration: InputDecoration(
                  labelText: 'Current Conditions',
                  labelStyle: TextStyle(color: Color.fromRGBO(0, 0, 0, 1)), // Matching text color
                ),
              ),

              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    // Handle form submission
                    final updatedBloodType = _bloodTypeController.text;
                    final updatedAllergies = _allergiesController.text;
                    final updatedDOB = _dobController.text;
                    final updatedEmergencyContact = _emergencyContactController.text;
                    final updatedMedicalHistory = _medicalHistoryController.text;
                    final updatedMedications = _medicationsController.text;
                    final updatedCurrentConditions = _currentConditionsController.text;

                    // Show a snackbar confirming the update
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Medical records updated')));

                    // Pass the updated values back to the previous screen
                    Navigator.pop(context, {
                      'bloodType': updatedBloodType,
                      'allergies': updatedAllergies,
                      'dob': updatedDOB,
                      'emergencyContact': updatedEmergencyContact,
                      'medicalHistory': updatedMedicalHistory,
                      'medications': updatedMedications,
                      'currentConditions': updatedCurrentConditions,
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff1f597c), // Button color matching MedicalRecordsPage
                ),
                child: Text('Save', style: TextStyle(color: Colors.white)), // White text color
              ),
            ],
          ),
        ),
      ),
    );
  }
}
