import 'package:cloud_firestore/cloud_firestore.dart';

class Patient {
  final String uid;
  final String? name; 
  final int? age;
  final String? mobile;
  final Timestamp? patientSince;  

  Patient({
    required this.uid,
    required this.name, 
    required this.age,
    required this.mobile,
    this.patientSince,  
  });
  
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'age': age,
      'mobile': mobile,
      'patientSince': patientSince,  
    };
  }

  static Patient fromMap(Map<String, dynamic> map) {
    return Patient(
      uid: map['uid'] ?? '',
      name: map['name'] ?? '', 
      age: map['age'] ?? null,  
      mobile: map['mobile'] ?? '',
      patientSince: map['patientSince'] as Timestamp?,  
    );
  }
}
