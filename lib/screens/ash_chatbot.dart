import 'package:flutter/material.dart';
import 'emergency_guide.dart';
import 'medical_records_page.dart';
import 'emergency_training.dart';
import 'kit_checklist.dart';
import 'local_service.dart';
import 'family_help.dart';
import 'medical_emergencies_page.dart';
import 'natural_disasters_page.dart';
import 'fire_emergencies_page.dart';

class AshChatbot extends StatefulWidget {
  @override
  _AshChatbotState createState() => _AshChatbotState();
}

class _AshChatbotState extends State<AshChatbot> {
  final List<Map<String, String>> chatHistory = [];
  final Map<String, List<Map<String, String>>> dialogs = {
    "start": [
      {"text": "Emergency Guide", "action": "emergency_guide", "color": "0xffef8750"},
      {"text": "Medical Records", "action": "medical_records", "color": "0xfff3c636"},
      {"text": "Training Videos", "action": "training_videos", "color": "0xff85bc3a"},
      {"text": "Kit Checklist", "action": "kit_checklist", "color": "0xff707ea5"},
      {"text": "Local Services", "action": "local_services", "color": "0xffa263cd"},
      {"text": "Family Help", "action": "family_help", "color": "0xffd37db2"},
    ],
    "emergency_guide": [
      {"text": "Medical Emergencies", "action": "medical_emergencies", "color": "0xffef8750"},
      {"text": "Natural Disasters", "action": "natural_disasters", "color": "0xff85bc3a"},
      {"text": "Fire Emergencies", "action": "fire_emergencies", "color": "0xfff3c636"},
    ],
    // Add more dialogs as needed
  };

  String currentDialog = "start";

  @override
  void initState() {
    super.initState();
    chatHistory.add({"role": "ash", "text": "Hello! I am Ash, your emergency assistant. How may I help you today?"});
  }

  void selectOption(String action) {
    setState(() {
      chatHistory.add({"role": "user", "text": action});
      if (dialogs.containsKey(action)) {
        currentDialog = action;
        chatHistory.add({"role": "ash", "text": "Here are your options for $action:"});
      } else {
        chatHistory.add({"role": "ash", "text": "$action selected."});
        // Handle navigation based on selected option
        if (action == "emergency_guide") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => EmergencyGuidePage()),
          );
        } else if (action == "medical_records") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MedicalRecordsPage()),
          );
        } else if (action == "training_videos") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SimulationsPage()),
          );
        } else if (action == "kit_checklist") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => KitChecklistPage()),
          );
        } else if (action == "local_services") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LocalServicesPage()),
          );
        } else if (action == "family_help") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FamilyHelpPage()),
          );
        } else if (action == "medical_emergencies") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MedicalEmergenciesPage()),
          );
        } else if (action == "natural_disasters") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NaturalDisastersPage()),
          );
        } else if (action == "fire_emergencies") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FireEmergenciesPage()),
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ash - Your SOS Assistant"),
        backgroundColor: Color(0xff1f597c),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: chatHistory.length,
                itemBuilder: (context, index) {
                  final message = chatHistory[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Align(
                      alignment: message["role"] == "user"
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: message["role"] == "user"
                              ? Colors.blue[100]
                              : Colors.grey[300],
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 6,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Text(
                          message["text"]!,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: message["role"] == "user"
                                ? Colors.blue
                                : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            if (dialogs.containsKey(currentDialog))
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: dialogs[currentDialog]!
                      .map((option) => ElevatedButton(
                            onPressed: () => selectOption(option["action"]!),
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              backgroundColor: getColor(option["color"]!),
                            ),
                            child: Text(
                              option["text"]!,
                              style: TextStyle(fontSize: 16),
                            ),
                          ))
                      .toList(),
                ),
              ),
          ],
        ),
      ),
    );
  }

  // Function to get the color based on the action type
  Color getColor(String color) {
    switch (color) {
      case '0xffef8750': // Emergency Guide
        return Color(0xffef8750);
      case '0xfff3c636': // Medical Records
        return Color(0xfff3c636);
      case '0xff85bc3a': // Training Videos
        return Color(0xff85bc3a);
      case '0xff707ea5': // Kit Checklist
        return Color(0xff707ea5);
      case '0xffa263cd': // Local Services
        return Color(0xffa263cd);
      case '0xffd37db2': // Family Help
        return Color(0xffd37db2);
      case '0xffef8750': // Medical Emergencies
        return Color(0xffef8750);
      case '0xff85bc3a': // Natural Disasters
        return Color(0xff85bc3a);
      case '0xfff3c636': // Fire Emergencies
        return Color(0xfff3c636);
      default:
        return Colors.blueAccent;
    }
  }
}
