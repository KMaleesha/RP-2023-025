import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';

import '../../../utils/configt.dart';
import '../../GameScreen/Game/animationScreen.dart';
import '../../GameScreen/Game/dataentry_screen.dart';
import '../../GameScreen/Game/selection_screen.dart';
import '../../GameScreen/testing/questionPage.dart';
import '../../PositionalValueDetection/Screens/PositionalErrorDetection.dart';
import '../../PositionalValueDetection/Screens/letterErrorDetails.dart';
import '../../PositionalValueDetection/Screens/letterErrorDetection.dart';
import '../../PositionalValueDetection/Screens/markCalculation.dart';
import '../../TherapistManagement/screens/therapist_dashboard.dart';
import '../../ScreenTest/HomeScreen.dart';
import '../../ScreenTest/ListWords.dart';
import '../../ScreenTest/RecordScreen.dart';
import 'loginScreen.dart';

class HomeScreenAll extends StatefulWidget {
  const HomeScreenAll({Key? key}) : super(key: key);

  @override
  State<HomeScreenAll> createState() => _HomeScreenAllState();
}

class _HomeScreenAllState extends State<HomeScreenAll> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  Future<int> fetchUserRole() async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .get();
      return userDoc.get('role') ?? 0;
    } else {
      return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => LoginScreen(),
                ));
              },
            ),
          ],
        ),
        body: FutureBuilder<int>(
          future: fetchUserRole(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData && snapshot.data != null) {
              int role = snapshot.data!;
              return Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(Configt.app_background2), fit: BoxFit.fill),
                ),
                child: SafeArea(
                  child: Column(
                    children: [

                      Expanded(
                        child: GridView.count(
                          crossAxisCount: 2, // Number of columns in the grid
                          mainAxisSpacing:
                          16.0, // Vertical spacing between items
                          crossAxisSpacing:
                          16.0, // Horizontal spacing between items
                          padding:
                          EdgeInsets.all(16.0), // Padding around the grid
                          children: <Widget>[
                            //maleesha's pages
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => PositionalErrorDetector(),
                                ));
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.purple.shade400,
                                padding: EdgeInsets.all(16.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16.0),
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const <Widget>[
                                  Icon(Icons.record_voice_over,
                                      size: 60.0, color: Colors.white),
                                  SizedBox(height: 16.0),
                                  Text(
                                    'අකුරු වැරදි ',
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            //rashmi's pages
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => HomeScreen(),
                                ));
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.teal.shade400,
                                padding: EdgeInsets.all(16.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16.0),
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const <Widget>[
                                  Icon(Icons.healing,
                                      size: 60.0, color: Colors.white),
                                  SizedBox(height: 16.0),
                                  Text(
                                    'පැවරුම්',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 24.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),


//Tharindu's part
                            SizedBox(
                              width: 100,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                      offset: Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) => DataEntryScreen(),
                                    ));
                                  },
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Lottie.asset(
                                          Configt.childRobot,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),

//bathiya's screens
                            if (role == 2)
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => TherapistDashboard(),
                                  ));
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.teal.shade400,
                                  padding: EdgeInsets.all(16.0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const <Widget>[
                                    Icon(Icons.healing,
                                        size: 60.0, color: Colors.white),
                                    SizedBox(height: 16.0),
                                    Text(
                                      'Therapist Dashboard',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 24.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              return Text('An error occurred: ${snapshot.error}');
            } else {
              return Text('Unknown state');
            }
          },
        ),
      ),
    );
  }
}
