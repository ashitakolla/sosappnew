// lib/pagestosimulate/default_scenario_page.dart
import 'package:flutter/material.dart';

class DefaultScenarioPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scenario Not Found'),
        backgroundColor: Color(0xff1f597c),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 100,
                color: Colors.red,
              ),
              SizedBox(height: 16),
              Text(
                'Sorry, the scenario you selected is not available.',
                style: TextStyle(fontSize: 18, color: Color(0xff1f597c)),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),
              Text(
                'Please select a valid scenario from the list.',
                style: TextStyle(fontSize: 16, color: Color(0xff1f597c)),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
