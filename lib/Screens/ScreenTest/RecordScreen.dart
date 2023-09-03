import 'dart:core';
import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_sound/flutter_sound.dart';
import 'dart:ui';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'Correct.dart';
import 'InCorrect.dart';
import 'ListWords.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';
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
  @override
  void initState() {
    super.initState();
    _recorder = FlutterSoundRecorder();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
//2
    Timer(Duration(seconds: 1), () {
      setAudio();
    });

    //startvoice recorder
    Timer(Duration(seconds: 2), () {
      _handleTap();
    });
  }
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
    final url = await player.load("S3_1.wav");
    audioPlayer.setSourceUrl(url.path);
  }
  Future<void> _startRecording() async {
    try {
      if (await FlutterSoundRecorder().isRecording) {
        await _recorder!.stopRecorder();
        setState(() {
          _isRecording = false;
        });
        return;
      }

      Directory tempDir = await getTemporaryDirectory();
      String tempPath = '${tempDir.path}/audio.wav';

      await _recorder!.openAudioSession(
          focus: AudioFocus.requestFocusAndDuckOthers,
          category: SessionCategory.playAndRecord);
      await _recorder!.startRecorder(
        toFile: tempPath,
        codec: Codec.pcm16WAV,  // Specifies WAV format
        numChannels: 1,  // For mono recording
        sampleRate: 16000,  // 48KHz sample rate for higher quality
        bitRate: 256000,  // 256 kbps bit rate to match training data
      );
      setState(() {
        _isRecording = true;
        _audioPath = tempPath;
      });
    } catch (e) {
      print('Error occurred while starting recording: $e');
    }
  }


  Future<void> _stopRecording() async {
    try {
      Record record = Record();
      String? path = await record.stop();
      if (path != null) {
        setState(() {
          _isRecording = false;
          _audioPath = path;
        }); // Call the upload method here
        print("Stop Recording - _audioPath: $_audioPath");
      }
    } catch (e) {
      print(e);
    }
    Timer(Duration(seconds: 1), () {
      uploadAudio(File(_audioPath!), 'balla');
    });
  }

  Future<void> uploadAudio(File audioFile, String inputWord) async {
    var request = http.MultipartRequest('POST', Uri.parse('http://192.168.8.181:5000/predict'));
    request.fields['input_word'] = inputWord;
    request.files.add(http.MultipartFile.fromBytes('audio_file', await audioFile.readAsBytes(), filename: 'audio.wav'));

    var response = await request.send();

    if (response.statusCode == 200) {
      var result = await http.Response.fromStream(response);
      print('Result: ${result.body}');
      var parsedJson = json.decode(result.body);
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
      print('Failed to upload audio');
    }
  }
  @override
  void dispose() {
    _recorder!.closeAudioSession();
    audioPlayer.dispose();
    audioPlayer.pause();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    double fem = 1.0;
    double ffem = 1.0;
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
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
                        color: Colors.black26, offset: Offset(0, 4), blurRadius: 5.0)
                  ],
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [0.0, 1.0],
                    colors: [
                      Color(0xff3f13ae),
                      Color(0xffca1ac7),
                    ],
                  ),
                  color: Colors.deepPurple.shade300,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ElevatedButton(
                  child: _isRecording
                      ? SpinKitCircle(
                    color: Colors.white,
                    size: 50.0,
                  )
                      : Text(
                    '',
                    style: TextStyle(
                      fontFamily: 'Noto Sans Sinhala',
                      fontSize: 18.5,
                      fontWeight: FontWeight.w700,
                      color: Color(0xff591010),
                    ),
                  ),
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    minimumSize: MaterialStateProperty.all(Size(fem, 50)),
                    backgroundColor:
                    MaterialStateProperty.all(Colors.transparent),
                    // elevation: MaterialStateProperty.all(3),
                    shadowColor:
                    MaterialStateProperty.all(Colors.transparent),
                  ),
                  onPressed: (){
                    audioPlayer.dispose();  audioPlayer.pause();
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
    );
  }
}
