import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddMedicationPage extends StatefulWidget {
  @override
  _AddMedicationPageState createState() => _AddMedicationPageState();
}

class _AddMedicationPageState extends State<AddMedicationPage> {
  final _nameController = TextEditingController();
  final _dosageController = TextEditingController();
  TimeOfDay _selectedTime = TimeOfDay.now();

  final _formKey = GlobalKey<FormState>();

  // Function to pick time
  Future<void> _pickTime() async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (pickedTime != null) {
      setState(() {
        _selectedTime = pickedTime;
      });
    }
  }

  // Function to add medication
  Future<void> _addMedication() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    const String baseUrl = 'http://192.168.1.6:5000/medications';
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': _nameController.text,
          'dosage': _dosageController.text, // Adding dosage field
          'time': _selectedTime.format(context), // Adjusted for API compatibility
        }),
      );

      if (response.statusCode == 201) {
        // Navigate back or show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Medication added successfully!')),
        );
        Navigator.pop(context);
      } else {
        // Display server-side error
        final errorResponse = jsonDecode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorResponse['error'] ?? 'Failed to add medication')),
        );
      }
    } catch (e) {
      // Handle client-side errors
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Medication'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Medication Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter medication name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _dosageController,
                decoration: InputDecoration(labelText: 'Dosage'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter dosage';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              Text('Time: ${_selectedTime.format(context)}'),
              ElevatedButton(
                onPressed: _pickTime,
                child: Text('Pick Time'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _addMedication,
                child: Text('Add Medication'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
