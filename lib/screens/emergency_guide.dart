// lib/screens/emergency_guide.dart
import 'package:flutter/material.dart';
import 'medical_emergencies_page.dart';
import 'natural_disasters_page.dart';
import 'fire_emergencies_page.dart';

class EmergencyGuidePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Emergency Guide'),
        backgroundColor: Color(0xff1f597c), // AppBar color
      ),
      body: Container(
        color: Color(0xffbdd0d6), // Background color
        width: double.infinity, // Ensures the background color covers the width
        height: double.infinity, // Ensures the background color covers the height
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildIntroduction(),
              _buildCategories(context), // Pass context here
              _buildDetailedGuides(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIntroduction() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Introduction',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: Color(0xff1f597c), // Section title color
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            'This Emergency Guide provides step-by-step instructions for various emergencies, including medical emergencies, natural disasters, and fire emergencies. Follow the guidelines to ensure your safety and provide effective help during emergencies.',
            style: TextStyle(
              fontSize: 18.0,
              color: Colors.black, // Ensure text is visible on background
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategories(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Categories of Emergencies',
            style: TextStyle(
              fontSize: 26.0,
              fontWeight: FontWeight.bold,
              color: Color(0xff1f597c), // Section title color
            ),
          ),
          SizedBox(height: 16.0),
          SizedBox(
            height: 130.0, // Adjust height as needed
            child: GridView.count(
              scrollDirection: Axis.horizontal,
              crossAxisCount: 1,
              crossAxisSpacing: 0.0,
              mainAxisSpacing: 0.0,
              children: <Widget>[
                _buildCategoryCard(context, 'Medical Emergencies', Icons.local_hospital, Colors.red, MedicalEmergenciesPage()),
                _buildCategoryCard(context, 'Natural Disasters', Icons.nature, Colors.green, NaturalDisastersPage()),
                _buildCategoryCard(context, 'Fire Emergencies', Icons.fireplace, Colors.orange, FireEmergenciesPage()),
                // Add more categories as needed
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(BuildContext context, String title, IconData icon, Color color, Widget page) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      child: Card(
        color: color,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => page),
            );
          },
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(icon, size: 45.0, color: Colors.white),
                SizedBox(height: 10.0),
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0, // Adjustable text size
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center, // Center align text
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailedGuides() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Detailed Guides',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: Color(0xff1f597c), // Section title color
            ),
          ),
          SizedBox(height: 16.0),
          _buildStepByStepInstructions(),
        ],
      ),
    );
  }

  Widget _buildStepByStepInstructions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Step-by-Step Instructions',
          style: TextStyle(
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
            color: Color(0xff1f597c), // Section title color
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          '1. Assess the situation.\n2. Call for emergency services if needed.\n3. Follow the provided instructions carefully.\n4. Provide first aid if trained and able to do so.\n5. Stay calm and keep others calm.',
          style: TextStyle(
            fontSize: 18.0,
            color: Colors.black, // Ensure text is visible on background
          ),
        ),
      ],
    );
  }
}
