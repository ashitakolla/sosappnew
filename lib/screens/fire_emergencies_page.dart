import 'package:flutter/material.dart';
import 'fire_emergencies_details.dart'; // Import the detailed content page

class FireEmergenciesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fire Emergencies'),
        backgroundColor: Color(0xff1f597c), // AppBar color
      ),
      body: Container(
        color: Color(0xffbdd0d6), // Background color
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            _buildFireEmergencyItem(
              context,
              'House Fire',
              'A house fire can be caused by cooking accidents, electrical faults, or arson. It spreads quickly and can be very dangerous.',
              [
                'Get out of the house immediately.',
                'Call emergency services and report the fire.',
                'If you are trapped, stay low to avoid smoke inhalation.',
                'Do not use elevators during a fire.',
              ],
            ),
            _buildFireEmergencyItem(
              context,
              'Electrical Fire',
              'Electrical fires are caused by faulty wiring or equipment. They can be very dangerous and require specific actions to handle.',
              [
                'Turn off the power if it is safe to do so.',
                'Use a fire extinguisher rated for electrical fires.',
                'Do not use water to put out an electrical fire.',
                'Call emergency services if the fire cannot be controlled.',
              ],
            ),
            _buildFireEmergencyItem(
              context,
              'Grease Fire',
              'Grease fires occur in kitchens when cooking oil overheats and ignites. These fires are fast and can be very dangerous.',
              [
                'Cover the fire with a metal lid or pan to smother it.',
                'Turn off the heat source.',
                'Do not use water to extinguish a grease fire.',
                'Use a fire extinguisher rated for grease fires if needed.',
              ],
            ),
            _buildFireEmergencyItem(
              context,
              'Wildfire',
              'Wildfires are uncontrolled fires that spread rapidly through vegetation. They can be devastating and require careful action.',
              [
                'Evacuate the area immediately if advised.',
                'Avoid inhaling smoke; use a mask if available.',
                'Follow evacuation routes and instructions from authorities.',
                'Do not attempt to fight the wildfire yourself.',
              ],
            ),
            _buildFireEmergencyItem(
              context,
              'Chemical Fire',
              'Chemical fires are caused by flammable chemicals. They can be highly toxic and require special handling.',
              [
                'Evacuate the area and avoid inhaling fumes.',
                'Use a fire extinguisher suitable for chemical fires.',
                'Notify emergency services of the chemical involved.',
                'Do not use water unless instructed to do so.',
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFireEmergencyItem(
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
              builder: (context) => FireEmergenciesDetailsPage(
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
