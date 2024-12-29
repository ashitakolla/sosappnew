// simulations_page.dart
import 'package:flutter/material.dart';
import 'package:sosappnew/screens/pagestosimulate/default_scenario_page.dart';
import 'pagestosimulate/earthquake_page.dart';
import 'pagestosimulate/flood_page.dart';
import 'pagestosimulate/fire_page.dart'; // Import other scenario pages here
import 'pagestosimulate/cpr_page.dart'; // Add imports for other pages as well
import 'pagestosimulate/choking_page.dart';
import 'pagestosimulate/bleeding_page.dart';
import 'pagestosimulate/robbery_page.dart';
import 'pagestosimulate/self_defence_page.dart';

class SimulationsPage extends StatelessWidget {
  final Map<String, List<String>> scenarios = {
    "Natural Disasters": ["Earthquakes", "Floods", "Fires"],
    "Medical Emergencies": ["CPR", "Choking", "Bleeding"],
    "Personal Safety": ["Robbery", "Self-defense Techniques"],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scenario-Based Learning'),
        backgroundColor: Color(0xff1f597c),
      ),
      body: Container(
        color: Color(0xffbdd0d6),
        child: ListView.builder(
          itemCount: scenarios.keys.length,
          itemBuilder: (context, index) {
            String category = scenarios.keys.elementAt(index);
            return Card(
              margin:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: ListTile(
                title: Text(
                  category,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff1f597c),
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: scenarios[category]!.map((scenario) {
                    return ListTile(
                      title: Text(scenario),
                      onTap: () {
                        // Navigate to the specific scenario page
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => _getScenarioPage(scenario),
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // Method to return the correct page for each scenario
  Widget _getScenarioPage(String scenario) {
    switch (scenario) {
      case 'Earthquakes':
        return EarthquakePage();
      case 'Floods':
        return FloodPage();
      case 'Fires':
        return FirePage();
      case 'CPR':
        return CPRPage();
      case 'Choking':
        return ChokingPage();
      case 'Bleeding':
        return BleedingPage();
      case 'Robbery':
        return RobberyPage();
      case 'Self-defense Techniques':
        return SelfDefensePage();
      default:
        return DefaultScenarioPage();
    }
  }
}
