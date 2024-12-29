import 'package:flutter/material.dart';

class MedicalEmergenciesDetailsPage extends StatelessWidget {
  final String title;
  final String description;
  final List<String> firstAidSteps;

  MedicalEmergenciesDetailsPage({
    required this.title,
    required this.description,
    required this.firstAidSteps,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Color(0xff1f597c), // AppBar color
      ),
      body: Container(
        color: Color(0xffbdd0d6), // Background color
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Text(
                description,
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.black,
                ),
              ),
            ),
            Text(
              'Emergency Steps',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: Color(0xff1f597c),
              ),
            ),
            SizedBox(height: 10.0),
            ...firstAidSteps.map((step) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Text(
                '• $step',
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.black,
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
