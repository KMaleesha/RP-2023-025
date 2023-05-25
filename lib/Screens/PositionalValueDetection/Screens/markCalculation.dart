import 'package:flutter/material.dart';

class MarkCalculation extends StatefulWidget {
  const MarkCalculation({Key? key}) : super(key: key);

  @override
  State<MarkCalculation> createState() => _MarkCalculation();
}
class _MarkCalculation extends State<MarkCalculation> {
  late int result = 75;

  @override
  Widget build(BuildContext context) {

    double calculateMark(String word, int correctCount, int wrongCount) {
      int wordLength = word.length;
      double correctPercentage = (correctCount / wordLength) * 100;
      double mark = correctPercentage - (wrongCount * 10);

      // Ensure mark is not negative
      if (mark < 0) {
        mark = 0;
      }

      return mark;
    }

    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          body: Stack(
              children: [
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
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 5,
                              spreadRadius: 2,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.all(5),
                                      width: 180,
                                      height: 180,
                                      decoration: BoxDecoration(
                                        color: Colors.white70,
                                        borderRadius: BorderRadius.circular(40),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(0.2),
                                            blurRadius: 5,
                                            spreadRadius: 2,
                                            offset: Offset(0, 3),
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.all(24),
                                            width: 95, // Replace with your desired width
                                            height: 95, // Replace with your desired height
                                            child: CircularProgressIndicator(
                                              color: Colors.green,
                                              value: 0.75, // Replace with your desired progress value (0.0 to 1.0)
                                              strokeWidth: 8, // Replace with your desired stroke width
                                              // You can also customize the color, background color, and other properties of the CircularProgressIndicator here
                                            ),
                                          ),
                                          SizedBox(height: 2), // Optional spacing between the progress meter and percentage text
                                          Text(
                                            result.toString() + '%', // Replace with your desired percentage
                                            style: TextStyle(
                                              fontSize: 25,
                                              fontWeight:FontWeight.w700,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  margin: const EdgeInsets.all(10),
                                  width: 300,
                                  height: 70,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(30),
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 3,
                                    ),
                                  ),
                                ),
                              ],
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
                            // Navigator.push(
                            //   // context,
                            //   // MaterialPageRoute(builder: (context) => ('')),
                            // );
                          },
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              backgroundColor: Colors.pink
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
                )
              ]
          )
      ),
    );
  }

}