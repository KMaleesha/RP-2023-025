import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lottie/lottie.dart';
import 'package:material_dialogs/dialogs.dart';

import '../../../utils/configt.dart';

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

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);

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
            ],
          ),
        ),
      ),
    );
  }
}
