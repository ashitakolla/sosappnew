import 'package:flutter/material.dart';
import 'medical_emergencies_page.dart';
import 'natural_disasters_page.dart';
import 'fire_emergencies_page.dart';
import 'water_emergencies_page.dart'; // Import the WaterEmergenciesPage

class EmergencyGuidePage extends StatefulWidget {
  @override
  _EmergencyGuidePageState createState() => _EmergencyGuidePageState();
}

class _EmergencyGuidePageState extends State<EmergencyGuidePage> {
  PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), _autoSlide);
  }

  void _autoSlide() {
    if (_currentPage < 3) {
      _currentPage++;
    } else {
      _currentPage = 0;
    }
    _pageController.animateToPage(
      _currentPage,
      duration: Duration(seconds: 1),
      curve: Curves.easeInOut,
    );
    Future.delayed(Duration(seconds: 3), _autoSlide);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Emergency Guide',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white, // Set text color to white
          ),
        ),
        backgroundColor: Color(0xff1f597c), // Keep the background color as it is
      ),
      body: Container(
        color: Color(0xffbdd0d6),
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.all(6.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _buildIntroduction(),
                    _buildCategories(context),
                    _buildDetailedGuides(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIntroduction() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Introduction',
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            color: Color(0xff1f597c),
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          'This Emergency Guide provides step-by-step instructions for various emergencies, including medical emergencies, natural disasters, fire emergencies, and water-related emergencies. Follow the guidelines to ensure your safety and provide effective help during emergencies.',
          style: TextStyle(
            fontSize: 18.0,
            color: Colors.black,
          ),
        ),
      ],
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
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
              color: Color(0xff1f597c),
            ),
          ),
          SizedBox(height: 16.0),
          SizedBox(
            height: 150.0,
            child: Stack(
              children: [
                PageView(
                  controller: _pageController,
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    _buildCategoryCard(context, 'Medical Emergencies', Icons.local_hospital, Colors.red, MedicalEmergenciesPage()),
                    _buildCategoryCard(context, 'Natural Disasters', Icons.nature, Colors.green, NaturalDisastersPage()),
                    _buildCategoryCard(context, 'Fire Emergencies', Icons.fireplace, Colors.orange, FireEmergenciesPage()),
                    _buildCategoryCard(context, 'Water Emergencies', Icons.water, Colors.blue, WaterEmergenciesPage()),
                  ],
                ),
                Positioned(
                  left: 10.0,
                  top: 60.0,
                  child: IconButton(
                    icon: Icon(Icons.arrow_left, color: Colors.white, size: 30.0),
                    onPressed: () {
                      if (_currentPage > 0) {
                        _pageController.previousPage(
                          duration: Duration(milliseconds: 150),
                          curve: Curves.easeInOut,
                        );
                      }
                    },
                  ),
                ),
                Positioned(
                  right: 10.0,
                  top: 60.0,
                  child: IconButton(
                    icon: Icon(Icons.arrow_right, color: Colors.white, size: 30.0),
                    onPressed: () {
                      if (_currentPage < 3) {
                        _pageController.nextPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(4, (index) {
              return AnimatedContainer(
                duration: Duration(milliseconds: 300),
                margin: EdgeInsets.symmetric(horizontal: 4.0),
                height: 8.0,
                width: _currentPage == index ? 16.0 : 8.0,
                decoration: BoxDecoration(
                  color: _currentPage == index ? Colors.blue : Colors.grey,
                  borderRadius: BorderRadius.circular(4.0),
                ),
              );
            }),
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
                Icon(icon, size: 30.0, color: Colors.white),
                SizedBox(height: 10.0),
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
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
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
              color: Color(0xff1f597c),
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
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Color(0xff1f597c),
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          '1. Assess the situation.\n2. Call for emergency services if needed.\n3. Follow the provided instructions carefully.\n4. Provide first aid if trained and able to do so.\n5. Stay calm and keep others calm.',
          style: TextStyle(
            fontSize: 18.0,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
