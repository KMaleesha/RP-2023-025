import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui';
import '../Users/screens/homeScreen.dart';
import 'package:audioplayers/audioplayers.dart';
import 'InCorrect.dart';
import 'Correct.dart';
import 'ListWords.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //1
  final audioPlayer = AudioPlayer();
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
//2
    Timer(Duration(seconds: 1), () {
      setAudio();
    });

    //startvoice recorder
    Timer(Duration(seconds: 2), () {
      _handleTap();
    });
    /////////////////2
  }
  /////////////////3
  // Function to handle tap on the screen
  void _handleTap() {
    Timer(Duration(seconds:15), () {

    });
    audioPlayer.resume();
  }

  Future<bool> _onWillPop() async {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) =>  const HomeScreenAll(),
      ),
    );
    audioPlayer.dispose();
    audioPlayer.pause();
    return false; // Prevents the app from exiting
  }

  //function to initialize audio
  Future setAudio() async {
    audioPlayer.setReleaseMode(ReleaseMode.loop);

    final player = AudioCache(prefix: "assets/screenTestAssets/VoiceOver/");
    //load song from assets
    final url = await player.load("S1.wav");
    audioPlayer.setSourceUrl(url.path);
  }
  @override
  void dispose() {

    audioPlayer.pause();
    audioPlayer.dispose();
    super.dispose();
  }
  /////////////////3
  @override
  Widget build(BuildContext context) {
    double fem = 1.0; // Your factor value
    double ffem = 1.0; // Your factor value

    return  WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: SafeArea(
          child: Container(

            color: Colors.greenAccent,  // Add this line to set the background color
            width: double.infinity,
            height: 807 * fem,
            child: Stack(
              children: [
                ClipRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 13.5914087296 * fem,
                      sigmaY: 13.5914087296 * fem,
                    ),
                    child: Container(
                      margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 16 * fem),
                      padding: EdgeInsets.fromLTRB(36.33 * fem, 14 * fem, 14.67 * fem, 0 * fem),
                      width: double.infinity,
                      height: 54 * fem,
                      decoration: BoxDecoration(
                        color: const Color(0xffffffff),
                      ),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: const Color(0xffffffff),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 50 * fem,
                              height: 30 * fem,
                              child: ElevatedButton(
                                onPressed: () {
                                  audioPlayer.dispose();  audioPlayer.pause();
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => HomeScreenAll(),
                                  ));

                                },
                                child: Image.asset(
                                  'assets/screenTestAssets/icon-back.png',
                                  width: 50 * fem,
                                  height: 30 * fem,
                                ),
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Container(
                                  width: 45 * fem,
                                  height: 32 * fem,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      audioPlayer.dispose();  audioPlayer.pause();
                                      Navigator.of(context).push(MaterialPageRoute(
                                        builder: (context) => InCorrect(),
                                      ));

                                    },
                                    child: Image.asset(
                                      'assets/screenTestAssets/icon-profile.png',
                                      width: 50 * fem,
                                      height: 27 * fem,
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.zero,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20.0),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 16 * fem), // Add necessary spacing
                                Container(
                                  width: 43 * fem,
                                  height: 32 * fem,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      audioPlayer.dispose();  audioPlayer.pause();
                                      Navigator.of(context).push(MaterialPageRoute(
                                        builder: (context) => Correct(),
                                      ));
                                    },
                                    child: Image.asset(
                                      'assets/screenTestAssets/icon-home.png',
                                      width: 50 * fem,
                                      height: 27 * fem,
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.zero,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20.0),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 90,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.fromLTRB(44 * fem, 13 * fem, 57 * fem, 11 * fem),
                    width: double.infinity,
                    height: 100,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment(0.407, -1),
                        end: Alignment(-0.407, 1),
                        colors: <Color>[
                          Color(0x69F0AE),
                          Color(0x69F0AE),
                        ],
                        stops: <double>[0, 1],
                      ),
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        'වචන සෙල්ලම',
                        style: TextStyle(
                          fontSize: 34,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff0e510d),
                          shadows: [
                            Shadow(
                              color: Colors.green[200]!, // This is a lighter green.
                              blurRadius: 6,
                              offset: Offset(1, 1),
                            ),
                            Shadow(
                              color: Colors.green[200]!, // You can add more shadows for a stronger glow effect.
                              blurRadius: 6,
                              offset: Offset(-1, -1),
                            ),
                            Shadow(
                              color: Colors.green[200]!,
                              blurRadius: 6,
                              offset: Offset(1, -1),
                            ),
                            Shadow(
                              color: Colors.green[200]!,
                              blurRadius: 6,
                              offset: Offset(-1, 1),
                            ),
                          ],
                        ),
                      ),
                    ),

                  ),
                ),


          // ... (rest of the code above)
                Positioned(
                  left: 0,
                  right: 0,
                  top: 200,
                  child: Align(
                    alignment: Alignment.centerLeft,  // Align to the left to ensure the hand is visible
                    child: SizedBox(
                      width: 500,
                      height: 600,  // Increased the height from 700 to 800
                      child: Image.asset(
                        'assets/screenTestAssets/HomeScreen.gif',
                        fit: BoxFit.cover,  // Using BoxFit.cover to ensure it covers the space without whitespace
                      ),
                    ),
                  ),
                ),

