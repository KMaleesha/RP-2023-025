import 'dart:async';

import 'package:Katha/Screens/GameScreen/Game/selection_screen.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../utils/configt.dart';

class LoserScreen extends StatefulWidget {
  const LoserScreen({Key? key}) : super(key: key);

  @override
  State<LoserScreen> createState() => _LoserScreenState();
}

class _LoserScreenState extends State<LoserScreen> with SingleTickerProviderStateMixin {
  double _containerWidth = 100.0;
  double _containerHeight = 100.0;
  double _imageWidth = 50.0;
  double _imageHeight = 50.0;

  late AnimationController _controller;
  late Animation<double> _sizeAnimation;
  late Animation<double> _imageSizeAnimation;
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
    //load song from assets assets/gameAssets/songs/questionWords/uthsahakarankooo.wav
    final url = await player.load("uthsahakarankooo.wav");
    audioPlayer.setSourceUrl(url.path);
  }
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

    _controller.forward();


    Timer(Duration(seconds: 9), () {

      audioPlayer.pause();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width, // To make it landscape left
          height: MediaQuery.of(context).size.height, // To make it landscape left
          child: Stack(
            children: [
              Image.asset(
                'assets/gameAssets/selectionPage.png',
                fit: BoxFit.cover,
              ),
              Center(
                child: GestureDetector(
                 onTap: (){
                   audioPlayer.pause();
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
                            child: Image.asset(
                              Configt.appcryface,
                              height: _imageHeight,
                              width: _imageWidth,
                            ),
                          ),
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

