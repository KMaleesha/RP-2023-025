import 'dart:async';
import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kathaappa/Screens/GameScreen/Game/selection_screen.dart';
import 'package:kathaappa/Screens/GameScreen/Game/winnerScreen.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import '../../../utils/configt.dart';
import '../../ScreenTest/HomeScreen.dart';
import 'loserScreen.dart';
import 'model/childImage.dart';
import 'package:flutter_sound/flutter_sound.dart';
class QuestionAnimationScreen extends StatefulWidget {
  const QuestionAnimationScreen({super.key});

  @override
  State<QuestionAnimationScreen> createState() => _QuestionAnimationScreenState();
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
  bool result = true;
  double _leftPadding = 0.0;
  double _stopPosition = 0.0;
  double _leftPadding2 = 0.0;
  double _stopPosition2 = 0.0;


  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
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
    Timer(Duration(seconds: 15), () {
      setAudio();
    });
    //initialize audio


    WidgetsBinding.instance!.addPostFrameCallback((_) {
      final double width = MediaQuery
          .of(context)
          .size
          .width;
      _stopPosition = width * 0.1;
      _stopPosition2 = width * 0.2;
      _animation = Tween<double>(
        begin:0.0,
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
    Timer(Duration(seconds: 20), () {
      _handleTap();
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
    _controller.dispose();
    audioPlayer.dispose();
    audioPlayer.pause();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double widthall = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child:Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(Configt.app_SelectionPageBackground1),
              fit: BoxFit.cover,
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                Stack(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              top: height * 0.3, left: _leftPadding2),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 13),
                                child:  url.text.isNotEmpty
                                    ? Image.network(url.text,height: 65,
                                  width: 65,)
                                    : Image.asset(Configt.app_childface,
                                  height: 50,
                                  width: 100,),
                              ),
                              Image.asset(
                                Configt.app_child,
                                width: 150,
                                height: 120,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: height * 0.48, left:   _leftPadding),
                          child: Image.asset(
                              Configt.app_walkingchild, width: 150, height: 150),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: widthall * 0.7, top: height * 0.4),
                      child: Container(
                        width: 150,
                        height: 150,
                        alignment: Alignment.topLeft,
                        child: Image.asset(Configt.app_hawa),
                      ),
                    ),
                  ],
                ),
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
    Timer(Duration(seconds:15), () {
    askQuestion();
  });

  audioPlayer.resume();



  }
  //ask question
  askQuestion(){
    print(" askQuestion ");
    _controller.stop();
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
        MaterialPageRoute(builder: (context) => QuestionAnimationScreen()),
      ));
      // Display a success message
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Audio uploaded successfully.')));

      if( result == true){
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => WinnerScreen()));
      }else{
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoserScreen()));
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
