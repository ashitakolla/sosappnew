import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

class LocalServicesPage extends StatelessWidget {
  final List<Map<String, String>> services = [
    {
      'name': 'Police',
      'number': '100',
      'description': 'For immediate police assistance in emergencies.',
    },
    {
      'name': 'Fire Department',
      'number': '101',
      'description': 'For fire emergencies and rescue operations.',
    },
    {
      'name': 'Ambulance',
      'number': '102',
      'description': 'For medical emergencies requiring an ambulance.',
    },
    {
      'name': 'Poison Control',
      'number': '1066',
      'description': 'For poisoning emergencies and advice.',
    },
    {
      'name': 'Mental Health Helpline',
      'number': '9152987821',
      'description': 'For mental health support and counseling.',
    },
    {
      'name': 'Women\'s Helpline',
      'number': '1091',
      'description': 'For women in distress needing immediate assistance.',
    },
    {
      'name': 'Child Helpline',
      'number': '1098',
      'description': 'For children in need of care and protection.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Local Emergency Services',
          style: TextStyle(
            fontWeight: FontWeight.bold, // Bold the text
            color: Colors.white,         // Set text color to white
          ),
        ),
        backgroundColor: Color(0xff1f597c),
      ),
      body: Container(
        color: Color(0xffbdd0d6), // Background color for the entire page
        child: ListView.builder(
          itemCount: services.length,
          itemBuilder: (context, index) {
            final service = services[index];
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: ListTile(
                title: Text(
                  service['name']!,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff1f597c),
                  ),
                ),
                subtitle: Text(service['description']!),
                trailing: ElevatedButton.icon(
                  onPressed: () {
                    _makePhoneCall(service['number']!);
                  },
                  icon: Icon(Icons.call),
                  label: Text(service['number']!),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xffbdd0d6), // Button background color
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final status = await Permission.phone.status;

    if (status.isGranted) {
      // Permission is granted, proceed with the phone call
      final Uri launchUri = Uri(
        scheme: 'tel',
        path: phoneNumber,
      );
      await launchUrl(launchUri);
    } else {
      // Request permission
      if (await Permission.phone.request().isGranted) {
        // Permission granted after request
        final Uri launchUri = Uri(
          scheme: 'tel',
          path: phoneNumber,
        );
        await launchUrl(launchUri);
      } else {
        // Permission denied, handle accordingly
        print('Phone call permission denied');
        // Optionally, show a message to the user
      }
    }
  }
}
