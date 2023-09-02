import 'dart:async';
import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import '../../../../utils/configt.dart';
import '../../../ScreenTest/HomeScreen.dart';
import '../loserScreen.dart';
import '../model/childImage.dart';
import 'package:flutter_sound/flutter_sound.dart';

import '../selection_screen.dart';
import '../winnerScreen.dart';
class QuestionPageScreen extends StatefulWidget {
  const QuestionPageScreen({super.key});

  @override
  State<QuestionPageScreen> createState() => _QuestionPageScreenState();
}

class _QuestionPageScreenState extends State<QuestionPageScreen>
    with SingleTickerProviderStateMixin {
   AnimationController? _controller;
  late Animation<int> _animation;
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
  bool result = true;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
    getData();
    _handleTap();
    _player = FlutterSoundPlayer();
    _player?.openAudioSession();
    //add sprite images to list
    for (int i = 1; i <= 10; i++) {
      _spriteImages.add(_buildSpriteImage(i));
    }

    _controller = AnimationController(
      duration: const Duration(milliseconds: 5500),
      vsync: this,
    );
    _animation =
        IntTween(begin: 0, end: _spriteImages.length - 1).animate(_controller!);

    _controller?.stop(); // Stop the animation initially

    //initialize head/face image
    _headImage = Image.network(url.text);

    //initialize audio
    setAudio();

    //show snackbar
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showStartDancingSnackbar();
    });
  }

  User? user = FirebaseAuth.instance.currentUser;

  Future<void> getData() async {
    final reference = FirebaseFirestore.instance
        .collection("users")
        .doc(user?.uid)
        .collection("child")
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

    final player = AudioCache(prefix: "assets/songs/questionWords/");
    //load song from assets
    final url = await player.load("hawa.wav");
    audioPlayer.setSourceUrl(url.path);
  }

  @override
  void dispose() {
    _controller?.dispose();
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: OrientationBuilder(builder: (context, orientation) {
          return LayoutBuilder(builder: (context, constraints) {
            //set sprite width and height according to screen size
            final double spriteWidth = MediaQuery.of(context).size.width;
            final double spriteHeight = constraints.maxHeight;

            return Center(
              child: AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      Positioned.fill(
                        child: Center(
                          child: SizedBox(
                            height: spriteHeight,
                            width: spriteWidth,
                            child: _spriteImages[_animation.value],
                          ),
                        ),
                      ),
                      Positioned(
                        top: (orientation == Orientation.portrait) ? 160 : 5,
                        left: (orientation == Orientation.portrait) ? 110 : 2,
                        child: SizedBox(
                          width: (orientation == Orientation.landscape) ? 75 : 75,
                          child:    GestureDetector(
                              child:  Image.asset(Configt.appiconback,height: 75,width: 75,),
                              onTap: () {
                                _controller?.stop();
                                audioPlayer.pause();
                                Navigator.push(context, MaterialPageRoute(builder: (context) => SelectionScreen()),);
                              }
                          ),
                        ),
                      ),
                      //you can change the position of the head/face image according to your need for portrait and landscape mode
                      Positioned(
                        top: (orientation == Orientation.portrait) ? 160 : 60,
                        left:
                        (orientation == Orientation.portrait) ? 110 : 370,
                        child: SizedBox(
                          width: (orientation == Orientation.landscape)
                              ? 100
                              : 200,
                          child: url.text.isNotEmpty
                              ? Image.network(url.text)
                              : Image.asset('assets/images/face.png'),
                        ),
                      ),
                    ],
                  );
                },
              ),
            );
          });
        }),
      ),
    );
  }

  //function to build sprite images
  Image _buildSpriteImage(int index) {
    final AssetImage childImage =
    AssetImage('assets/images/sprite_images/$index.png');
    final Image child = Image(image: childImage, fit: BoxFit.fill);

    return child;
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
      //startvoice recorder
      Timer(Duration(seconds: 5), () {
        askQuestion();
        audioPlayer.stop();
      });




  }
  //ask question
  askQuestion(){
    print(" askQuestion ");

    audioPlayer.pause();
    startRecording;
    Timer(Duration(seconds: 15), () {
      print(" Timer stopRecording ");
      stopRecording();
    });
    Timer(Duration(seconds: 20), () async {
      print(" Timer addnewvoice ");
      await addnewvoice();
      startPlayback();
      Timer(Duration(seconds: 5), () {
        print(" stopPlayback");
        stopPlayback();
      });
    });
  }
  Future<void> startRecording() async {
    print(" startRecording ");
    try {
      Record record = Record();
      if (await record.hasPermission()) {
        Directory tempDir = await getTemporaryDirectory();
        String tempPath = tempDir.path + '/audio.mp3';
        await record.start(path: tempPath);
        setState(() {
          _isRecording = true;
          _audioPath = tempPath;
        });
      }
    } catch (e) {
      print(e);
    }
  }
  Future<void> stopRecording() async {
    print(" stopRecording ");
    try {
      Record record = Record();
      String? path = await record.stop();
      if (path != null) {
        setState(() {
          _isRecording = false;
          _audioPath = path;
        });// Call the upload method here
      }
    } catch (e) {
      print(e);
    }
  }
  Future<void> startPlayback() async {
    print(" startPlayback startPlayback ");
    try {
      if (_audioPath.isNotEmpty ) {
        await _player!.startPlayer(fromURI: _audioPath );

        setState(() {
          isPlaying = true;
        });
      }
    } catch (e) {
      print(e);
    }
  }
  Future<void> stopPlayback() async {
    await _player!.stopPlayer();
    setState(() {
      _isPlaying = false;
    });
  }
  Future<void> addnewvoice() async {
    print(" addnewvoice");
    print(" _audioPath $_audioPath");
    if (_audioPath.isNotEmpty) {
      // Get a reference to the audio file
      final audioFile = File(_audioPath);

      // Get a reference to the Firebase Storage bucket
      final storage = FirebaseStorage.instance;
      final audioStorageRef = storage.ref().child(
          'audio/${DateTime.now().toIso8601String()}.wav');

      // Upload the audio file to Firebase Storage
      final uploadTask = audioStorageRef.putFile(audioFile);
      final snapshot = await uploadTask.whenComplete(() {});

      // Get the URL of the uploaded audio file
      final audioUrl = await snapshot.ref.getDownloadURL();
      print(" uploading added voice");
      // Save the audio URL and title to Firestore
      final firestore = FirebaseFirestore.instance;
      await firestore.collection('audio').add({
        'uid': user?.uid,
        'url': audioUrl,
      }).whenComplete(() => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => QuestionPageScreen()),
      ));
      // Display a success message
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Audio uploaded successfully.')));

      if( result == true){
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => QuestionPageScreen()));
      }else{
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => QuestionPageScreen()));
      }


    } else {
      if( result == true){
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => WinnerScreen()));
      }else{
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoserScreen()));
      }

      print("not added voice");
    }
  }
}
