import 'package:flutter/material.dart';
import 'dart:ui'; // For ImageFilter

class HowToSpeak extends StatefulWidget {
  @override
  _HowToSpeakState createState() => _HowToSpeakState();
}

class _HowToSpeakState extends State<HowToSpeak> {
  @override
  Widget build(BuildContext context) {
    double fem = MediaQuery.of(context).size.width / 375.0; // This is an example way to calculate 'fem'. You might need to adjust it according to your needs.
    double ffem = 1.0; // Not sure how 'ffem' is calculated. Set to 1 as default.

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(0xffffffff),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // ... Your remaining widgets go here ...

          Container(
            // autogroupta5dcKH (33SjvyhLc9B4XW5rT9Ta5d)
            margin: EdgeInsets.fromLTRB(21 * fem, 0 * fem, 37 * fem, 26 * fem),
            width: double.infinity,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  // uploadwcT (4:306)
                  margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 151 * fem, 0 * fem),
                  width: 50 * fem,
                  height: 30 * fem,
                  child: Image.asset('assets/screenTestAssets/HowTo.jpg', width: 50 * fem, height: 30 * fem),
                ),
                // ... The rest of your containers and widgets ...
              ],
            ),
          ),
          // ... More widgets ...
        ],
      ),
    );
  }
}
