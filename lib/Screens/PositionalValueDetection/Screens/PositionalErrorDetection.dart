import 'package:flutter/material.dart';
import 'letterErrorDetection.dart';
import '../Model/PositionalValuesModel.dart';

class PositionalErrorDetector extends StatefulWidget {
  const PositionalErrorDetector({Key? key}) : super(key: key);

  @override
  State<PositionalErrorDetector> createState() => _PositionalErrorDetector();
}
class _PositionalErrorDetector extends State<PositionalErrorDetector> {
  late double height, width;
  late String word = "KATHA";

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation:0.0,
          centerTitle: true,
          leading: IconButton(
            icon: Icon(
                Icons.arrow_back,
                color: Colors.black
            ), onPressed: () {
            Navigator.of(context).pop();
          },
          )
      ),
      body: Stack(
        children:[
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/background_image.jpg'), // Replace with your image path
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 350,
                  height: 320,
                  decoration: BoxDecoration(
                      color: Colors.blue.shade300,
                      borderRadius: BorderRadius.circular(40),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2), // Shadow color and opacity
                          blurRadius: 5, // Spread radius
                          spreadRadius: 2, // Blur radius
                          offset: Offset(0, 3), // Offset in x and y direction
                        ),
                      ]
                  ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              width: 200,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.pink.shade200,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: Colors.pink.shade100,
                                  width: 3,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  word,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              width: 90,
                              height: 90,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: Colors.white,
                                  width: 3,
                                ),
                              ),
                            ),
                            Container(
                              width: 90,
                              height: 90,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: Colors.white,
                                  width: 3,
                                ),
                              ),
                            ),
                            Container(
                              width: 90,
                              height: 90,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: Colors.white,
                                  width: 3,
                                ),
                              ),
                            ),
                          ],
                        ), // Adjust the height as needed to minimize spacing
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              width: 90,
                              height: 40,
                              child: Center(
                                child: Text(
                                  'ආරම්භය',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 90,
                              height: 40,
                              child: Center(
                                child: Text(
                                  'මැද',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 90,
                              height: 40,
                              child: Center(
                                child: Text(
                                  'අවසානය',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                child: const Icon(
                                  Icons.check_circle_rounded,
                                  size: 40, // Replace with the desired icon size
                                  color: Colors.green, // Replace with the desired icon color
                                ),
                                // Other container properties here
                                // child: initialPositionIsCorrect
                                //     ? Icon(
                                //   Icons.check_circle_rounded,
                                //   size: 40,
                                //   color: Colors.green,
                                // )
                                //     : Icon(
                                //   Icons.highlight_off_rounded,
                                //   size: 40,
                                //   color: Colors.red,
                                // ),
                              ),
                              Container(
                                child: Icon(
                                  Icons.highlight_off_sharp,
                                  size: 40, // Replace with the desired icon size
                                  color: Colors.red, // Replace with the desired icon color
                                ),
                                // Other container properties here
                                // child: initialPositionIsCorrect
                                //     ? Icon(
                                //   Icons.check_circle_rounded,
                                //   size: 40,
                                //   color: Colors.green,
                                // )
                                //     : Icon(
                                //   Icons.highlight_off_rounded,
                                //   size: 40,
                                //   color: Colors.red,
                                // ),
                              ),
                              Container(
                                child: Icon(
                                  Icons.check_circle_rounded,
                                  size: 40, // Replace with the desired icon size
                                  color: Colors.green, // Replace with the desired icon color
                                ),

                                // Other container properties here
                                // child: initialPositionIsCorrect
                                //     ? Icon(
                                //   Icons.check_circle_rounded,
                                //   size: 40,
                                //   color: Colors.green,
                                // )
                                //     : Icon(
                                //   Icons.highlight_off_rounded,
                                //   size: 40,
                                //   color: Colors.red,
                                // ),
                              ),
                            ]
                        ),
                      ],
                    ),
                ),
                const SizedBox(height: 20),
                Container(
                  width: 150, // Adjust the width as needed
                  height: 50, // Adjust the height as needed
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LetterErrorDetector()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      'ඉදිරියට',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        decorationColor: Colors.white,
                        decorationStyle: TextDecorationStyle.dashed,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ]
      ),
    );
  }
}