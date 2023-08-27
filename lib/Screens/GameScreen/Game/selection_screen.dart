import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


import '../../../utils/configt.dart';
import '../../Users/screens/homeScreen.dart';
import 'animationScreen.dart';
import 'testing/dancing_screen.dart';

class SelectionScreen extends StatefulWidget {
  const SelectionScreen({Key? key}) : super(key: key);

  @override
  State<SelectionScreen> createState() => _SelectionScreenState();
}

class _SelectionScreenState extends State<SelectionScreen> {

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
  }


  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Configt.app_SelectionPageBackground1),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: height * 0.01),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: width * 0.01),
                      child:  SizedBox(
                        width:  75,
                        child: GestureDetector(
                            child:  Image.asset(Configt.appiconback,height: 75,width: 75),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => HomeScreenAll()),
                              );
                            }
                        ),
                      ),
                    ),

                  ],
                ),
              ),
              Stack(
                children: [
                  Padding(
                    padding:  EdgeInsets.only(left: 8 ,top: height *0.6),
                    child: GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AnimationSpriteAnimationScreen()),
                        ),
                        child: Image.asset(Configt.app_hawa,height: 150,width: 150,)),
                  ),
                  Padding(
                    padding:  EdgeInsets.only(left: 130 , right:400,top: height * 0.4),
                    child:   Image.asset(Configt.app_balla,height: 100,width: 100,),
                  ),
                  Padding(
                    padding:  EdgeInsets.only(left: 220 , right:300,top: height * 0.6),
                    child:  Image.asset(Configt.app_gemba,height: 100,width: 100,),
                  ),
                  Padding(
                    padding:  EdgeInsets.only(left: 670 ,top: height * 0.6),
                    child:  Image.asset(Configt.app_ibba,height: 120,width: 120,),
                  ),
                  Padding(
                    padding:  EdgeInsets.only(left: 520 ,top: height * 0.55),
                    child:     Image.asset(Configt.app_eluwa,height: 100,width: 100,),
                  ),
                  Padding(
                    padding:  EdgeInsets.only(left: 470 ,top: height * 0.08),
                    child:     Image.asset(Configt.app_samanalaya,height: 140,width: 140,),
                  ),
                  Padding(
                    padding:  EdgeInsets.only(left: 140 ,top: height * 0.06),
                    child:    Image.asset(Configt.app_makuluwa,height: 120,width: 120,),
                  ),
                ],
              ),



            ],
          ),
        ),
      ),
    );
  }
}

