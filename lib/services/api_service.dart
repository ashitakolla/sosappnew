import 'dart:convert';
import 'package:http/http.dart' as http;

// Replace with your backend API base URL
const String baseUrl = 'http://192.168.142.249:5000';

// Function to add a contact
Future<void> addContact(String name, String phone) async {
  try {
    final response = await http.post(
      Uri.parse('$baseUrl/contacts'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name': name,
        'phone': phone,
      }),
    );

    if (response.statusCode == 201) {
      print('Contact added successfully');
    } else {
      print('Failed to add contact: ${response.statusCode} ${response.body}');
    }
  } catch (e) {
    print('Error occurred while adding contact: $e');
  }
}

// Function to add a medication
Future<void> addMedication(String name, String dosage, String time) async {
  try {
    final response = await http.post(
      Uri.parse('$baseUrl/medications'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name': name,
        'dosage': dosage,
        'time': time,
      }),
    );

    if (response.statusCode == 201) {
      print('Medication added successfully');
    } else {
      print('Failed to add medication: ${response.statusCode} ${response.body}');
    }
  } catch (e) {
    print('Error occurred while adding medication: $e');
  }
}

// Function to get all contacts
Future<List<dynamic>> getContacts() async {
  try {
    final response = await http.get(Uri.parse('$baseUrl/contacts'));

    if (response.statusCode == 200) {
      List<dynamic> contacts = jsonDecode(response.body);
      return contacts;
    } else {
      print('Failed to retrieve contacts: ${response.statusCode} ${response.body}');
      return [];
    }
  } catch (e) {
    print('Error occurred while retrieving contacts: $e');
    return [];
  }
}

// Function to get all medications
Future<List<dynamic>> getMedications() async {
  try {
    final response = await http.get(Uri.parse('$baseUrl/medications'));

    if (response.statusCode == 200) {
      List<dynamic> medications = jsonDecode(response.body);
      return medications;
    } else {
      print('Failed to retrieve medications: ${response.statusCode} ${response.body}');
      return [];
    }
  } catch (e) {
    print('Error occurred while retrieving medications: $e');
    return [];
  }
}

// Function to update a medication
Future<void> updateMedication(String medicationId, {String? name, String? dosage, String? time}) async {
  try {
    final Map<String, dynamic> body = {};
    if (name != null) body['name'] = name;
    if (dosage != null) body['dosage'] = dosage;
    if (time != null) body['time'] = time;

    final response = await http.put(
      Uri.parse('$baseUrl/medications/$medicationId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      print('Medication updated successfully');
    } else {
      print('Failed to update medication: ${response.statusCode} ${response.body}');
    }
  } catch (e) {
    print('Error occurred while updating medication: $e');
  }
}

// Function to delete a medication
Future<void> deleteMedication(String medicationId) async {
  try {
    final response = await http.delete(
      Uri.parse('$baseUrl/medications/$medicationId'),
    );

    if (response.statusCode == 200) {
      print('Medication deleted successfully');
    } else {
      print('Failed to delete medication: ${response.statusCode} ${response.body}');
    }
  } catch (e) {
    print('Error occurred while deleting medication: $e');
  }
}
