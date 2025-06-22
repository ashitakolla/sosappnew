class User {
  final String name;
  final String age;
  final String gender;
  final String phone;
  final String email;
  final String address;
  final String profilePicturePath;
  final String bloodGroup;
  final String emergencyContact;
  final String medicalHistory;

  User({
    required this.name,
    required this.age,
    required this.gender,
    required this.phone,
    required this.email,
    required this.address,
    required this.profilePicturePath,
    required this.bloodGroup,
    required this.emergencyContact,
    required this.medicalHistory,
  });

  factory User.empty() {
    return User(
      name: '',
      age: '',
      gender: '',
      phone: '',
      email: '',
      address: '',
      profilePicturePath: '',
      bloodGroup: '',
      emergencyContact: '',
      medicalHistory: '',
    );
  }
}
