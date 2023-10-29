import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import '../Users/screens/homeScreen.dart';
import 'RecordScreen.dart';
import 'package:audioplayers/audioplayers.dart';

class _HowToSpeakState extends State<HowToSpeak> {
  final audioPlayer = AudioPlayer();
  String currentBackground = 'assets/screenTestAssets/HowTo.jpg'; // Initialize to the first image
  late AudioCache player;

  @override
  void initState() {
    super.initState();
    player = AudioCache(prefix: "assets/screenTestAssets/VoiceOver/");
    _playSequence();
  }

  _playSequence() async {
    // Play first sound and wait for 5 seconds
    var url = await player.load("S4_1.wav");
    audioPlayer.play(UrlSource(url.path));
    await Future.delayed(Duration(seconds: 5));

    // Play second sound, switch background and wait for 5 seconds
    setState(() {
      currentBackground = 'assets/screenTestAssets/HowTo2.gif';
    });
    url = await player.load("S4_2.wav");
    audioPlayer.play(UrlSource(url.path));
    await Future.delayed(Duration(seconds: 3));

    url = await player.load("S4_2.wav");
    audioPlayer.play(UrlSource(url.path));
    await Future.delayed(Duration(seconds: 3));

    setState(() {
      currentBackground = 'assets/screenTestAssets/HowTo.jpg';
    });
    // Play third sound
    url = await player.load("S4_3.wav");
    audioPlayer.play(UrlSource(url.path));
    await Future.delayed(Duration(seconds: 5));
    // Reset to the initial background and repeat the sequence after 7 seconds

    await Future.delayed(Duration(seconds: 7));
    _playSequence();
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
                                audioPlayer.pause(); audioPlayer.dispose();
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
                                    // Profile button pressed action
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
                      currentBackground,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              ///
              Positioned(
                left: 46 * fem,
                top: 646.991394043 * fem,
                child: GestureDetector(
                  onTap: () {
                      audioPlayer.pause();
                      audioPlayer.dispose();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RecordScreen()),
                    );
                  },
                  child: AnimatedContainer(
                    width: 300 * fem,
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
                        'නැවත උත්සාහ කරන්න',
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

class HowToSpeak extends StatefulWidget {
  const HowToSpeak({Key? key}) : super(key: key);

  @override
  State<HowToSpeak> createState() => _HowToSpeakState();
}