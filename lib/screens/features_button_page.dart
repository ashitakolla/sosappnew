import 'dart:io';
import 'package:flutter/material.dart';
import 'package:sosappnew/services/user_session.dart';
import 'package:url_launcher/url_launcher.dart';

class FeatureButtonsPage extends StatelessWidget {
  final Color appBarColor = Color(0xff1f597c);
  final Color sosButtonColor = Colors.red;
  final Color featuresTextColor = Colors.white;
  final Color bottomNavStripColor = Color(0xff85a0cc);
  final Color emergencyIDColor = Color.fromARGB(255, 186, 21, 21); // blue gray 700

  void _showEmergencyPopup(BuildContext context) {
    final user = UserSession().currentUser;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          backgroundColor: Colors.white,
          content: Container(
            width: double.maxFinite,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: Color(0xff1f597c),
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(12)),
                  ),
                  child: Center(
                    child: Text(
                      "EMERGENCY ID CARD",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                if (user.profilePicturePath.isNotEmpty)
                  CircleAvatar(
                    backgroundImage: FileImage(File(user.profilePicturePath)),
                    radius: 40,
                  ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _infoRow("Name", user.name),
                      _infoRow("Blood Group", user.bloodGroup),
                      _infoRow("Emergency Contact", user.emergencyContact),
                      _infoRow("Phone", user.phone),
                      _infoRow("Medical History", user.medicalHistory),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                TextButton(
                  child:
                      Text("Close", style: TextStyle(color: Color(0xff1f597c))),
                  onPressed: () => Navigator.pop(context),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Text(
            "$label: ",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Text(
              value.isNotEmpty ? value : "N/A",
              style: TextStyle(color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        title: Text(
          'Features',
          style: TextStyle(color: featuresTextColor),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0, top: 15.0),
            child: SOSButton(size: 50.0, color: sosButtonColor),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(3.0),
          child: Container(
            color: bottomNavStripColor,
            height: 3.0,
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            color: Color(0xffbdd0d6),
            padding: const EdgeInsets.all(16.0),
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              padding: const EdgeInsets.only(top: 80.0),
              children: <Widget>[
                FeatureButton(
                  title: 'Emergency Guide',
                  icon: Icons.menu_book,
                  color: Color.fromARGB(255, 226, 188, 66),
                  onTap: () => Navigator.pushNamed(context, '/emergency_guide'),
                ),
                FeatureButton(
                  title: 'Medical Records',
                  icon: Icons.live_help,
                  color: Color(0xffef8750),
                  onTap: () => Navigator.pushNamed(context, '/medical_records'),
                ),
                FeatureButton(
                  title: 'Watch First Aid',
                  icon: Icons.videogame_asset,
                  color: Color(0xff85bc3a),
                  onTap: () => Navigator.pushNamed(context, '/simulations'),
                ),
                FeatureButton(
                  title: 'Check Supplies',
                  icon: Icons.checklist,
                  color: Color(0xff707ea5),
                  onTap: () => Navigator.pushNamed(context, '/kit_checklist'),
                ),
                FeatureButton(
                  title: 'Local Services',
                  icon: Icons.local_phone,
                  color: Color(0xffa263cd),
                  onTap: () => Navigator.pushNamed(context, '/local_services'),
                ),
                FeatureButton(
                  title: 'Family Help',
                  icon: Icons.family_restroom,
                  color: Color(0xffd37db2),
                  onTap: () => Navigator.pushNamed(context, '/family_help'),
                ),
              ],
            ),
          ),
          // Floating Emergency ID button (popup trigger)
          Positioned(
            top: 20,
            left: 16,
            child: Row(
              children: [
                // Emergency ID full-size button (same size as chat button)
                Tooltip(
                  message: 'Emergency ID',
                  child: FloatingActionButton(
                    heroTag: 'emergencyID',
                    backgroundColor: emergencyIDColor,
                    onPressed: () => _showEmergencyPopup(context),
                    child: Icon(Icons.badge, color: Colors.white),
                  ),
                ),
                SizedBox(width: 7),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 128, 149, 176)
                        .withOpacity(0.6),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    '<-- This is my Emergency ID',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: Stack(
        children: [
          Positioned(
            bottom: 20,
            right: 16,
            child: Tooltip(
              message: 'Chatbox',
              child: FloatingActionButton(
                onPressed: () => Navigator.pushNamed(context, '/chatbot'),
                backgroundColor: Color(0xff1f597c),
                child: Icon(Icons.chat, color: Colors.white),
              ),
            ),
          ),
          Positioned(
            bottom: 30,
            right: 76,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 128, 149, 176).withOpacity(0.6),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'Need Help? Chat Now!-->',
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FeatureButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const FeatureButton({
    Key? key,
    required this.title,
    required this.icon,
    required this.color,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(icon, size: 50.0, color: Colors.white),
            SizedBox(height: 10.0),
            Text(
              title,
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SOSButton extends StatelessWidget {
  final double size;
  final Color color;

  const SOSButton({Key? key, this.size = 60.0, this.color = Colors.red})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        const phoneNumber = 'tel:+100';
        try {
          if (await canLaunch(phoneNumber)) {
            await launch(phoneNumber);
          } else {
            _showErrorSnackbar(context, 'Unable to make a call');
          }
        } catch (e) {
          _showErrorSnackbar(context, 'Error occurred: $e');
        }
      },
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            'SOS',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: size * 0.4,
            ),
          ),
        ),
      ),
    );
  }

  void _showErrorSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }
}
