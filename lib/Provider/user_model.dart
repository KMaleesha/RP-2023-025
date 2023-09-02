class UserModel {
  String? uid;
  String? email;
  String? isSignedIn;
  int? role;

  UserModel({
    this.uid,
    this.email,
    this.role,
  });

  //receiving data from server
  factory UserModel.formMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      role: map['role'],
    );
  }

  // sending data to server

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'role': role,
    };
  }
}
