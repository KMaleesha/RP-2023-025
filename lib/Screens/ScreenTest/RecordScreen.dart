import 'dart:core';
import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_sound/flutter_sound.dart';
import 'dart:ui';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:path_provider/path_provider.dart';
import 'ListWords.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'Correct.dart';
import 'Incorrect.dart';

class RecordScreen extends StatefulWidget {
  @override
  _RecordScreenState createState() => _RecordScreenState();
}

class _RecordScreenState extends State<RecordScreen> {
  FlutterSoundRecorder? _recorder;
  bool _isRecording = false;
  String? _path;
  String _audioPath = '';
  final audioPlayer = AudioPlayer();
  double recordingButtonSize = 50.0;

  @override
  void initState() {
    super.initState();
    print("initState Called");
    _recorder = FlutterSoundRecorder();
    _recorder!.openAudioSession();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    Timer(Duration(seconds: 1), () {
      print("Timer 1 fired");
      setAudio();
    });

    Timer(Duration(seconds: 2), () {
      print("Timer 2 fired");
      _handleTap();
    });
  }

  void _handleTap() {
    print("_handleTap Called");
    Timer(Duration(seconds:15), () {
      print("Timer inside _handleTap fired");
    });
    audioPlayer.resume();
  }

  Future setAudio() async {
    print("setAudio Called");
    audioPlayer.setReleaseMode(ReleaseMode.loop);

    final player = AudioCache(prefix: "assets/screenTestAssets/VoiceOver/");
    final url = await player.load("S3_1.wav");
    audioPlayer.setSourceUrl(url.path);
  }
//successful recording func 10/21/23 12:39 p.m
  Future<void> _startRecording() async {
    print("_startRecording Called");
    try {
      if (await Permission.microphone.isGranted) { // Correct way to check for microphone permission
        Directory tempDir = await getTemporaryDirectory();
        String tempPath = tempDir.path + '/audio.wav';
        await _recorder!.startRecorder(toFile: tempPath);
        setState(() {
          _isRecording = true;
          _audioPath = tempPath;
        });
      } else {
        print("Permission Denied");
      }
    } catch (e) {
      print("Error in _startRecording: $e");
    }
  }

  Future<bool> _onWillPop() async {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) =>  const ListWords(),
      ),
    );
    audioPlayer.dispose();
    audioPlayer.pause();
    return false; // Prevents the app from exiting
  }

  Future<void> _stopRecording() async {
    print("_stopRecording Called");
    try {
      await _recorder!.stopRecorder();
      setState(() {
        _isRecording = false;
      });
    } catch (e) {
      print("Error in _stopRecording: $e");
    }

    Timer(Duration(seconds: 1), () {
      print("Timer inside _stopRecording fired");
      uploadAudio(File(_audioPath!), 'balla');
    });
  }

  Future<void> uploadAudio(File audioFile, String inputWord) async {
    print("uploadAudio Called");
    try {
      var request = http.MultipartRequest('POST', Uri.parse('http://192.168.8.181:5000/predict'));
      request.fields['input_word'] = inputWord;
      request.files.add(http.MultipartFile.fromBytes('audio_file', await audioFile.readAsBytes(), filename: 'audio.wav'));

      var response = await request.send();

      if (response.statusCode == 200) {
        var result = await http.Response.fromStream(response);
        var parsedJson = json.decode(result.body);
        print('Result: ${parsedJson['result']}');
        if (parsedJson['result'] == "Correct Answer") {
          audioPlayer.dispose();  audioPlayer.pause();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Correct(),
            ),
          );
        }
        if (parsedJson['result'] == "Wrong Answer") {
          audioPlayer.dispose();  audioPlayer.pause();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => InCorrect(),
            ),
          );
        }
      } else {
        print("Failed to upload. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error in uploadAudio: $e");
    }
  }

  @override
  void dispose() {
    print("dispose Called");
    audioPlayer.pause();
    audioPlayer.dispose();
    _recorder!.closeAudioSession();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    double fem = 1.0;
    double ffem = 1.0;
    return  WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: SafeArea(
          child: Container(
            decoration: const BoxDecoration(
              gradient:  LinearGradient(
                begin: Alignment(0.407, -1),
                end: Alignment(-0.407, 1),
                colors: <Color>[
                  Color(0xff24d0a7),
                  Color(0xff0e510d),
                ],
                stops: <double>[0, 1],
              ),
            ),
            width: double.infinity,
            height: 807 * fem,
            child: Column(
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
                                      builder: (context) => ListWords(),
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
                Positioned(
                  top: 70,
                  left: 0,
                  right: 0,
                  child: Container(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        'මේ කවුද?',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff0e510d),
                          shadows: [
                            Shadow(
                              color: Colors.greenAccent,
                              blurRadius: 2,
                              offset: Offset(1, 1),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: fem*10,
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  top: 60,
                  child: Align(
                    child: Image.asset(
                      'assets/screenTestAssets/DogIn.gif',
                    ),
                  ),
                ),
                SizedBox(
                  height: fem*40,
                ),
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black26,
                          offset: Offset(0, 4),
                          blurRadius: 5.0
                      )
                    ],
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      stops: [0.0, 1.0],
                      colors: [
                        Color(0xffa00000), // Red shade
                        Color(0xffff0000), // Pure red
                      ],
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: ElevatedButton(
                    child: _isRecording
                        ? SpinKitCircle(
                      color: Colors.white,
                      size: 50.0,
                    )
                        : Text(
                      '',
                    ),
                    style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(Size(fem * 1.1, 60)), // Increase size
                      backgroundColor:
                      MaterialStateProperty.all(Colors.transparent),
                      shadowColor:
                      MaterialStateProperty.all(Colors.transparent),
                    ),
                    onPressed: (){
                      audioPlayer.dispose();
                      audioPlayer.pause();
                      audioPlayer.pause();
                      if (_isRecording) {
                        _stopRecording();
                      } else {
                        _startRecording();
                      }
                    },
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