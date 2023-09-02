import 'dart:async';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sound/flutter_sound.dart';

import 'package:path_provider/path_provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:record/record.dart';

import '../../../../utils/configt.dart';
import '../loserScreen.dart';
import '../model/childImage.dart';

class GameQuestionScreen extends StatefulWidget {
  const GameQuestionScreen({Key? key}) : super(key: key);

  @override
  State<GameQuestionScreen> createState() => _GameQuestionScreenState();
}

class _GameQuestionScreenState extends State<GameQuestionScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  Animation<double>? _animation;
  bool isPlaying = false;
  AudioCache audioCache = AudioCache(prefix: "assets/songs/questionWords/");
  AudioPlayer audioPlayer = AudioPlayer();

  double _leftPadding = 0.0;
  double _stopPosition = 0.0;
  double _leftPadding2 = 0.0;
  double _stopPosition2 = 0.0;

  TextEditingController url = TextEditingController();
  bool result = true;

  @override
  void initState() {
    super.initState();
    Audio();
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);

    _controller = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    );


    WidgetsBinding.instance!.addPostFrameCallback((_) {
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


  }

  Future<void> Audio() async {
    print("playAudio");
    final player = AudioCache(prefix: "assets/songs/questionWords/");
    //load song from assets
    final url = await player.load("hawa.wav");
    print(url.path);
  }
  Future<void> _handleTap() async {

      _controller.stop();
      audioPlayer.resume();

      _controller.repeat();


  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double widthall = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: _handleTap ,
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
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
                                child: Image.asset(
                                  Configt.app_childface,
                                  height: 65,
                                  width: 65,
                                ),
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
                              top: height * 0.48, left: _leftPadding),
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

  Future<void> playAudio() async {
    print("playAudio");
    final player = AudioCache(prefix: "assets/songs/questionWords/");
    //load song from assets
    final url = await player.load("hawa.wav");
    print(url.path);

    // Play the audio using the audioPlayer instance


  }
}