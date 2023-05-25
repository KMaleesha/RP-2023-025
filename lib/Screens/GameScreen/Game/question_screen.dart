import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../utils/configt.dart';

class GameQuestionScreen extends StatefulWidget {
  const GameQuestionScreen({Key? key}) : super(key: key);

  @override
  State<GameQuestionScreen> createState() => _GameQuestionScreenState();
}

class _GameQuestionScreenState extends State<GameQuestionScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  Animation<double>? _animation;

  double _leftPadding = 0.0;
  double _stopPosition = 0.0;
  double _leftPadding2 = 0.0;
  double _stopPosition2 = 0.0;
  double _leftPadding3 = 0.0;
  double _stopPosition3 = 0.0;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
    _controller = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    );

    WidgetsBinding.instance!.addPostFrameCallback((_) {
      final double width = MediaQuery.of(context).size.width;
      _stopPosition = width * 0.4;
      _stopPosition2 = width * 0.65;
      _stopPosition3 = width * 0.70;

      _animation = Tween<double>(
        begin: 0.0,
        end: _stopPosition,
      ).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Curves.linear,
        ),
      )..addListener(() {
          setState(() {
            _leftPadding = _animation!.value;
          });
        });

      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double widthall = MediaQuery.of(context).size.width;
    return Scaffold(
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
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            top: height * 0.6, left: _leftPadding),
                        child: Image.asset(Configt.app_walkingchild),
                      ),

                      Padding(
                        padding: EdgeInsets.only(
                            top: height * 0.5, left: _leftPadding2),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left:13),
                              child: Image.asset(Configt.app_childface,
                                  height: 45, width: 45),
                            ),
                            Image.asset(Configt.app_child,
                                height: 100, width: 100),
                          ],
                        ),
                      ),



                      Padding(
                        padding: EdgeInsets.only(top: height * 0.6, left: widthall * 0.24),
                        child: Container(
                          width: 100,
                          height: 100,
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Image.asset(Configt.app_ibba),
                          ),
                        ),
                      ),


                    ],
                  ),


                ],
              ),
            )));
  }
}
