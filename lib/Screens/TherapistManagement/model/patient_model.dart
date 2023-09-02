class Patient {
  final String uid;
  final int? age;
  final String? mobile;

  Patient({
    required this.uid,
    required this.age,
    required this.mobile,
  });

  // Convert a Patient object into a Map
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'age': age,
      'mobile': mobile,
    };
  }

  // Create a Patient object from a Map
  static Patient fromMap(Map<String, dynamic> map) {
    return Patient(
      uid: map['uid'] ?? '',
      age: map['age'] ?? null,  // Handle null value
      mobile: map['mobile'] ?? '',
    );
  }
}

