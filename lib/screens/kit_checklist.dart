import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class KitChecklistPage extends StatefulWidget {
  @override
  _KitChecklistPageState createState() => _KitChecklistPageState();
}

class _KitChecklistPageState extends State<KitChecklistPage> {
  final _customItemController = TextEditingController();
  final _otherFieldController = TextEditingController();
  String? _selectedKitType = 'Travel'; // Default value
  bool _isCustomItemAdded = false;

  // Sample predefined kit items
  final List<String> kitItems = [
    "First Aid Kit",
    "Bandages",
    "Pain Relievers",
    "Antiseptic Cream",
    "Thermometer",
    "Syringe",
    "Alcohol Pads",
  ];

  // Function to handle form submission
  Future<void> _submitChecklist() async {
    // ignore: unnecessary_null_comparison
    List<String> selectedItems =
        // ignore: unnecessary_null_comparison
        kitItems.where((item) => item != null).toList();

    if (_isCustomItemAdded && _customItemController.text.isNotEmpty) {
      selectedItems.add(_customItemController.text);
    }

    if (_selectedKitType == 'Other' && _otherFieldController.text.isNotEmpty) {
      selectedItems.add('Other: ' + _otherFieldController.text);
    }

    // Example POST request (replace the URL with your actual backend endpoint)
    const String baseUrl = 'http://192.168.1.8:5000/submit-kit-checklist';
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'kitType': _selectedKitType,
          'items': selectedItems,
        }),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Checklist submitted successfully!')),
        );
        Navigator.pop(context);
      } else {
        final errorResponse = jsonDecode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
                  Text(errorResponse['error'] ?? 'Failed to submit checklist')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kit Checklist'),
      ),
      body: SingleChildScrollView(
        // Makes the entire page scrollable
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Kit Type Selection (Travel, Trek, Other)
            Text('Category:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Row(
              children: [
                Expanded(
                  child: RadioListTile<String>(
                    title: Text('Travel'),
                    value: 'Travel',
                    groupValue: _selectedKitType,
                    onChanged: (value) {
                      setState(() {
                        _selectedKitType = value;
                      });
                    },
                  ),
                ),
                Expanded(
                  child: RadioListTile<String>(
                    title: Text('Trek'),
                    value: 'Trek',
                    groupValue: _selectedKitType,
                    onChanged: (value) {
                      setState(() {
                        _selectedKitType = value;
                      });
                    },
                  ),
                ),
                Expanded(
                  child: RadioListTile<String>(
                    title: Text('Other:'),
                    value: 'Other',
                    groupValue: _selectedKitType,
                    onChanged: (value) {
                      setState(() {
                        _selectedKitType = value;
                      });
                    },
                  ),
                ),
              ],
            ),
            // "Other" category specification
            if (_selectedKitType == 'Other') ...[
              TextFormField(
                controller: _otherFieldController,
                decoration: InputDecoration(
                  labelText: 'Specify Other Details',
                ),
              ),
              SizedBox(height: 4), // Reduced space here
            ],

            // Predefined Kit Items
            Text('Predefined Kit Items:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Column(
              children: kitItems.map((item) {
                return CheckboxListTile(
                  title: Text(item),
                  value: false, // Add logic for actual state if needed
                  onChanged: (bool? value) {},
                );
              }).toList(),
            ),
            SizedBox(height: 8), // Reduced space here

            // Add Custom Item Input
            TextFormField(
              controller: _customItemController,
              decoration: InputDecoration(
                labelText: 'Add Custom Item',
              ),
              onChanged: (text) {
                setState(() {
                  _isCustomItemAdded = text.isNotEmpty;
                });
              },
            ),
            SizedBox(height: 16), // Reduced space here

            // Submit Button
            ElevatedButton(
              onPressed: _submitChecklist,
              child: Text('Submit Checklist'),
            ),
          ],
        ),
      ),
    );
  }
}
