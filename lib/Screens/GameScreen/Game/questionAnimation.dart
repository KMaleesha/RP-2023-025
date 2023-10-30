import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:Katha/Screens/GameScreen/Game/winnerScreen.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../utils/configt.dart';
import '../../ScreenTest/Correct.dart';
import '../../ScreenTest/InCorrect.dart';
import 'imageSaveSharedPreferences.dart';
import 'loserScreen.dart';
import 'model/childImage.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:http/http.dart' as http;
class QuestionAnimationScreen extends StatefulWidget {
  const QuestionAnimationScreen({super.key});

  @override
  State<QuestionAnimationScreen> createState() =>
      _QuestionAnimationScreenState();
}

class _QuestionAnimationScreenState extends State<QuestionAnimationScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  Animation<double>? _animation;
  final List<Image> _spriteImages = [];
  File? _file;
  bool _isRecording = false;
  String _audioPath = '';
  bool _isPlaying = false;
  bool _isUpdating = false;
  FlutterSoundPlayer? _player;
  late Image _headImage;
  bool _isAdding = false;
  final audioPlayer = AudioPlayer();
  bool isPlaying = false;
  TextEditingController url = TextEditingController();
  bool resultAPI = true;
  double _leftPadding = 0.0;
  double _stopPosition = 0.0;
  double _leftPadding2 = 0.0;
  double _stopPosition2 = 0.0;
  bool cloud = true;
  bool askQ = false;
  bool askA = false;
  bool isLoading = true;
  bool isUpload = false;
  FlutterSoundRecorder? _recorder;
  @override
  void initState() {
    super.initState();
    loadRetrievedImage();
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        isLoading = false; // Content is now loaded
      });
    });
    _recorder = FlutterSoundRecorder();
    _recorder!.openAudioSession();
    getData();
    _player = FlutterSoundPlayer();
    _player?.openAudioSession();
    //add sprite images to list

    _controller = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    );

    _controller.stop(); // Stop the animation initially

    //initialize head/face image
    _headImage = Image.network(url.text);
    Timer(Duration(seconds: 3), () {
      print(" Timer seconds: 3 ssetAudio(); ");
      setAudio();
    });
    //initialize audio

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final double width = MediaQuery
          .of(context)
          .size
          .width;
      _stopPosition = width * 0.1;
      _stopPosition2 = width * 0.2;
      _animation = Tween<double>(
        begin: 0.0,
        end: _stopPosition,
      ).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Curves.linear,
        ),
      )
        ..addListener(() {
          setState(() {
            _leftPadding = _animation!.value;
            _leftPadding2 = _animation!.value;
          });
        });

      _controller.forward();
    });
    //startvoice recorder
    Timer(Duration(seconds: 5), () {
      _handleTap();
      print(" Timer seconds: 5 _handleTap(); ");
    });
  }
  File? _retrievedImage;

  Future<void> loadRetrievedImage() async {
    _retrievedImage = await retrieveImageFromSharedPreferences();
    setState(() {}); // To refresh the widget after image is loaded.
  }
  User? user = FirebaseAuth.instance.currentUser;

  Future<void> getData() async {
    final reference = FirebaseFirestore.instance
        .collection("users")
        .doc(user?.uid)
        .collection("therapeuticGamesChildFace")
        .doc(user?.uid);
    final snapshot = await reference.get();
    final result =
    snapshot.data() == null ? null : ChildImage.fromJson(snapshot.data()!);

    setState(() {
      url.text = result?.url ?? '';
    });
  }

  //function to initialize audio
  Future setAudio() async {
    audioPlayer.setReleaseMode(ReleaseMode.loop);

    final player = AudioCache(prefix: "assets/gameAssets/songs/");
    //load song from assets
    final url = await player.load("questionPage.mp3");
    audioPlayer.setSourceUrl(url.path);
  }

  @override
  void dispose() {
    // if (_controller != null && _controller.isAnimating) {
    //   _controller.stop();
    // }
    // _controller.dispose();
    _controller.stop();
    audioPlayer.dispose();
    audioPlayer.pause();
    super.dispose();
  }

  // Add a state variable to track whether the content is loading

  late double width, height;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery
        .of(context)
        .size
        .width;
    height = MediaQuery
        .of(context)
        .size
        .height;

    // Delay for 3 seconds to simulate loading

    return (isLoading)
        ? Scaffold(

        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(Configt.bAnimation),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            color: Colors.white10,
            child: Center(
              child: Lottie.asset(Configt.rabbit,
                fit: BoxFit.fill,

              ),
            ),
          ),
        ))
        : Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(Configt.app_SelectionPageBackground1),
              fit: BoxFit.cover,
            ),
          ),
          child: SafeArea(
            child: Stack(
              children: [
                Stack(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: height * 0.34, left: _leftPadding2),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 42),
                                child: _retrievedImage != null
                                    ? Container(
                                  height: 80,
                                  width: 60,
                                  child: ClipOval(
                                    child: Image.file(
                                      _retrievedImage!,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                )
                                    : url.text.isNotEmpty
                                    ? Container(
                                  height: 80,
                                  width: 60,
                                  child: ClipOval(
                                    child: Image.network(
                                      url.text,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                )
                                    : Container(
                                  color: Colors.blue,
                                  child: Image.asset(
                                    Configt.app_childface,
                                    height: 50,
                                    width: 100,
                                    fit: BoxFit.fitHeight,
                                  ),
                                ),
                              ),
                              Container(
                                child: Image.asset(
                                  Configt.app_child,
                                  width: 133,
                                  height: 120,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: height * 0.50, left: _leftPadding),
                          child: Image.asset(Configt.app_walkingchild, width: 150, height: 150),
                        ),
                      ],
                    ),

                    GestureDetector(

                        onTap: () {

                          setState(() {
                            stopRecording();
                            isUpload = true;
                          });
                        },
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: width * 0.7, top: height * 0.4),
                        child: Container(
                          width: 150,
                          height: 150,
                          alignment: Alignment.topLeft,
                          child: Image.asset(Configt.app_hawa),
                        ),
                     )
                    ),
                  ],
                ),
                if (isUpload)
                  Stack(
                    children: [
                      SizedBox(
                        width: width * 1,
                        child: Lottie.asset(
                          Configt.rocketg,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ],
                  ),
                if (askA)
                  Stack(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: 170, top: 100),
                        child: SizedBox(
                          height: 80,
                          width: 80,
                          child: Lottie.asset(
                            Configt.thoughtBubble,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ],
                  ),
                if (askQ)
                  Stack(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: 380, top: 170),
                        child: SizedBox(
                          height: 80,
                          width: 80,
                          child: Lottie.asset(
                            Configt.thoughtBubble,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ],
                  ),
                if (cloud)
                  GestureDetector(
                    onTap: (){
                      setState(() {

                        stopRecording1();
                        cloud = false ;
                      });

                    },
                  child: Stack(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: 600, top:90),
                        child: SizedBox(
                          height: 80,
                          width: 80,
                          child:Image.asset(
                          "assets/gameAssets/clouds.png",
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  //function to show snackbar
  void _showStartDancingSnackbar() {
    final snackBar = const SnackBar(
      content: Text(
        'Tap to start dancing',
        textAlign: TextAlign.center,
      ),
      elevation: 0,
      behavior: SnackBarBehavior.floating,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  // Function to handle tap on the screen
  void _handleTap() {
    audioPlayer.resume();

    Timer(Duration(seconds: 20), () {
      print(" seconds: 20  (25) askQ = true; ");
      setState(() {
        askQ = true;
      });

      Timer(Duration(seconds: 5), () {
        print(" seconds: 5  (30)        askQ = false;  startRecording(); ");
        setState(() {
          askQ = false;
          askA = true;
          print(" askQuestion ");
          _controller.stop();
          audioPlayer.pause();
          print(" startRecording seconds 31 ");
          startRecording();
        });
        print(" Timer seconds: 31  askQuestion(); ");
      });

    });

    // Timer(Duration(seconds: 19), () {
    //   setState(() {
    //     print(" Timer  seconds:24 askQ = true; ");
    //     askQ = false;
    //   });
    // });
  }

  //ask question


  Future<void> startRecording() async {
    askA = true;
    print("_startRecording Called");
    try {
      if (await Permission.microphone.isGranted) { // Correct way to check for microphone permission
        Directory tempDir = await getTemporaryDirectory();
        String tempPath = tempDir.path + '/audio.wav';
        await _recorder!.startRecorder(toFile: tempPath);
        setState(() {
          _isRecording = true;
          _audioPath = tempPath;
          askA = true;
          askQ = false;
        });
      } else {
        print("Permission Denied");
      }
    } catch (e) {
      print("Error in _startRecording: $e");
    }
  }
  Future<void> stopRecording1() async {

    print("_stopRecording Called");
    try {
      await _recorder!.stopRecorder();
      setState(() {
        cloud = false;
        _isRecording = false;
        askA = false;
        askQ = false;
        isUpload = true;
      });
    } catch (e) {
      print("Error in _stopRecording: $e");
    }

    Timer(Duration(seconds: 2), () {
      print("navigate loser");
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LoserScreen(),
        ),
      );
    });
  }
  Future<void> stopRecording() async {

    print("_stopRecording Called");
    try {
      await _recorder!.stopRecorder();
      setState(() {
        _isRecording = false;
        askA = false;
        askQ = false;
        cloud = false;
      });
    } catch (e) {
      print("Error in _stopRecording: $e");
    }

    Timer(Duration(seconds: 1), () {
      print("Timer inside _stopRecording fired");
      setState(() {
        addnewvoice(File(_audioPath!), 'balla');
        isUpload = true;
      });

    });
  }

  Future<void> addnewvoice(File audioFile, String inputWord) async {
    print(" addnewvoice");
    print(" _audioPath $_audioPath");
    if (_audioPath.isNotEmpty) {
      print("uploadAudio Called");
      try {
        var request = http.MultipartRequest(
            'POST', Uri.parse('http://192.168.8.168:7000/predict'));
        request.fields['input_word'] = inputWord;
        request.files.add(http.MultipartFile.fromBytes(
            'audio_file', await audioFile.readAsBytes(),
            filename: 'audio.wav'));

        var response = await request.send();

        if (response.statusCode == 200) {
          var result = await http.Response.fromStream(response);
          var parsedJson = json.decode(result.body);
          print('Result: ${parsedJson['result']}');
          if (parsedJson['result'] == "Correct Answer") {
            audioPlayer.dispose();
            audioPlayer.pause();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => WinnerScreen(),
              ),
            );
          }
         if (parsedJson['result'] == "Wrong Answer") {
            audioPlayer.dispose();
            audioPlayer.pause();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => WinnerScreen(),
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
  }}