import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:record/record.dart';
import 'dart:ui';
import '../Users/screens/homeScreen.dart';
import 'package:audioplayers/audioplayers.dart';
import 'HowToSpeak.dart';
import 'RecordScreen.dart';


class InCorrect extends StatefulWidget {
  const InCorrect({Key? key}) : super(key: key);

  @override
  State<InCorrect> createState() => _InCorrectState();
}

class _InCorrectState extends State<InCorrect> {
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
        builder: (context) => RecordScreen(),
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
    final url = await player.load("S3_3.wav");
    audioPlayer.setSourceUrl(url.path);
  }
  @override
  void dispose() {
    audioPlayer.pause();
    audioPlayer.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    double fem = 1.0; // Your factor value
    double ffem = 1.0; // Your factor value

    return  WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: Container(

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
                                audioPlayer.pause();
                                audioPlayer.dispose();
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
                                    audioPlayer.pause();
                                    audioPlayer.dispose();
                                    Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => HowToSpeak(),
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
                                    // Home button pressed action
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
                left: 0,
                right: 0,
                top: 80,
                child: Align(
                  child: SizedBox(
                    width: 500,
                    height: 700,
                    child: Image.asset(
                      'assets/screenTestAssets/incorrect.png',
                      fit: BoxFit.cover,

                    ),
                  ),
                ),
              ),
///////
      Positioned(
        left: 86 * fem,
        top: 646.991394043 * fem,
        child: GestureDetector(
          onTap: () {
            audioPlayer.pause();
            audioPlayer.dispose();
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HowToSpeak()),
            );
          },
          child: AnimatedContainer(
            width: 200 * fem,
            height: 43.73 * fem,
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
            child: Center(  // Centering text here
              child: Text(
                'උත්සහ කරන්න',
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
            ],
          ),
        ),
      ),
    );
  }



}