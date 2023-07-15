import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../utils/configt.dart';
import '../../GameScreen/Game/animationScreen.dart';
import '../../GameScreen/Game/dataentry_screen.dart';
import '../../GameScreen/Game/selection_screen.dart';
import '../../GameScreen/testing/questionPage.dart';
import '../../PositionalValueDetection/Screens/PositionalErrorDetection.dart';
import '../../PositionalValueDetection/Screens/letterErrorDetails.dart';
import '../../PositionalValueDetection/Screens/letterErrorDetection.dart';
import '../../PositionalValueDetection/Screens/markCalculation.dart';
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
        body: Container(
          // decoration: BoxDecoration(
          //   image: DecorationImage(
          //       image: AssetImage(Config.app_background2), fit: BoxFit.fill),
          // ),
          child: SafeArea(
            child: Column(
              children: [
                // Container(
                //   width: 300.0,
                //   padding: EdgeInsets.symmetric(vertical: 16.0),
                //   decoration: BoxDecoration(
                //     color: Color(0x80FFFFFF),
                //     borderRadius: BorderRadius.vertical(
                //       bottom: Radius.circular(16.0),
                //     ),
                //   ),
                //   child: Text(
                //     // 'චිකිත්සක උපකරණ පුවරුව',
                //     'Therapist Dashboard',
                //     style: TextStyle(
                //       fontSize: 24.0,
                //       fontWeight: FontWeight.bold,
                //       color: Colors.black,
                //     ),
                //     textAlign: TextAlign.center,
                //   ),
                // ),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2, // Number of columns in the grid
                    mainAxisSpacing: 16.0, // Vertical spacing between items
                    crossAxisSpacing: 16.0, // Horizontal spacing between items
                    padding: EdgeInsets.all(16.0), // Padding around the grid
                    children: <Widget>[
                      //maleesha's pages
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => LetterErrorDetails(),
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
                          children: <Widget>[
                            Icon(Icons.record_voice_over, size: 60.0, color: Colors.white),
                            SizedBox(height: 16.0),
                            Text(
                              'LetterErrorDetails',
                              style: TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => LetterErrorDetector(),
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
                          children: <Widget>[
                            Icon(Icons.record_voice_over, size: 60.0, color: Colors.white),
                            SizedBox(height: 16.0),
                            Text(
                              'LetterErrorDetector',
                              style: TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => MarkCalculation(),
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
                          children: <Widget>[
                            Icon(Icons.record_voice_over, size: 60.0, color: Colors.white),
                            SizedBox(height: 16.0),
                            Text(
                              'MarkCalculation',
                              style: TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
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
                          children: <Widget>[
                            Icon(Icons.record_voice_over, size: 60.0, color: Colors.white),
                            SizedBox(height: 16.0),
                            Text(
                              'PositionalErrorDetector',
                              style: TextStyle(
                                fontSize: 24.0,
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
                          children: <Widget>[
                            Icon(Icons.healing, size: 60.0, color: Colors.white),
                            SizedBox(height: 16.0),
                            Text(
                              'HomeScreen',
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
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ListWords(),
                          ));
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.pink.shade400,
                          padding: EdgeInsets.all(16.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.notes, size: 60.0, color: Colors.white),
                            SizedBox(height: 16.0),
                            Text(
                              'ListWords',
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
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => AnimationSpriteAnimationScreen(),
                          ));
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue.shade400,
                          padding: EdgeInsets.all(16.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.note_add, size: 60.0, color: Colors.white),
                            SizedBox(height: 16.0),
                            Text(
                              'ani',
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

                      //tharindu's pages
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => QuestionScreen(),
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
                          children: <Widget>[
                            Icon(Icons.healing, size: 60.0, color: Colors.white),
                            SizedBox(height: 16.0),
                            Text(
                              'Question Game page',
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
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => SelectionScreen(),
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
                          children: <Widget>[
                            Icon(Icons.healing, size: 60.0, color: Colors.white),
                            SizedBox(height: 16.0),
                            Text(
                              'SelectionScreen',
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
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => DataEntryScreen(),
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
                          children: <Widget>[
                            Icon(Icons.healing, size: 60.0, color: Colors.white),
                            SizedBox(height: 16.0),
                            Text(
                              'DataEntryScreen',
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
        ),
      ),
    );
  }
}
