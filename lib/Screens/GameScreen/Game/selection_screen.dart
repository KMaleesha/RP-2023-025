import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


import '../../../utils/configt.dart';
import '../../Users/screens/homeScreen.dart';
import 'animationScreen.dart';
import 'dancing_screen.dart';

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
          child: Column(
            children: <Widget>[

              Padding(
                padding: EdgeInsets.only(top: height * 0.03),
                child: Row(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreenAll()),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: width * 0.04),
                        child:    Positioned(
                          top: 1, left:  2,
                          child: SizedBox(
                            width:  75,
                            child: GestureDetector(
                                child:  Image.asset(Configt.appiconback,height: 75,width: 75),
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => SelectionScreen()),);
                                }
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Padding(
                    //   padding: EdgeInsets.only(left: width * 0.29),
                    //   child: Text(
                    //     Configt.app_dataentrytitle,
                    //     style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                    //   ),
                    // ),
                  ],
                ),
              ),
              Row(
                children: [
                  // Image.asset(Configt.app_man,height: 150,width: 150,),
                  GestureDetector(onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SpriteAnimationScreen()),
                  ),
                      child: Image.asset(Configt.app_balla,height: 100,width: 100,)),
                  Image.asset(Configt.app_eluwa,height: 100,width: 100,),
                  Image.asset(Configt.app_gemba,height: 100,width: 100,),

                ],
              ),
              Row(
                children: [
                  GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AnimationSpriteAnimationScreen()),
                      ),
                      child: Image.asset(Configt.app_hawa,height: 150,width: 150,)),
                  Image.asset(Configt.app_ibba,height: 150,width: 150,),
                  Image.asset(Configt.app_makuluwa,height: 150,width: 150,),
                  Image.asset(Configt.app_samanalaya,height: 150,width: 150,),
                ],
              ),


            ],
          ),
        ),
      ),
    );
  }
}

