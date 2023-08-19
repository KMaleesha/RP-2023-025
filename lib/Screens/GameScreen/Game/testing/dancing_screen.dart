import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/childImage.dart';

class SpriteAnimationScreen extends StatefulWidget {
  const SpriteAnimationScreen({super.key});

  @override
  State<SpriteAnimationScreen> createState() => _SpriteAnimationScreenState();
}

class _SpriteAnimationScreenState extends State<SpriteAnimationScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<int> _animation;
  final List<Image> _spriteImages = [];

  late Image _headImage;

  final audioPlayer = AudioPlayer();
  bool isPlaying = false;
  TextEditingController url = TextEditingController();

  @override
  void initState() {
    super.initState();
    getData();
    //add sprite images to list
    for (int i = 1; i <= 10; i++) {
      _spriteImages.add(_buildSpriteImage(i));
    }

    _controller = AnimationController(
      duration: const Duration(milliseconds: 5500),
      vsync: this,
    );
    _animation =
        IntTween(begin: 0, end: _spriteImages.length - 1).animate(_controller);

    _controller.stop(); // Stop the animation initially

    //initialize head/face image
    _headImage = Image.network(url.text);

    //initialize audio
    setAudio();

    //show snackbar
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showStartDancingSnackbar();
    });
  }
//ask question
  askQuestion(){
    _controller.stop();
    audioPlayer.pause();
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

    final player = AudioCache(prefix: "assets/songs/");
    //load song from assets
    final url = await player.load("song.mp3");
    audioPlayer.setSourceUrl(url.path);
  }

  @override
  void dispose() {
    _controller.dispose();
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

            return GestureDetector(
              onTap: _handleTap, // Use the custom method for handling tap
              child: Center(
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
    if (_controller.isAnimating) {
      _controller.stop();
      audioPlayer.pause();
    } else {
      // If the animation is not complete, set the animation value based on the current position
      if (_controller.status != AnimationStatus.completed) {
        _controller.value =
            (_animation.value / (_spriteImages.length - 1)).toDouble();
      }
      //startvoice recorder
      Timer(Duration(seconds: 5), () {
        askQuestion();
      });
      _controller.repeat();
      audioPlayer.resume();
    }
    setState(() {
      isPlaying = _controller.isAnimating;
    });
  }
}
