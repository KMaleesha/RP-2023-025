import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kathaappa/Screens/GameScreen/Game/questionAnimation.dart';
import 'package:kathaappa/Screens/GameScreen/Game/selection_screen.dart';
import '../../../utils/configt.dart';
import 'model/childImage.dart';

class AnimationSpriteAnimationScreen extends StatefulWidget {
  const AnimationSpriteAnimationScreen({super.key});

  @override
  State<AnimationSpriteAnimationScreen> createState() => _AnimationSpriteAnimationScreenState();
}

class _AnimationSpriteAnimationScreenState extends State<AnimationSpriteAnimationScreen>
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
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
    // getData();
    //add sprite images to list
    for (int i = 1; i <= 390; i++) {
      _spriteImages.add(_buildSpriteImage(i));
    }

    _controller = AnimationController(
      duration: const Duration(seconds: 39),
      vsync: this,
    );
    _animation =
        IntTween(begin: 0, end: _spriteImages.length - 1).animate(_controller);

    _controller.repeat();
    _controller.stop();

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
              onTap: () async {
                //play or pause animation
                if (_controller.isAnimating) {
                  _controller.stop();
                  setState(() {
                    isPlaying = true;
                    audioPlayer.pause();
                  });
                } else {
                  _controller.repeat();
                  setState(() {
                    isPlaying = false;
                    audioPlayer.resume();
                  });
                }

                //play or pause audio
              },
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
                                child: _spriteImages[_animation.value]),
                          ),
                        ),
                        //you can change the position of the head/face image according to your need for portrait and landscape mode
                        Positioned(
                          top: (orientation == Orientation.portrait) ? 160 : 5,
                          left: (orientation == Orientation.portrait) ? 110 : 2,
                          child: SizedBox(
                            width: (orientation == Orientation.landscape) ? 75 : 75,
                            child:    GestureDetector(
                    child:  Image.asset(Configt.appiconback,
                      height: 75,width: 75,),
                    onTap: () {
                    _controller.stop();
                    audioPlayer.pause();
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SelectionScreen()),);
                    }
                    ),
                          ),
                        ),
                        Positioned(
                          top: (orientation == Orientation.portrait) ? 160 : 260,
                          left: (orientation == Orientation.portrait) ? 110 : 700,
                          child: SizedBox(
                            width: (orientation == Orientation.landscape) ? 100 : 200,
                            child:    GestureDetector(
                              child:  Image.asset(Configt.appiconnext,

                                height: 75,width: 75,),
                                onTap: () {
                    _controller.stop();
                    audioPlayer.pause();
                    Navigator.push(context, MaterialPageRoute(builder: (context) => QuestionAnimationScreen()),);
                    }
                            )

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
    AssetImage('assets/images/animationframes/ezgif-frame-$index.jpg');
    final Image child = Image(image: childImage, fit: BoxFit.fill,gaplessPlayback: true,);

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

}
