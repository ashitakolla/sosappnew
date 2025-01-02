import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          // Background image
          Image.asset(
            'assets/images/welcome_page.jpg',
            fit: BoxFit.cover,
          ),
          // Column to hold the logo, title, catchphrase, and button
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Logo
              Container(
                width: 130, // Adjustable width of the circular logo
                height: 120, // Adjustable height of the circular logo
                child: ClipOval(
                  child: Image.asset(
                    'assets/images/logo.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 20), // Space between logo and title
              // Title
              Text(
                'SOS Education',
                style: TextStyle(
                  fontSize: 36, // Adjustable font size
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10), // Space between title and catchphrase
              // Catchphrase
              Text(
                'Your Guide to Instant Safety',
                style: TextStyle(
                  fontSize: 24, // Adjustable font size
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 50), // Space between catchphrase and button
              // Centered button
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/user_profile');
                },
                child: Text("Let's Get Started"),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black, backgroundColor: Colors.white, // Text color of the button
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10), // Button padding
                  textStyle: TextStyle(fontSize: 20), // Text style of the button
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
