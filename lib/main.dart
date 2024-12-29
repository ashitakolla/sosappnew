import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// Import screens
import 'screens/welcome_page.dart';
import 'screens/features_button_page.dart' as featuresButtonPage;  // Alias to resolve ambiguity
import 'screens/emergency_guide.dart';
import 'screens/emergency_training.dart';
import 'screens/kit_checklist.dart';
import 'screens/local_service.dart';
import 'screens/family_help.dart';
import 'screens/medical_records_page.dart'; // Import the Medical Records screen
import 'screens/ash_chatbot.dart' as ashChatbot;  // Alias to resolve ambiguity
import 'screens/dialogs.dart';  // Import DialogPage

// Initialize Flutter Local Notifications
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Notification settings
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  const DarwinInitializationSettings initializationSettingsIOS =
      DarwinInitializationSettings();
  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsIOS,
  );

  // Initialize notifications plugin
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  runApp(MyApp());
}

// HTTP API functions
Future<void> addContact(String name, String phone) async {
  final response = await http.post(
    Uri.parse('http://192.168.1.6:5000/contacts'), // Ensure the IP address is correct and server is running
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
    throw Exception('Failed to add contact');
  }
}

Future<void> addMedication(String name, String dosage, String time) async {
  final response = await http.post(
    Uri.parse('http://192.168.1.6:5000/medications'), // Ensure the IP address is correct and server is running
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
    throw Exception('Failed to add medication');
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SOS App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => WelcomePage(),
        '/feature_buttons': (context) => featuresButtonPage.FeatureButtonsPage(),  // Use alias
        '/emergency_guide': (context) => EmergencyGuidePage(),
        '/simulations': (context) => SimulationsPage(),
        '/kit_checklist': (context) => KitChecklistPage(),
        '/local_services': (context) => LocalServicesPage(),
        '/family_help': (context) => FamilyHelpPage(),
        '/medical_records': (context) => MedicalRecordsPage(), // Added Medical Records route
        '/chatbot': (context) => ashChatbot.AshChatbot(),  // Use alias
        '/dialog': (context) => DialogPage(),  // Added dialog route
      },
    );
  }
}
