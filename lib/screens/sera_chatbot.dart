import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AshChatbot extends StatefulWidget {
  @override
  _AshChatbotState createState() => _AshChatbotState();
}

class _AshChatbotState extends State<AshChatbot> {
  final List<Map<String, String>> chatHistory = [];
  final TextEditingController _controller = TextEditingController();
  bool isLoading = false;

  Color userTextColor = Color(0xFF000000);
  Color ashTextColor = Color(0xFF000000);

  @override
  void initState() {
    super.initState();
    chatHistory.add({
      "role": "sera",
      "text":
          "👋 Hi! I'm Sera, your emergency assistant.\n\nYou can ask me things like:\n• Where is my medical record?\n• How to handle a fire emergency?\n• What to do during a flood?"
    });
  }

  Future<void> _handleAskQuery() async {
    final question = _controller.text.trim();
    if (question.isEmpty) return;

    setState(() {
      chatHistory.add({"role": "user", "text": question});
      isLoading = true;
      _controller.clear();
    });

    try {
      final response = await http.post(
        Uri.parse("http://192.168.1.4:5000/ask"), // Use your local IP or localhost
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"question": question}),
      );

      final responseText = response.statusCode == 200
          ? json.decode(response.body)['response']
          : "❗Oops, something went wrong with the server.";

      setState(() {
        chatHistory.add({"role": "ash", "text": responseText});
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        chatHistory.add({
          "role": "ash",
          "text": "⚠️ Couldn't connect. Please ensure the backend is running."
        });
        isLoading = false;
      });
    }
  }

  Widget _buildChatBubble(Map<String, String> message) {
    bool isUser = message["role"] == "user";
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 6),
        padding: EdgeInsets.all(14),
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.8),
        decoration: BoxDecoration(
          color: isUser ? Color(0xFFD0E7FF) : Color(0xFFF0F0F0),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(18),
            topRight: Radius.circular(18),
            bottomLeft: Radius.circular(isUser ? 18 : 0),
            bottomRight: Radius.circular(isUser ? 0 : 18),
          ),
          boxShadow: [
            BoxShadow(color: Colors.black12, blurRadius: 3, offset: Offset(0, 2))
          ],
        ),
        child: Text(
          message["text"]!,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: isUser ? userTextColor : ashTextColor,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
  title: Text(
    "Sera - Your SOS Assistant",
    style: TextStyle(
      color: Colors.white, // ✅ This sets the font color to white
      
    ),
  ),
  backgroundColor: Color(0xff1f597c),
),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: chatHistory.length + (isLoading ? 1 : 0),
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              itemBuilder: (context, index) {
                if (index < chatHistory.length) {
                  return _buildChatBubble(chatHistory[index]);
                } else {
                  return Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6.0),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                          SizedBox(width: 10),
                          Text(
                            "Serais thinking...",
                            style: TextStyle(fontStyle: FontStyle.italic, color: Colors.black87),
                          ),
                        ],
                      ),
                    ),
                  );
                }
              },
            ),
          ),
          Divider(height: 1),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Ask something...',
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                      onPressed: _handleAskQuery,
                         child: Icon(Icons.send, size: 20, color: Colors.white), // <== this line
                         style: ElevatedButton.styleFrom(
                         backgroundColor: Color(0xff1f597c),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
               ),

              ],
            ),
          ),
        ],
      ),
    );
  }
}
