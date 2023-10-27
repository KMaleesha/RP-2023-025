import 'dart:ui';
import 'package:flutter/material.dart';
import '../../Users/screens/homeScreen.dart';
import 'api_service.dart';
import 'letterErrorDetails.dart';

class LetterErrorDetector extends StatefulWidget {
  final Map<String, dynamic> apiData;
  const LetterErrorDetector({Key? key, required this.apiData}) : super(key: key);

  @override
  State<LetterErrorDetector> createState() => _LetterErrorDetector();
}
class _LetterErrorDetector extends State<LetterErrorDetector> {
  late double height, width;
  late String userInput;
  late String mostMatch;
  late String differingLetters;
  late int numDifferLetter;
  late int letterCount = mostMatch.length;
  late int correctLetterCount = letterCount - numDifferLetter;

  get apiCall => ApiService();

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
    print("positionInfo: $numDifferLetter");
    print("Differing Letters: $differingLetters");
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent.shade100,
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          'වැරදි අකුර',
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
          children:[
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/phonologicalAssets/background_image2.jpg'), // Replace with your image path
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 350, // Adjust the width as needed
                    height: 320, // Adjust the height as needed
                    decoration: BoxDecoration(
                        color: Colors.blue.shade200,
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
                                  userInput,
                                  style: TextStyle(
                                    fontSize: 20,
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
                          children: List.generate(mostMatch.length, (index) {
                            return Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: Colors.blue,
                                  width: 3,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  mostMatch[index],  // This will display the character at the current index
                                  style: TextStyle(
                                    fontSize: 24,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: List.generate(mostMatch.length, (index) {
                            bool isCorrect = true; // Default value
                            if (userInput.length > index) { // Check to avoid index out of range
                              isCorrect = mostMatch[index] == userInput[index];
                            } else {
                              isCorrect = false; // user input is shorter than mostMatch
                            }
                            return Container(
                              child: Icon(
                                isCorrect ? Icons.check_circle_rounded : Icons.highlight_off_rounded,
                                size: 40, // Replace with the desired icon size
                                color: isCorrect ? Colors.green : Colors.red, // Icon color based on comparison
                              ),
                            );
                          }),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              width: 300,
                              height: 55,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(25),
                                border: Border.all(
                                  color: Colors.blue,
                                  width: 3,
                                ),
                              ),
                              child: Center(
                                child: RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: correctLetterCount > numDifferLetter
                                            ? '$correctLetterCount තවත් හොදට කියමු'
                                            : '$numDifferLetter වැරදි හදාගෙන අයෙත් කියමු',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: correctLetterCount >= numDifferLetter
                                              ? Colors.green // Green for correct
                                              : Colors.red, // Red for incorrect
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: 150, // Adjust the width as needed
                    height: 50, // Adjust the height as needed
                    child: FutureBuilder<Map<String, dynamic>>(
                      future: apiCall.fetchPost(userInput),
                      builder: (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else if (snapshot.data != null) {  // Added null check
                          return ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => LetterErrorDetails(apiData: snapshot.data!), // data is non-null here
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              backgroundColor: Colors.pink,
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
                          );
                        } else {
                          return Text('Data is empty'); // Fallback in case data is null
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
          ]
      ),
    );
  }
}