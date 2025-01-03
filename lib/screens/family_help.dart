import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'add_contact_page.dart' as contact_page; // Aliased import for AddContactPage
import 'add_medication_page.dart' as medication_page; // Aliased import for AddMedicationPage

class FamilyHelpPage extends StatefulWidget {
  @override
  _FamilyHelpPageState createState() => _FamilyHelpPageState();
}

class _FamilyHelpPageState extends State<FamilyHelpPage> {
  List<Map<String, String>> contacts = [];
  List<Map<String, String>> medications = [];
  bool isLoading = true;
  bool isContactDropdownOpen = false; // To toggle the contacts dropdown visibility
  bool isMedicationDropdownOpen = false; // To toggle the medications dropdown visibility

  @override
  void initState() {
    super.initState();
    _fetchContacts();
    _fetchMedications();
  }

  // Fetch contacts from the server
  Future<void> _fetchContacts() async {
    const String baseUrl = 'http://192.168.142.249:5000';
    try {
      final response = await http.get(Uri.parse('$baseUrl/contacts'));

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        setState(() {
          contacts = data
              .map((contact) => {
                    'name': contact['name'].toString(),
                    'number': contact['phone'].toString(),
                  })
              .toList();
          isLoading = false;
        });
      } else {
        print('Failed to fetch contacts: ${response.body}');
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      print('Error fetching contacts: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  // Fetch medications from the server
  Future<void> _fetchMedications() async {
    const String baseUrl = 'http://192.168.1.6:5000';
    try {
      final response = await http.get(Uri.parse('$baseUrl/medications'));

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        setState(() {
          medications = data
              .map((medication) => {
                    'name': medication['name'].toString(),
                    'dosage': medication['dosage'].toString(),
                    'time': medication['time'].toString(),
                  })
              .toList();
        });
      } else {
        print('Failed to fetch medications: ${response.body}');
      }
    } catch (e) {
      print('Error fetching medications: $e');
    }
  }

  // Function to make a phone call
  Future<void> _makePhoneCall(String phoneNumber) async {
    final status = await Permission.phone.status;

    if (status.isGranted) {
      final Uri launchUri = Uri(
        scheme: 'tel',
        path: phoneNumber,
      );
      await launchUrl(launchUri);
    } else {
      if (await Permission.phone.request().isGranted) {
        final Uri launchUri = Uri(
          scheme: 'tel',
          path: phoneNumber,
        );
        await launchUrl(launchUri);
      } else {
        print('Phone call permission denied');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Family Help',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color(0xff1f597c),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : contacts.isEmpty && medications.isEmpty
              ? Center(child: Text('No contacts or medications found.'))
              : Container(
                  color: Color(0xfff0f8ff),
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Add Contact Button
                      ElevatedButton(
                        onPressed: () {
                          // Navigate to Add Contact Page
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => contact_page.AddContactPage()), // Using alias here
                          ).then((_) {
                            // Refresh the contact list when returning
                            _fetchContacts();
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xff1f597c),
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          'Add Contact',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      SizedBox(height: 20),
                      // Dropdown for Saved Contacts
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isContactDropdownOpen = !isContactDropdownOpen;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                          decoration: BoxDecoration(
                            color: Color(0xff1f597c),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Saved Contacts',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                              Icon(
                                isContactDropdownOpen
                                    ? Icons.arrow_drop_up
                                    : Icons.arrow_drop_down,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (isContactDropdownOpen)
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 5)],
                          ),
                          child: Container(
                            height: 300, // Set a fixed height to make the contacts scrollable
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  // List of Contacts
                                  for (var contact in contacts)
                                    ListTile(
                                      title: Text(
                                        contact['name']!,
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xff1f597c),
                                        ),
                                      ),
                                      subtitle: Text(contact['number']!),
                                      trailing: IconButton(
                                        icon: Icon(Icons.call),
                                        color: Color(0xff1f597c),
                                        onPressed: () {
                                          _makePhoneCall(contact['number']!);
                                        },
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      SizedBox(height: 20),
                      // Add Medication Button
                      ElevatedButton(
                        onPressed: () {
                          // Navigate to Add Medication Page
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => medication_page.AddMedicationPage()), // Using alias here
                          ).then((_) {
                            // Refresh the medication list when returning
                            _fetchMedications();
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xff1f597c),
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          'Add Medication',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      SizedBox(height: 20),
                      // Dropdown for Saved Medications
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isMedicationDropdownOpen = !isMedicationDropdownOpen;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                          decoration: BoxDecoration(
                            color: Color(0xff1f597c),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Saved Medications',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                              Icon(
                                isMedicationDropdownOpen
                                    ? Icons.arrow_drop_up
                                    : Icons.arrow_drop_down,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (isMedicationDropdownOpen)
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 5)],
                          ),
                          child: Container(
                            height: 300, // Set a fixed height to make the medications scrollable
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  // List of Medications
                                  for (var medication in medications)
                                    ListTile(
                                      title: Text(
                                        medication['name']!,
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xff1f597c),
                                        ),
                                      ),
                                      subtitle: Text('${medication['dosage']} | ${medication['time']}'),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
    );
  }
}
