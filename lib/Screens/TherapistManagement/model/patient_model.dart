class Patient {
  final String uid;
  final String? name; 
  final int? age;
  final String? mobile;

  Patient({
    required this.uid,
    required this.name, 
    required this.age,
    required this.mobile,
  });
  
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'age': age,
      'mobile': mobile,
    };
  }

  static Patient fromMap(Map<String, dynamic> map) {
    return Patient(
      uid: map['uid'] ?? '',
      name: map['name'] ?? '', 
      age: map['age'] ?? null,  
      mobile: map['mobile'] ?? '',
    );
  }
}
