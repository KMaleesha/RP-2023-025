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
import 'package:record/record.dart';
import '../../../utils/configt.dart';
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
  bool askQ = false;
  bool askA = false;
  bool isLoading = true;
  bool isUpload = false;

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

                    Padding(
                      padding: EdgeInsets.only(
                          left: width * 0.7, top: height * 0.4),
                      child: Container(
                        width: 150,
                        height: 150,
                        alignment: Alignment.topLeft,
                        child: Image.asset(Configt.app_hawa),
                      ),
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
    Timer(Duration(seconds: 26), () {
      askQuestion();
      print(" Timer seconds: 31  askQuestion(); ");
    });
    audioPlayer.resume();
    Timer(Duration(seconds: 19), () {
      setState(() {
        print(" Timer  seconds:24 askQ = true; ");
        askQ = true;
      });
    });
  }

  //ask question
  askQuestion() {
    print(" askQuestion ");
    _controller.stop();
    audioPlayer.pause();
    print(" startRecording seconds 31 ");
    startRecording();

    Timer(Duration(seconds: 10), () {
      print(" Timer stopRecording seconds: 41");
      stopRecording();
      setState(() {
        isUpload = true;
      });
    });
    Timer(Duration(seconds: 12), () async {
      print(" Timer  seconds:43 addnewvoice(); ");

      await addnewvoice();

      // startPlayback();
      // Timer(Duration(seconds: 5), () {
      //   print(" stopPlayback");
      //   // stopPlayback();
      // });
    });
  }

  Future<void> startRecording() async {
    print("Start Recording - Entry");
    try {
      Record record = Record();
      if (await record.hasPermission()) {
        print("startRecording() hasPermission ");
        Directory tempDir = await getTemporaryDirectory();
        String tempPath = tempDir.path + '/audio.wav';
        await record.start(path: tempPath);
        setState(() {
          askQ = false;
          askA = true;

          // _isRecording = true;
          _audioPath = tempPath;
          print("tempPath $tempPath");
        });
        print("Start Recording - _audioPath: $_audioPath");
      }
    } catch (e) {
      print("startRecording() has no Permission");
      print(e);
    }
  }

  Future<void> stopRecording() async {
    print(" stopRecording ");
    print("Stop Recording - Entry");
    try {
      Record record = Record();
      String? path = await record.stop();
      if (path != null) {
        setState(() {
          askQ = false;
          askA = false;
          // _isRecording = false;
          _audioPath = path;
          print(" path $path");
        }); // Call the upload method here
        print("Stop Recording - _audioPath: $_audioPath");
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> addnewvoice() async {
    print(" addnewvoice");
    print(" _audioPath $_audioPath");
    if (_audioPath.isNotEmpty) {
      // Get a reference to the audio file
      final audioFile = File(_audioPath);

      // Get a reference to the Firebase Storage bucket
      final storage = FirebaseStorage.instance;
      final audioStorageRef =
      storage.ref().child('audio/${DateTime.now().toIso8601String()}.wav');

      // Upload the audio file to Firebase Storage
      final uploadTask = audioStorageRef.putFile(audioFile);
      final snapshot = await uploadTask.whenComplete(() {});

      // Get the URL of the uploaded audio file
      final audioUrl = await snapshot.ref.getDownloadURL();
      print(" uploading added voice");
      // Save the audio URL and title to Firestore
      final firestore = FirebaseFirestore.instance;
      await firestore
          .collection('therapeuticGamesQuestionAudio')
          .doc('${user?.uid}')
          .collection('hawa')
          .doc()
          .set({
        'uid': user?.uid,
        'date': '${DateTime.now().toIso8601String()}',
        'url': audioUrl,
      });
      await firestore
          .collection("users")
          .doc(user?.uid)
          .collection('therapeuticGamesQuestionAudio')
          .doc('hawa')
          .set({
        'uid': user?.uid,
        'date': '${DateTime.now().toIso8601String()}',
        'url': audioUrl,
      }).whenComplete(() =>
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                  'හූරේ....'))

          ));
      setState(() {
        isLoading = false;
        resultAPI = true;
        isUpload = false;
      });
      if (resultAPI == true) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => WinnerScreen()));
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoserScreen()));
      }

      print("not added voice");
    }
    // Display a success message

    //API Call

    /*Future<void> askQuestion() {
      url = 'http://' */


  }
}