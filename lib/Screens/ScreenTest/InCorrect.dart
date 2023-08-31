import 'package:flutter/material.dart';
import 'dart:ui'; // For ImageFilter

class InCorrect extends StatefulWidget {
  const InCorrect({Key? key}) : super(key: key);
  @override
  State<InCorrect> createState() => _InCorrectState();
}

class _InCorrectState extends State<InCorrect> {
  @override
  Widget build(BuildContext context) {
    // Constants for scaling. Assumed to be defined somewhere in your code.
    double fem = 1.0;
    double ffem = 1.0;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(0xffffffff),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 13.5914087296 * fem,
                sigmaY: 13.5914087296 * fem,
              ),
              child: Container(
                margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 16 * fem),
                padding: EdgeInsets.fromLTRB(36.33 * fem, 14 * fem, 14.67 * fem, 20 * fem),
                width: double.infinity,
                height: 54 * fem,
                decoration: BoxDecoration(
                  color: Color(0xffffffff),
                ),
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 233.33 * fem, 0 * fem),
                        child: Text(
                          '9:27',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Acme',
                            fontSize: 15 * ffem,
                            fontWeight: FontWeight.w400,
                            height: 1.2675 * ffem / fem,
                            letterSpacing: -0.3333333433 * fem,
                            color: Color(0xff000000),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0 * fem, 3.33 * fem, 0 * fem, 5.33 * fem),
                        height: double.infinity,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.all(0),
                              width: 17 * fem,
                              height: 10.67 * fem,
                              child: Image.asset(
                                'assets/screenTestAssets/incorrect.jpg',
                                width: 17 * fem,
                                height: 10.67 * fem,
                              ),
                            ),
                            SizedBox(
                              width: 5 * fem,
                            ),
                            //... Continue with the rest of your containers...
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // ... Continue with the rest of your widgets using Image.asset('assets/screenTestAssets/incorrect.jpg') wherever you had [Image url]...
        ],
      ),
    );
  }
}
