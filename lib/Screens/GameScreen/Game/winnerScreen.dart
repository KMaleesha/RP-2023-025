import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:kathaappa/Screens/GameScreen/Game/selection_screen.dart';
import 'package:kathaappa/Screens/ScreenTest/HomeScreen.dart';
import 'package:lottie/lottie.dart';
import 'package:material_dialogs/dialogs.dart';

import '../../../utils/configt.dart';
import '../../Users/screens/homeScreen.dart';

class WinnerScreen extends StatefulWidget {
  WinnerScreen({Key? key}) : super(key: key);

  @override
  State<WinnerScreen> createState() => _WinnerScreenState();
}

class _WinnerScreenState extends State<WinnerScreen> with SingleTickerProviderStateMixin {
  double _containerWidth = 100.0;
  double _containerHeight = 100.0;
  double _imageWidth = 50.0;
  double _imageHeight = 50.0;
  double _image2Width = 20.0;
  double _image2Height = 30.0;
  late AnimationController _controller;
  late Animation<double> _sizeAnimation;
  late Animation<double> _imageSizeAnimation;
  late Animation<double> _image2SizeAnimation;
  //1
  final audioPlayer = AudioPlayer();

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

    final player = AudioCache(prefix: "assets/gameAssets/songs/questionWords/");
    //load song from assets
    final url = await player.load("Hariiii.wav");
    audioPlayer.setSourceUrl(url.path);
  }

  /////////////////3
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
    Timer(Duration(seconds: 1), () {
      setAudio();
    });

    //startvoice recorder
    Timer(Duration(seconds: 2), () {
      _handleTap();
    });
    Timer(Duration(seconds: 10), () {

      audioPlayer.pause();
    });
    _controller = AnimationController(vsync: this, duration: Duration(seconds: 5));
    _sizeAnimation = Tween<double>(begin: 100.0, end: 300.0).animate(_controller)
      ..addListener(() {
        setState(() {
          _containerWidth = _sizeAnimation.value;
          _containerHeight = _sizeAnimation.value;
        });
      });

    _imageSizeAnimation = Tween<double>(begin: 50.0, end: 200.0).animate(_controller)
      ..addListener(() {
        setState(() {
          _imageWidth = _imageSizeAnimation.value;
          _imageHeight = _imageSizeAnimation.value;
        });
      });
    _image2SizeAnimation = Tween<double>(begin: 30.0, end: 100.0).animate(_controller)
      ..addListener(() {
        setState(() {
          _image2Width = _image2SizeAnimation.value;
          _image2Height = _image2SizeAnimation.value;
        });
      });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
    audioPlayer.dispose();
    audioPlayer.pause();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width, // To make it landscape left
          height: MediaQuery.of(context).size.height,
          decoration:  const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(Configt.app_SelectionPageBackground1),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              Center(
                child: GestureDetector(
                  onTap: (){
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => SelectionScreen()),
                    );
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      width: _containerWidth,
                      height: _containerHeight,
                      color: Colors.white,
                      child: Column(
                        children: [
                          Center(
                            child: Lottie.asset(Configt.happyGirl,
                              fit: BoxFit.contain,
                              height: _imageHeight,
                              width: _imageWidth,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Lottie.asset(Configt.stars2,
                                fit: BoxFit.contain,
                                height: _image2Height,
                                width: _image2Width,
                              ),
                              Lottie.asset(Configt.stars2,
                                fit: BoxFit.contain,
                                height: _image2Height,
                                width: _image2Width,
                              ),
                              Lottie.asset(Configt.stars2,
                                fit: BoxFit.contain,
                                height: _image2Height,
                                width: _image2Width,
                              ),
                            ],
                          )

                        ],
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
