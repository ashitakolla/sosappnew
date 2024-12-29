class EmergencyProfile {
  String name;
  String bloodType;
  String allergies;
  String medicalConditions;
  String emergencyContact;

  EmergencyProfile({
    required this.name,
    required this.bloodType,
    required this.allergies,
    required this.medicalConditions,
    required this.emergencyContact,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'bloodType': bloodType,
        'allergies': allergies,
        'medicalConditions': medicalConditions,
        'emergencyContact': emergencyContact,
      };

  factory EmergencyProfile.fromJson(Map<String, dynamic> json) {
    return EmergencyProfile(
      name: json['name'],
      bloodType: json['bloodType'],
      allergies: json['allergies'],
      medicalConditions: json['medicalConditions'],
      emergencyContact: json['emergencyContact'],
    );
  }
}
