import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:kathaappa/Screens/ScreenTest/ListWords.dart';
import 'package:kathaappa/Screens/ScreenTest/HomeScreen.dart';

class RecordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double fem = 1.0; // Your factor value
    double ffem = 1.0; // Your factor value

    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient:  LinearGradient(
              begin: Alignment(0.407, -1),
              end: Alignment(-0.407, 1),
              colors: <Color>[
                Color(0xff24d0a7),
                Color(0xff0e510d),
              ],
              stops: <double>[0, 1],
            ),
          ),
          width: double.infinity,
          height: 807 * fem,
          child: Column(
            children: [
              ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 13.5914087296 * fem,
                    sigmaY: 13.5914087296 * fem,
                  ),
                  child: Container(
                    margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 16 * fem),
                    padding: EdgeInsets.fromLTRB(36.33 * fem, 14 * fem, 14.67 * fem, 0 * fem),
                    width: double.infinity,
                    height: 54 * fem,
                    decoration: BoxDecoration(
                      color: const Color(0xffffffff),
                    ),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: const Color(0xffffffff),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 50 * fem,
                            height: 30 * fem,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ListWords(),
                                  ),
                                );
                              },
                              child: Image.asset(
                                'assets/screenTestAssets/icon-back.png',
                                width: 50 * fem,
                                height: 30 * fem,
                              ),
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.zero,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                width: 45 * fem,
                                height: 32 * fem,
                                child: ElevatedButton(
                                  onPressed: () {
                                    // Profile button pressed action
                                  },
                                  child: Image.asset(
                                    'assets/screenTestAssets/icon-profile.png',
                                    width: 50 * fem,
                                    height: 27 * fem,
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 16 * fem), // Add necessary spacing
                              Container(
                                width: 43 * fem,
                                height: 32 * fem,
                                child: ElevatedButton(
                                  onPressed: () {
                                    // Home button pressed action
                                  },
                                  child: Image.asset(
                                    'assets/screenTestAssets/icon-home.png',
                                    width: 50 * fem,
                                    height: 27 * fem,
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 70,
                left: 0,
                right: 0,
                child: Container(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'මේ කවුද?',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff0e510d),
                        shadows: [
                          Shadow(
                            color: Colors.greenAccent,
                            blurRadius: 2,
                            offset: Offset(1, 1),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: fem*10,
              ),
              Positioned(
                left: 0,
                right: 0,
                top: 60,
                child: Align(
                  child: Image.asset(
                    'assets/screenTestAssets/DogIn.gif',
                  ),
                ),
              ),
              SizedBox(
                height: fem*40,
              ),
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black26, offset: Offset(0, 4), blurRadius: 5.0)
                  ],
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [0.0, 1.0],
                    colors: [
                      Color(0xff3f13ae),
                      Color(0xffca1ac7),
                    ],
                  ),
                  color: Colors.deepPurple.shade300,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ElevatedButton(
                  child: Text(
                    '',
                    style: TextStyle(
                      fontFamily: 'Noto Sans Sinhala',
                      fontSize: 18.5 * ffem,
                      fontWeight: FontWeight.w700,
                      height: 1.3025 * ffem / fem,
                      color: Color(0xff591010),
                    ),
                  ),
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    minimumSize: MaterialStateProperty.all(Size(fem, 50)),
                    backgroundColor:
                    MaterialStateProperty.all(Colors.transparent),
                    // elevation: MaterialStateProperty.all(3),
                    shadowColor:
                    MaterialStateProperty.all(Colors.transparent),
                  ),
                  onPressed: (){

                  },
                ),
              ),

             /* Positioned(
                left: 46 * fem,
                top: 646.991394043 * fem,
                child: Align(
                  child: SizedBox(
                    width: 141 * fem,
                    height: 43.73 * fem,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ListWords()),
                        );
                      },
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20 * fem),
                          gradient: LinearGradient(
                            begin: Alignment(0.407, -1),
                            end: Alignment(-0.407, 1),
                            colors: <Color>[
                              Color(0xfff9ff00),
                              Color(0xffff4c00),
                            ],
                            stops: <double>[0, 1],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.yellow.withOpacity(0.5),
                              blurRadius: 10.0,
                              spreadRadius: 2.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),*/
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Positioned(
              //       left: 85 * fem,
              //       top: 656.9298095703 * fem,
              //       child: Align(
              //         child: SizedBox(
              //           width: 61 * fem,
              //           height: 27 * fem,
              //           child: Text(
              //             'අරඹමු',
              //             style: TextStyle(
              //               fontFamily: 'Noto Sans Sinhala',
              //               fontSize: 18.5 * ffem,
              //               fontWeight: FontWeight.w700,
              //               height: 1.3025 * ffem / fem,
              //               color: Color(0xff591010),
              //             ),
              //           ),
              //         ),
              //       ),
              //     ),
              //   ],
              // ),

            ],
          ),
        ),
      ),
    );
  }
}
