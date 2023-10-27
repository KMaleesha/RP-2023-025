import 'package:flutter/material.dart';
import '../../Users/screens/homeScreen.dart';
import 'api_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MarkCalculation extends StatefulWidget {
  final Map<String, dynamic> apiData;
  const MarkCalculation({Key? key, required this.apiData}) : super(key: key);

  @override
  State<MarkCalculation> createState() => _MarkCalculation();
}
class _MarkCalculation extends State<MarkCalculation> {
  late String userInput;
  late String mostMatch;
  late int wordLength;
  late String differingLetters;
  late int numDifferLetter;
  late int correctLetterCount = wordLength - numDifferLetter;
  late double result = ((100 / wordLength) * correctLetterCount);

  get apiCall => ApiService();

// Inside _MarkCalculation class
  void saveDataToFirestore() async {
    // Firestore instance
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Prepare the data to be saved
    Map<String, dynamic> dataToSave = {
      'Differing Letters': differingLetters,
      'Most Match': mostMatch,
      'Position Info': widget.apiData['Position Info'],  // if it's a list, it should be supported by Firestore
      'User Input': userInput,
      'Result': result,
      // ... any other fields you want to save
    };

    // Add data to Firestore
    await firestore
        .collection('letter_error')
        .add(dataToSave)
        .then((value) {
      print("Data added successfully!");
    }).catchError((error) {
      print("Failed to add data: $error");
    });
  }

  @override
  void initState() {
    super.initState();

    mostMatch = widget.apiData['Most Match'] ?? "";
    userInput = widget.apiData['User Input'] ?? "";
    differingLetters = widget.apiData['Differing Letters'] ?? "";

    if (widget.apiData['Position Info'] is List && widget.apiData['Position Info'].length > 1) {
      var positionInfo = widget.apiData['Position Info'][1].split(':').last;
      if (positionInfo != null) {
        numDifferLetter = int.tryParse(positionInfo) ?? 0; // convert string to int
      }
    }

    print("API Data in initState: ${widget.apiData}");
    print("Most Match: $mostMatch");
    print("User Input: $userInput");
    print("Differing Letters: $differingLetters");

    wordLength = mostMatch.length;

  }

  String getTextBasedOnResult(double result) {
    if (result >= 80) {
      return "ගොඩක් හොදින් වචනය කිව්වා";
    } else if (result >= 60 && result < 80) {
      return "හොදින් වචනය කිව්වා";
    } else if (result >= 50 && result < 60) {
      return "හොදින් පුහුනු වෙන්න";
    } else if (result >= 30 && result < 50) {
      return "තව උත්සාහ කරන්න";
    } else {
      return "වැරදි හදාගෙන අයෙත් කියන්න";
    }
  }

  Color getProgressColor(double result) {
    if (result < 50) {
      return Colors.red;
    } else if (result >= 50 && result < 80) {
      return Colors.orange;
    } else {
      return Colors.green;
    }
  }

  String getEmojiBasedOnResult(double result) {
    if (result >= 80) {
      return '😃'; // Smiley face emoji
    } else if (result >= 60 && result < 80) {
      return '😊'; // Happy face emoji
    } else if (result >= 50 && result < 60) {
      return '😐'; // Neutral face emoji
    } else if (result >= 30 && result < 50) {
      return '😕'; // Confused face emoji
    } else {
      return '😞'; // Sad face emoji
    }
  }

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
            backgroundColor: Colors.lightBlueAccent.shade100,
            elevation: 0.0,
            centerTitle: true,
            title: Text(
              'ළකුණු',
              style: TextStyle(color: Colors.black),
            ),
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            // Add the home icon here
            actions: [
              IconButton(
                icon: Icon(
                  Icons.home,
                  color: Colors.black,
                ),
                onPressed: () {
                  // Add the action you want to perform when the home icon is pressed
                  // For example, navigate to the home screen.
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => HomeScreenAll(), // Replace with your home screen widget
                    ),
                  );
                },
              ),
            ],
          ),
          body: Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/phonologicalAssets/background_image3.jpeg'), // Replace with your image path
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
                        height: 450,
                        decoration: BoxDecoration(
                          color: Colors.blue.shade200,
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
                                Container(
                                  margin: const EdgeInsets.all(5),
                                  width: 250,
                                  height: 250,
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
                                        width: 65,
                                        height: 65, // Adjust the height as needed
                                        child: Center(
                                          child: Text(
                                            getEmojiBasedOnResult(result), // Use the emoji returned by the function
                                            style: TextStyle(
                                              fontSize: 55, // Adjust the font size as needed
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.all(24),
                                        width: 90, // Replace with your desired width
                                        height: 90, // Replace with your desired height
                                        child: Container(
                                          width: 150, // Replace with your desired width
                                          height: 150, // Replace with your desired height
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle, // This makes the container circular
                                            color: Colors.white70, // Background color of the circular container
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black.withOpacity(0.2),
                                                blurRadius: 5,
                                                spreadRadius: 2,
                                                offset: Offset(0, 3),
                                              ),
                                            ],
                                          ),
                                          child: Center(
                                            child: CircularProgressIndicator(
                                              value: (result/100.0), // Set progress value based on result
                                              strokeWidth: 12, // Replace with your desired stroke width
                                              valueColor: AlwaysStoppedAnimation<Color>(getProgressColor(result)), // Set color based on result
                                              // You can also customize other properties of the CircularProgressIndicator here
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 2), // Optional spacing between the progress meter and percentage text
                                      Text(
                                        result.round().toString() + '%', // Replace with your desired percentage
                                        style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
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
                                    color: Colors.blueGrey.shade50,
                                    borderRadius: BorderRadius.circular(30),
                                    border: Border.all(
                                      color: Colors.blue,
                                      width: 3,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      getTextBasedOnResult(result), // Use the calculated text here
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
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        width: 150, // Adjust the width as needed
                        height: 50, // Adjust the height as needed
                        child: ElevatedButton(
                          onPressed: () {
                            saveDataToFirestore();
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => HomeScreenAll()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              backgroundColor: Colors.pink
                          ),
                          child: const Text(
                            'මුල් පිටුව',
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