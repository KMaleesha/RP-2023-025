import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

class SignInProvider extends ChangeNotifier {
  //instantiate of  firebaseAuth, facebook and google

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;



  bool _isSignedIn = false;
  bool get isSignedIn => _isSignedIn;

  //hasError, errorCode, provider,uid,email,name,imageUrl
  bool _hasError = false;

  bool get hasError => _hasError;

  String? _errorCode;

  String? get errorCode => _errorCode;

  String? _uid;

  String? get uid => _uid;

  String? _email;

  String? get email => _email;

  SignInProvider() {
    checkSignInUser();
  }

  Future checkSignInUser() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    _isSignedIn = s.getBool('signed_in') ?? false;
    notifyListeners();
  }

  Future setSignIn() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    s.setBool('signed_in', true);
    _isSignedIn = true;
    notifyListeners();
  }



  //ENTRY FOR CLOUD_FIRESTORE

  Future getUserDataFromFirestore(uid) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc('uid')
        .get()
        .then((DocumentSnapshot snapshot) => {
              _uid = snapshot['uid'],
              _email = snapshot['email'],
            });
  }

  Future saveDataToFirestore() async {
    final DocumentReference r =
        FirebaseFirestore.instance.collection('users').doc(uid);
    await r.set({
      'email': _email,
      'uid': _uid,
    });
    notifyListeners();
  }

  Future saveDataToSharedPreferences() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    await s.setString('email', _email!);
    await s.setString('uid', _uid!);
    notifyListeners();
  }

  Future getDataFromSharedPreferences() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    _email = s.getString('email');
    _uid = s.getString('uid');
    notifyListeners();
  }

  // checkUser exists or not in cloudfirestore
  Future<bool> checkUserExists() async {
    DocumentSnapshot snap =
        await FirebaseFirestore.instance.collection('users').doc(_uid).get();
    if (snap.exists) {
      print('EXISTING USER');
      return false;
    } else {
      print('NEW USER');
      return false;
    }
  }

  //signOut
  Future userSignOut() async {
    _isSignedIn = false;
    notifyListeners();

    //clear all storage information
    clearStoredData();
  }

  Future clearStoredData() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    s.clear();
  }
}
