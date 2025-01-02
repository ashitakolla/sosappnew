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
  final String? initialName;
  final String? initialAge;
  final String? initialGender;
  final String? initialContactInfo;

  MedicalRecordsForm({
    this.initialBloodType,
    this.initialAllergies,
    this.initialDOB,
    this.initialEmergencyContact,
    this.initialMedicalHistory,
    this.initialMedications,
    this.initialCurrentConditions,
    this.initialName,
    this.initialAge,
    this.initialGender,
    this.initialContactInfo,
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
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _contactInfoController = TextEditingController();
  String? _selectedGender;

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
    _nameController.text = widget.initialName ?? '';
    _ageController.text = widget.initialAge ?? '';
    _contactInfoController.text = widget.initialContactInfo ?? '';
    _selectedGender = widget.initialGender;
  }

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
        title: Text(
          'Medical Records Form',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color(0xff1f597c),
      ),
      body: Container(
        color: Color(0xffbdd0d6),
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 10,
                  ),
                ],
              ),
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // Name Input
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: 'Name',
                      ),
                      style: TextStyle(fontSize: 20),
                    ),

                    // Age Input
                    TextFormField(
                      controller: _ageController,
                      decoration: InputDecoration(
                        labelText: 'Age',
                      ),
                      keyboardType: TextInputType.number,
                      style: TextStyle(fontSize: 20),
                    ),

                    // Gender Dropdown
                    DropdownButtonFormField<String>(
                      value: _selectedGender,
                      hint: Text('Select Gender'),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedGender = newValue;
                        });
                      },
                      items: ['Male', 'Female', 'Other']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value, style: TextStyle(fontSize: 20)),
                        );
                      }).toList(),
                    ),

                    // Contact Info Input
                    TextFormField(
                      controller: _contactInfoController,
                      decoration: InputDecoration(
                        labelText: 'Contact Information',
                      ),
                      style: TextStyle(fontSize: 20),
                    ),

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
                      items: ['O+', 'O-', 'A+', 'A-', 'B+', 'B-', 'AB+', 'AB-']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value, style: TextStyle(fontSize: 20)),
                        );
                      }).toList(),
                    ),

                    // Allergies Input
                    TextFormField(
                      controller: _allergiesController,
                      decoration: InputDecoration(
                        labelText: 'Allergies',
                      ),
                      style: TextStyle(fontSize: 20),
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
                          ),
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),

                    // Emergency Contact Input
                    TextFormField(
                      controller: _emergencyContactController,
                      decoration: InputDecoration(
                        labelText: 'Emergency Contact',
                      ),
                      style: TextStyle(fontSize: 20),
                    ),

                    // Medical History Input
                    TextFormField(
                      controller: _medicalHistoryController,
                      decoration: InputDecoration(
                        labelText: 'Medical History',
                      ),
                      style: TextStyle(fontSize: 20),
                    ),

                    // Medications Input
                    TextFormField(
                      controller: _medicationsController,
                      decoration: InputDecoration(
                        labelText: 'Medications',
                      ),
                      style: TextStyle(fontSize: 20),
                    ),

                    // Current Conditions Input
                    TextFormField(
                      controller: _currentConditionsController,
                      decoration: InputDecoration(
                        labelText: 'Current Conditions',
                      ),
                      style: TextStyle(fontSize: 20),
                    ),

                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          final updatedName = _nameController.text;
                          final updatedAge = _ageController.text;
                          final updatedGender = _selectedGender;
                          final updatedContactInfo = _contactInfoController.text;
                          final updatedBloodType = _bloodTypeController.text;
                          final updatedAllergies = _allergiesController.text;
                          final updatedDOB = _dobController.text;
                          final updatedEmergencyContact = _emergencyContactController.text;
                          final updatedMedicalHistory = _medicalHistoryController.text;
                          final updatedMedications = _medicationsController.text;
                          final updatedCurrentConditions = _currentConditionsController.text;

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Medical records updated')),
                          );

                          Navigator.pop(context, {
                            'name': updatedName,
                            'age': updatedAge,
                            'gender': updatedGender,
                            'contactInfo': updatedContactInfo,
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
                        backgroundColor: Color(0xff1f597c),
                      ),
                      child: Text('Save', style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
