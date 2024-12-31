import 'package:flutter/material.dart';
import 'water_emergencies_details.dart'; // Import the detailed content page

class WaterEmergenciesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Water Emergencies'),
        backgroundColor: Color(0xff1f597c), // AppBar color
      ),
      body: Container(
        color: Color(0xffbdd0d6), // Background color
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            _buildWaterEmergencyItem(
              context,
              'Flooding',
              'Flooding occurs when water overflows onto normally dry land, potentially causing massive damage.',
              [
                'Move to higher ground immediately.',
                'Avoid walking or driving through flooded areas.',
                'Listen to weather alerts and evacuation orders.',
                'Stay indoors and away from windows.',
              ],
            ),
            _buildWaterEmergencyItem(
              context,
              'Drowning',
              'Drowning happens when a person is unable to breathe due to submersion in water.',
              [
                'Call emergency services immediately.',
                'Rescue the person only if it is safe to do so.',
                'If trained, perform CPR until help arrives.',
                'Keep the person warm and dry after rescue.',
              ],
            ),
            _buildWaterEmergencyItem(
              context,
              'Tsunami',
              'A tsunami is a series of waves caused by an underwater earthquake or volcanic eruption.',
              [
                'Move to higher ground immediately.',
                'Stay away from the coastline until official authorities confirm safety.',
                'Listen to tsunami warnings and alerts.',
                'Evacuate if necessary and follow local authorities’ advice.',
              ],
            ),
            _buildWaterEmergencyItem(
              context,
              'Water Pollution',
              'Water pollution occurs when harmful substances contaminate water sources, causing health risks.',
              [
                'Avoid drinking or coming into contact with polluted water.',
                'Report the pollution to local authorities.',
                'Use bottled or purified water until the water is deemed safe.',
                'Seek medical attention if you are exposed to polluted water.',
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWaterEmergencyItem(
      BuildContext context,
      String title,
      String description,
      List<String> steps
      ) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Color(0xff1f597c),
          ),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => WaterEmergenciesDetailsPage(
                title: title,
                description: description,
                steps: steps,
              ),
            ),
          );
        },
      ),
    );
  }
}
