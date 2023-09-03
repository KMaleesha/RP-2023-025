import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui';
import 'package:audioplayers/audioplayers.dart';
import '../Users/screens/homeScreen.dart';
import 'HowToSpeak.dart';

import 'ListWords.dart';


class InCorrectFinal extends StatefulWidget {
  const InCorrectFinal({Key? key}) : super(key: key);

  @override
  State<InCorrectFinal> createState() => _InCorrectFinalState();
}

class _InCorrectFinalState extends State<InCorrectFinal> {
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
  //function to initialize audio
  Future setAudio() async {
    audioPlayer.setReleaseMode(ReleaseMode.loop);

    final player = AudioCache(prefix: "assets/screenTestAssets/VoiceOver/");
    //load song from assets
    final url = await player.load("S5.wav");
    audioPlayer.setSourceUrl(url.path);
  }
  @override
  void dispose() {

    audioPlayer.dispose();  audioPlayer.pause();audioPlayer.pause();
    audioPlayer.pause();
    super.dispose();
  }
  /////////////////3
  @override
  Widget build(BuildContext context) {
    double fem = 1.0; // Your factor value
    double ffem = 1.0; // Your factor value

    return SafeArea(
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
                      'assets/screenTestAssets/incorrectFinal.jpg',
                      fit: BoxFit.cover,

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
                    height: 60.73 * fem,
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
                left: 46 * fem,
                top: 646.991394043 * fem,
                child: Align(
                  child: SizedBox(
                    width: 141 * fem,
                    height: 60.73 * fem,
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
                              Color(0xFFFF69B4),
                              Color(0xFFC71585),
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
                left: 90 * fem,
                top: 656.9298095703 * fem,
                child: Align(
                  child: SizedBox(
                    width: 75 * fem,
                    height: 100 * fem,
                    child: Text(
                      'වෙනත් වචනයක්',
                      style: TextStyle(
                        fontFamily: 'Noto Sans Sinhala',
                        fontSize: 13 * ffem,
                        fontWeight: FontWeight.w700,
                        height: 1.3025 * ffem / fem,
                        color: Color(0xff591010),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 248 * fem,
                top: 656.9298095703 * fem,
                child: Align(
                  child: SizedBox(
                    width: 73 * fem,
                    height: 100 * fem,
                    child: Text(
                      'ප්‍රධාන මෙනුව',
                      style: TextStyle(
                        fontFamily: 'Noto Sans Sinhala',
                        fontSize: 13 * ffem,
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
    );
  }



}