import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';
import 'dart:ui';

import 'HomeScreen.dart';
import 'RecordScreen.dart';

class ListWords extends StatefulWidget {
  const ListWords({Key? key}) : super(key: key);

  @override
  State<ListWords> createState() => _ListWordsState();
}

class _ListWordsState extends State<ListWords> {
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
    Timer(Duration(seconds: 5), () {
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
    final url = await player.load("S2.wav");
    audioPlayer.setSourceUrl(url.path);
  }
  @override
  void dispose() {

    audioPlayer.dispose();  audioPlayer.pause();
    audioPlayer.pause();
    super.dispose();
  }
  /////////////////3
  @override
  Widget build(BuildContext context) {
    double fem = 1.0; // Set the value of fem according to your requirements
    double ffem = 1.0; // Set the value of ffem according to your requirements

    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xffffffff),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
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
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HomeScreen(),
                                  ),
                                );
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
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.fromLTRB(64 * fem, 13 * fem, 57 * fem, 11 * fem),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment(0.407, -1),
                        end: Alignment(-0.407, 1),
                        colors: <Color>[
                          Color(0xff24d0a7),
                          Color(0xff0e510d),
                        ],
                        stops: <double>[0, 1],
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            'වචන පිටුව',
                            style: TextStyle(
                              fontSize: 18 * ffem, // Adjust the font size as per your needs
                              fontWeight: FontWeight.bold,
                              // Add any other text style properties you desire
                            ),
                          ),
                        ),
                        SizedBox(height: 16 * fem), // Add necessary spacing
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'කැමති වචනයක් තෝරන්න',
                              style: TextStyle(
                                fontSize: 16 * ffem, // Adjust the font size as per your needs
                                fontWeight: FontWeight.bold,
                                color: Colors.green[900],
                                // Add any other text style properties you desire
                              ),
                            ),
                            SizedBox(width: 8 * fem), // Add necessary spacing
                          ],
                        ),
                        SizedBox(height: 16 * fem), // Add necessary spacing
                        Center(
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 23 * fem, 23 * fem),
                                padding: EdgeInsets.all(9 * fem),
                                width: 240 * fem,
                                height: 240 * fem,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment(0.407, -1),
                                    end: Alignment(-0.407, 1),
                                    colors: <Color>[
                                      Color(0xff3f13ae),
                                      Color(0xffca1ac7),
                                    ],
                                    stops: <double>[0, 1],
                                  ),
                                ),
                                child: Center(
                                  child: SizedBox(
                                    width: 170 * fem,
                                    height: 170 * fem,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        audioPlayer.dispose();  audioPlayer.pause();
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => RecordScreen(),
                                          ),
                                        );
                                      },
                                      child: Image.asset(
                                        'assets/screenTestAssets/DogList.gif',
                                        width: 236 * fem,
                                        height: 252 * fem,
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        padding: EdgeInsets.zero,

                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 23 * fem, 23 * fem),
                                padding: EdgeInsets.all(9 * fem),
                                width: 240 * fem,
                                height: 240 * fem,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment(0.407, -1),
                                    end: Alignment(-0.407, 1),
                                    colors: <Color>[
                                      Color(0xff3f13ae),
                                      Color(0xffca1ac7),
                                    ],
                                    stops: <double>[0, 1],
                                  ),
                                ),
                                child: Center(
                                  child: SizedBox(
                                    width: 180 * fem,
                                    height: 200 * fem,
                                    child: Image.asset(
                                      'assets/screenTestAssets/GoatList.gif',
                                      width: 236 * fem,
                                      height: 252 * fem,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 23 * fem, 23 * fem),
                                padding: EdgeInsets.all(9 * fem),
                                width: 240 * fem,
                                height: 240 * fem,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment(0.407, -1),
                                    end: Alignment(-0.407, 1),
                                    colors: <Color>[
                                      Color(0xff3f13ae),
                                      Color(0xffca1ac7),
                                    ],
                                    stops: <double>[0, 1],
                                  ),
                                ),
                                child: Center(
                                  child: SizedBox(
                                    width: 180 * fem,
                                    height: 200 * fem,
                                    child: Image.asset(
                                      'assets/screenTestAssets/SpiderList.gif',
                                      width: 236 * fem,
                                      height: 252 * fem,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 23 * fem, 23 * fem),
                                padding: EdgeInsets.all(9 * fem),
                                width: 240 * fem,
                                height: 240 * fem,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment(0.407, -1),
                                    end: Alignment(-0.407, 1),
                                    colors: <Color>[
                                      Color(0xff3f13ae),
                                      Color(0xffca1ac7),
                                    ],
                                    stops: <double>[0, 1],
                                  ),
                                ),
                                child: Center(
                                  child: SizedBox(
                                    width: 180 * fem,
                                    height: 200 * fem,
                                    child: Image.asset(
                                      'assets/screenTestAssets/DogList.gif',
                                      width: 236 * fem,
                                      height: 252 * fem,
                                    ),
                                  ),
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
            ],
          ),
        ),
      ),
    );
  }
}
