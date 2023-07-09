import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../utils/next_Screen.dart';

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

  String? _displayName;

  String? get displayName => _displayName;

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





  // ENTRY FOR CLOUD_FIRESTORE

  Future getUserDataFromFirestore(uid) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc('uid')
        .get()
        .then((DocumentSnapshot snapshot) => {
      _uid = snapshot['uid'],
      _email = snapshot['email'],
      _displayName = snapshot['displayName'],
    });
  }

  Future saveDataToFirestore() async {
    final DocumentReference r =
    FirebaseFirestore.instance.collection('users').doc(uid);
    await r.set({
      'email': _email,
      'uid': _uid,
      'displayName': _displayName,
    });
    notifyListeners();
  }

  Future saveDataToSharedPreferences() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    await s.setString('email', _email!);
    await s.setString('uid', _uid!);
    await s.setString('displayName', _displayName!);
    notifyListeners();
  }

  Future getDataFromSharedPreferences() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    _email = s.getString('email');
    _uid = s.getString('uid');
    _displayName = s.getString('displayName');
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
    firebaseAuth.signOut;


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
