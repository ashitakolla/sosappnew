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
  
  // Adjustable colors
  Color userTextColor = Color.fromARGB(255, 85, 99, 110);  // Default text color for user
  Color ashTextColor = Color(0xFF000000);   // Default text color for Ash
  Color buttonTextColor = Colors.white;      // Default button text color

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
        // Here we trigger a confirmation dialog before navigating
        if (action == "emergency_guide" ||
            action == "medical_records" ||
            action == "training_videos" ||
            action == "kit_checklist" ||
            action == "local_services" ||
            action == "family_help") {
          _showConfirmationDialog(action);
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

  // Function to show a confirmation dialog
  void _showConfirmationDialog(String action) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Are you sure?"),
          content: Text("Do you want to navigate to the $action section?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
                _navigateToSection(action); // Proceed with navigation
              },
              child: Text("Yes"),
            ),
          ],
        );
      },
    );
  }

  // Function to navigate to the selected section
  void _navigateToSection(String action) {
    switch (action) {
      case "emergency_guide":
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => EmergencyGuidePage()),
        );
        break;
      case "medical_records":
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MedicalRecordsPage()),
        );
        break;
      case "training_videos":
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SimulationsPage()),
        );
        break;
      case "kit_checklist":
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => KitChecklistPage()),
        );
        break;
      case "local_services":
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LocalServicesPage()),
        );
        break;
      case "family_help":
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FamilyHelpPage()),
        );
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ash - Your SOS Assistant"),
        backgroundColor: Color(0xff1f597c),
      ),
      backgroundColor: Color.fromRGBO(189, 208, 214, 1), // Apply the background color here
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
                              color: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.2),
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
                                ? userTextColor
                                : ashTextColor,  // Use adjustable color
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
                child: Column(
                  children: [
                    Text(
                      "Select an option to explore more:",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(75, 90, 101, 1),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(255, 158, 158, 158).withOpacity(0.1),
                            blurRadius: 8,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: dialogs[currentDialog]!
                            .map((option) => ElevatedButton(
                                  onPressed: () => selectOption(option["action"]!),
                                  style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    backgroundColor: getColor(option["color"]!),
                                  ),
                                  child: Text(
                                    option["text"]!,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: buttonTextColor,  // Adjustable text color
                                    ),
                                  ),
                                ))
                            .toList(),
                      ),
                    ),
                  ],
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
      default:
        return Colors.blueAccent;
    }
  }
}
