import 'package:flutter/material.dart';
import 'medical_emergencies_details.dart'; // Ensure this path is correct

class MedicalEmergenciesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Medical Emergencies'),
        backgroundColor: Color(0xff1f597c), // AppBar color
      ),
      body: Container(
        color: Color(0xffbdd0d6), // Background color
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            _buildMedicalEmergencyItem(
              context,
              'Heart Attack',
              'A heart attack occurs when the blood flow to a part of the heart is blocked. Symptoms may include chest pain, shortness of breath, and nausea. Seek immediate medical attention.',
              [
                'Call emergency services immediately.',
                'Have the person sit down and rest.',
                'If the person is conscious, help them take aspirin if they are not allergic.',
                'Perform CPR if the person becomes unconscious and unresponsive.',
              ],
            ),
            _buildMedicalEmergencyItem(
              context,
              'Choking',
              'Choking occurs when the airway is blocked, preventing breathing. Symptoms include difficulty breathing, coughing, and blue lips or skin.',
              [
                'Encourage the person to cough if they can.',
                'Perform the Heimlich maneuver (abdominal thrusts) if they cannot cough or breathe.',
                'Call emergency services if the obstruction is not removed.',
              ],
            ),
            _buildMedicalEmergencyItem(
              context,
              'Allergic Reactions',
              'An allergic reaction occurs when the immune system overreacts to a substance. Symptoms can range from mild hives to severe prophylaxis. Seek medical help if symptoms are severe.',
              [
                'Administer antihistamines if prescribed.',
                'Use an epinephrine auto-injector if prophylaxis is suspected.',
                'Call emergency services if symptoms persist or worsen.',
              ],
            ),
            _buildMedicalEmergencyItem(
              context,
              'Stroke',
              'A stroke occurs when blood flow to the brain is interrupted. Symptoms include sudden numbness, confusion, trouble speaking, and severe headache.',
              [
                'Call emergency services immediately.',
                'Note the time symptoms started for treatment options.',
                'Do not give the person anything to eat or drink.',
              ],
            ),
            _buildMedicalEmergencyItem(
              context,
              'Severe Bleeding',
              'Severe bleeding can result from cuts, injuries, or trauma. It may lead to shock if not managed properly.',
              [
                'Apply direct pressure to the wound.',
                'Elevate the injured area if possible.',
                'Call emergency services if bleeding does not stop.',
              ],
            ),
            _buildMedicalEmergencyItem(
              context,
              'Burns',
              'Burns can result from heat, chemicals, or electricity. Symptoms include redness, pain, and blistering.',
              [
                'Cool the burn with running cold water for at least 10 minutes.',
                'Cover the burn with a sterile, non-stick dressing.',
                'Avoid using ice or greasy substances on the burn.',
                'Seek medical attention for severe burns.',
              ],
            ),
            _buildMedicalEmergencyItem(
              context,
              'Asthma Attack',
              'An asthma attack occurs when the airways become inflamed and narrow. Symptoms include wheezing, shortness of breath, and coughing.',
              [
                'Use a rescue inhaler as prescribed.',
                'Sit the person upright and keep calm.',
                'Seek medical help if symptoms do not improve.',
              ],
            ),
            _buildMedicalEmergencyItem(
              context,
              'Diabetic Emergency',
              'A diabetic emergency can involve either high or low blood sugar levels. Symptoms include confusion, sweating, and fainting.',
              [
                'Administer insulin or glucose as prescribed.',
                'If unconscious, do not administer anything orally.',
                'Call emergency services if the person does not respond.',
              ],
            ),
            _buildMedicalEmergencyItem(
              context,
              'Seizures',
              'Seizures are episodes of abnormal electrical activity in the brain. Symptoms include convulsions, loss of consciousness, and muscle spasms.',
              [
                'Ensure the person is safe and away from hazards.',
                'Do not hold the person down or put anything in their mouth.',
                'After the seizure, provide comfort and seek medical attention if needed.',
              ],
            ),
            _buildMedicalEmergencyItem(
              context,
              'Fractures',
              'Fractures occur when a bone breaks or cracks. Symptoms include pain, swelling, and deformity.',
              [
                'Immobilize the affected area.',
                'Apply ice to reduce swelling.',
                'Seek medical help immediately.',
              ],
            ),
            _buildMedicalEmergencyItem(
              context,
              'Poisoning',
              'Poisoning occurs when harmful substances are ingested, inhaled, or absorbed. Symptoms can vary based on the poison involved.',
              [
                'Call emergency services and provide details about the poison.',
                'Do not induce vomiting unless instructed by a medical professional.',
                'Provide information about the substance and the amount ingested if possible.',
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMedicalEmergencyItem(
      BuildContext context,
      String title,
      String description,
      List<String> firstAidSteps
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
              builder: (context) => MedicalEmergenciesDetailsPage(
                title: title,
                description: description,
                firstAidSteps: firstAidSteps,
              ),
            ),
          );
        },
      ),
    );
  }
}







