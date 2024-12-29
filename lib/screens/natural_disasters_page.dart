import 'package:flutter/material.dart';
import 'natural_disaster_details_page.dart'; // Import the detailed content page

class NaturalDisastersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Natural Disasters'),
        backgroundColor: Color(0xff1f597c), // AppBar color
      ),
      body: Container(
        color: Color(0xffbdd0d6), // Background color
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            _buildNaturalDisasterItem(
              context,
              'Earthquake',
              'Earthquakes are caused by sudden movements of the Earth\'s tectonic plates. Symptoms include shaking, loud noises, and structural damage.',
              [
                'Drop to your hands and knees to prevent being knocked over.',
                'Cover your head and neck with your arms.',
                'If you are indoors, stay there and move away from windows.',
                'If you are outdoors, move away from buildings, streetlights, and power lines.',
              ],
            ),
            _buildNaturalDisasterItem(
              context,
              'Flood',
              'Floods occur when water overflows onto normally dry land. Symptoms include rising water levels, water damage, and disrupted transportation.',
              [
                'Move to higher ground immediately.',
                'Avoid walking or driving through floodwater.',
                'Listen to local authorities for evacuation instructions.',
              ],
            ),
            _buildNaturalDisasterItem(
              context,
              'Tornado',
              'Tornadoes are violent windstorms characterized by a twisting, funnel-shaped cloud. Symptoms include a dark, low-lying cloud and loud, continuous roar.',
              [
                'Seek shelter in a small, windowless interior room on the lowest floor.',
                'Avoid using elevators and stay away from windows.',
                'If you are outside, find a low-lying area and lie flat.',
              ],
            ),
            _buildNaturalDisasterItem(
              context,
              'Hurricane',
              'Hurricanes are powerful tropical storms with strong winds and heavy rain. Symptoms include high winds, heavy rain, and storm surges.',
              [
                'Evacuate if instructed to do so by authorities.',
                'Secure windows and doors and bring in outdoor furniture.',
                'Stay indoors and away from windows during the storm.',
              ],
            ),
            _buildNaturalDisasterItem(
              context,
              'Wildfire',
              'Wildfires are uncontrolled fires that spread rapidly. Symptoms include smoke, flames, and heat.',
              [
                'Evacuate immediately if instructed to do so.',
                'Close all windows and doors to prevent smoke from entering.',
                'Follow local authorities\' instructions and stay informed about the fire’s progress.',
              ],
            ),
            _buildNaturalDisasterItem(
              context,
              'Volcanic Eruption',
              'Volcanic eruptions occur when there is an explosion of magma from a volcano. Symptoms include ash fall, lava flows, and pyroclastic flows.',
              [
                'Evacuate the area if you are instructed to do so.',
                'Cover your mouth and nose to avoid inhaling ash.',
                'Stay indoors and keep windows and doors closed.',
              ],
            ),
            _buildNaturalDisasterItem(
              context,
              'Landslide',
              'Landslides are the movement of rock, earth, or debris down a slope. Symptoms include falling debris and shifting ground.',
              [
                'Move to a stable area away from the landslide.',
                'Avoid driving or walking in areas prone to landslides.',
                'Listen to local authorities for instructions and updates.',
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNaturalDisasterItem(
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
              builder: (context) => NaturalDisasterDetailsPage(
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
