import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class FeatureButtonsPage extends StatelessWidget {
  final Color appBarColor = Color(0xff1f597c); // Adjustable AppBar background color
  final Color sosButtonColor = Colors.red; // Adjustable SOS button color
  final Color featuresTextColor = Colors.white; // Adjustable Features text color
  final Color bottomNavStripColor = Color(0xff85a0cc); // Color of the horizontal strip

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        title: Text(
          'Features',
          style: TextStyle(color: featuresTextColor), // Adjustable Features text color
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0, top: 15.0), // Adjust the top padding for SOS button
            child: SOSButton(size: 50.0, color: sosButtonColor), // Adjustable SOS button color
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(3.0), // Height of the color strip
          child: Container(
            color: bottomNavStripColor, // Color of the horizontal strip
            height: 3.0, // Height of the horizontal strip
          ),
        ),
      ),
      body: Container(
        color: Color(0xffbdd0d6), // Background color of the page
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: GridView.count(
            crossAxisCount: 2, // Number of columns
            crossAxisSpacing: 16, // Space between columns
            mainAxisSpacing: 16, // Space between rows
            padding: const EdgeInsets.only(top: 80.0), // Shift boxes down
            children: <Widget>[
              FeatureButton(
                title: 'Emergency Guide',
                icon: Icons.menu_book,
                color: Color(0xffef8750), // Emergency Guide color
                onTap: () => Navigator.pushNamed(context, '/emergency_guide'),
              ),
              FeatureButton(
                title: 'Medical Records',
                icon: Icons.live_help,
                color: Color(0xfff3c636), // Real-Time Guidance color
                onTap: () => Navigator.pushNamed(context, '/medical_records'),
              ),
              FeatureButton(
                title: 'Training Videos',
                icon: Icons.videogame_asset,
                color: Color(0xff85bc3a), // Simulations color
                onTap: () => Navigator.pushNamed(context, '/simulations'),
              ),
              FeatureButton(
                title: 'Kit Checklist',
                icon: Icons.checklist,
                color: Color(0xff707ea5), // Kit Checklist color
                onTap: () => Navigator.pushNamed(context, '/kit_checklist'),
              ),
              FeatureButton(
                title: 'Local Services',
                icon: Icons.local_phone,
                color: Color(0xffa263cd), // Local Services color
                onTap: () => Navigator.pushNamed(context, '/local_services'),
              ),
              FeatureButton(
                title: 'Family Help',
                icon: Icons.family_restroom,
                color: Color(0xffd37db2), // Family Help color
                onTap: () => Navigator.pushNamed(context, '/family_help'),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Stack(
        children: [
          Positioned(
            bottom: 20,
            right: 16,
            child: Tooltip(
              message: 'Chatbox', // Tooltip message
              child: FloatingActionButton(
                onPressed: () => Navigator.pushNamed(context, '/chatbot'), // Navigate to Chatbot screen
                backgroundColor: Color(0xff1f597c), // Chatbot button color
                child: Icon(Icons.chat, color: Colors.white), // Chatbot icon
              ),
            ),
          ),
          Positioned(
            bottom: 30, // Adjust the distance from the button
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

// FeatureButton widget remains unchanged
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
          color: color, // Button color
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              icon,
              size: 50.0,
              color: Colors.white,
            ),
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

// SOSButton widget remains unchanged
class SOSButton extends StatelessWidget {
  final double size;
  final Color color; // SOS button color

  const SOSButton({Key? key, this.size = 60.0, this.color = Colors.red}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        const phoneNumber = 'tel:+100'; // Replace with the desired emergency number
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
          color: color, // SOS button color
          shape: BoxShape.circle, // Circular shape
        ),
        child: Center(
          child: Text(
            'SOS',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: size * 0.4, // Adjust text size relative to the button size
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
