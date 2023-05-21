class UserModel {
  String? uid;
  String? email;
  String? isSignedIn;

  UserModel({
    this.uid,
    this.email,
  });

  //receiving data from server
  factory UserModel.formMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
    );
  }

  // sending data to server

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
    };
  }
}