// ... (rest of the code below)
                ///
                Positioned(
                  left: 46 * fem,
                  top: 646.991394043 * fem,
                  child: Align(
                    child: SizedBox(
                      width: 141 * fem,
                      height: 43.73 * fem,
                      child: GestureDetector(
                        onTap: () {
                          audioPlayer.dispose();  audioPlayer.pause();
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ListWords()),
                          );
                        },
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20 * fem),
                            gradient: LinearGradient(
                              begin: Alignment(0.407, -1),
                              end: Alignment(-0.407, 1),
                              colors: <Color>[
                                Color(0xfff9ff00),
                                Color(0xffff4c00),
                              ],
                              stops: <double>[0, 1],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.yellow.withOpacity(0.7),
                                blurRadius: 20.0,
                                spreadRadius: 2.0,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                Positioned(
                  left: 198 * fem,
                  top: 646.991394043 * fem,
                  child: Align(
                    child: SizedBox(
                      width: 141 * fem,
                      height: 43.73 * fem,
                      child: GestureDetector(
                        onTap: () {
                          /*Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HowToDoScreen(),
                            ),
                          );*/
                        },
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20 * fem),
                            gradient: LinearGradient(
                              begin: Alignment(0.407, -1),
                              end: Alignment(-0.407, 1),
                              colors: <Color>[
                                Color(0xff00ffff),
                                Color(0xff242bc9),
                              ],
                              stops: <double>[0, 1],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.blue.withOpacity(0.7),
                                blurRadius: 20.0,
                                spreadRadius: 2.0,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 85 * fem,
                  top: 656.9298095703 * fem,
                  child: Align(
                    child: GestureDetector(
                      onTap: (){
                        audioPlayer.dispose();  audioPlayer.pause();
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ListWords()),
                        );
                      },
                      child: SizedBox(
                        width: 61 * fem,
                        height: 27 * fem,
                        child: Text(
                          'අරඹමු',
                          style: TextStyle(
                            fontFamily: 'Noto Sans Sinhala',
                            fontSize: 17 * ffem,
                            fontWeight: FontWeight.w700,
                            height: 1.3025 * ffem / fem,
                            color: Color(0xff591010),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 229 * fem,
                  top: 656.9298095703 * fem,
                  child: Align(
                    child: SizedBox(
                      width: 73 * fem,
                      height: 27 * fem,
                      child: Text(
                        'දැනගමු',
                        style: TextStyle(
                          fontFamily: 'Noto Sans Sinhala',
                          fontSize: 17 * ffem,
                          fontWeight: FontWeight.w700,
                          height: 1.3025 * ffem / fem,
                          color: Color(0xff591010),
                        ),
                      ),
                    ),
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