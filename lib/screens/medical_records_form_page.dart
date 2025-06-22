import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MedicalRecordsForm extends StatefulWidget {
  final String? initialName;
  final String? initialAge;
  final String? initialGender;
  final String? initialContactInfo;
  final String? initialBloodType;
  final String? initialAllergies;
  final String? initialDOB;
  final String? initialEmergencyContact;
  final String? initialMedicalHistory;
  final String? initialMedications;
  final String? initialCurrentConditions;
  final String? initialPhone;
  final String? initialEmail;
  final String? initialSurgeries;
  final String? initialInsurance;
  final String? initialFamilyHistory;

  MedicalRecordsForm({
    this.initialName,
    this.initialAge,
    this.initialGender,
    this.initialContactInfo,
    this.initialBloodType,
    this.initialAllergies,
    this.initialDOB,
    this.initialEmergencyContact,
    this.initialMedicalHistory,
    this.initialMedications,
    this.initialCurrentConditions,
    this.initialPhone,
    this.initialEmail,
    this.initialSurgeries,
    this.initialInsurance,
    this.initialFamilyHistory,
  });

  @override
  _MedicalRecordsFormState createState() => _MedicalRecordsFormState();
}

class _MedicalRecordsFormState extends State<MedicalRecordsForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _contactInfoController = TextEditingController();
  final TextEditingController _bloodTypeController = TextEditingController();
  final TextEditingController _allergiesController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _emergencyContactController = TextEditingController();
  final TextEditingController _medicalHistoryController = TextEditingController();
  final TextEditingController _medicationsController = TextEditingController();
  final TextEditingController _currentConditionsController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _surgeriesController = TextEditingController();
  final TextEditingController _insuranceController = TextEditingController();
  final TextEditingController _familyHistoryController = TextEditingController();

  String? _selectedGender;
  final List<String> _bloodTypes = ['O+', 'O-', 'A+', 'A-', 'B+', 'B-', 'AB+', 'AB-'];

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.initialName ?? '';
    _ageController.text = widget.initialAge ?? '';
    _selectedGender = widget.initialGender;
    _contactInfoController.text = widget.initialContactInfo ?? '';
    _bloodTypeController.text = widget.initialBloodType ?? '';
    _allergiesController.text = widget.initialAllergies ?? '';
    _dobController.text = widget.initialDOB ?? '';
    _emergencyContactController.text = widget.initialEmergencyContact ?? '';
    _medicalHistoryController.text = widget.initialMedicalHistory ?? '';
    _medicationsController.text = widget.initialMedications ?? '';
    _currentConditionsController.text = widget.initialCurrentConditions ?? '';
    _phoneController.text = widget.initialPhone ?? '';
    _emailController.text = widget.initialEmail ?? '';
    _surgeriesController.text = widget.initialSurgeries ?? '';
    _insuranceController.text = widget.initialInsurance ?? '';
    _familyHistoryController.text = widget.initialFamilyHistory ?? '';
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      _dobController.text = DateFormat('MM/dd/yyyy').format(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Medical Records Form', style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xff1f597c),
      ),
      body: Container(
        color: Color(0xffbdd0d6),
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10)],
            ),
            child: Form(
              key: _formKey,
              child: Column(children: [
                _buildTextField(_nameController, 'Name'),
                _buildTextField(_ageController, 'Age', keyboard: TextInputType.number),
                _buildDropdownField('Gender', ['Male', 'Female', 'Other'], _selectedGender, (val) {
                  setState(() => _selectedGender = val);
                }),
                _buildTextField(_contactInfoController, 'Contact Info'),
                _buildDropdownField(
                  'Blood Type',
                  _bloodTypes,
                  _bloodTypes.contains(_bloodTypeController.text) ? _bloodTypeController.text : null,
                  (val) {
                    setState(() => _bloodTypeController.text = val ?? '');
                  },
                ),
                _buildTextField(_allergiesController, 'Allergies'),
                _buildDateField(_dobController, 'Date of Birth'),
                _buildTextField(_emergencyContactController, 'Emergency Contact'),
                _buildTextField(_medicalHistoryController, 'Medical History'),
                _buildTextField(_medicationsController, 'Medications'),
                _buildTextField(_currentConditionsController, 'Current Conditions'),
                _buildTextField(_phoneController, 'Phone'),
                _buildTextField(_emailController, 'Email'),
                _buildTextField(_surgeriesController, 'Surgeries'),
                _buildTextField(_insuranceController, 'Insurance'),
                _buildTextField(_familyHistoryController, 'Family History'),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.pop(context, {
                        'name': _nameController.text,
                        'age': _ageController.text,
                        'gender': _selectedGender,
                        'contactInfo': _contactInfoController.text,
                        'bloodType': _bloodTypeController.text,
                        'allergies': _allergiesController.text,
                        'dob': _dobController.text,
                        'emergencyContact': _emergencyContactController.text,
                        'medicalHistory': _medicalHistoryController.text,
                        'medications': _medicationsController.text,
                        'currentConditions': _currentConditionsController.text,
                        'phone': _phoneController.text,
                        'email': _emailController.text,
                        'surgeries': _surgeriesController.text,
                        'insurance': _insuranceController.text,
                        'familyHistory': _familyHistoryController.text,
                      });
                    }
                  },
                  child: Text('Save', style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(backgroundColor: Color(0xff1f597c)),
                )
              ]),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label,
      {TextInputType keyboard = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(labelText: label),
        keyboardType: keyboard,
        style: TextStyle(fontSize: 18),
      ),
    );
  }

  Widget _buildDropdownField(String label, List<String> items, String? value, Function(String?) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: DropdownButtonFormField<String>(
        value: items.contains(value) ? value : null,
        hint: Text(label),
        onChanged: onChanged,
        items: items.map((e) => DropdownMenuItem(child: Text(e), value: e)).toList(),
      ),
    );
  }

  Widget _buildDateField(TextEditingController controller, String label) {
    return GestureDetector(
      onTap: () => _selectDate(context),
      child: AbsorbPointer(
        child: _buildTextField(controller, label),
      ),
    );
  }
}
