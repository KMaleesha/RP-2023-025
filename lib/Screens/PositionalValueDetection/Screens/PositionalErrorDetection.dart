import 'package:flutter/material.dart';
import 'letterErrorDetection.dart';
import '../Model/PositionalValuesModel.dart';
import '../../Users/screens/homeScreen.dart';
import 'api_service.dart';

class PositionalErrorDetector extends StatefulWidget {
  final Map<String, dynamic> apiData;

  PositionalErrorDetector({Key? key, required this.apiData}) : super(key: key);

  @override
  State<PositionalErrorDetector> createState() => _PositionalErrorDetectorState();
}

class _PositionalErrorDetectorState extends State<PositionalErrorDetector> {
  late double height, width;
  late String userInput;
  late String mostMatch;
  late String positionInfoLastPart;
  late String initialValue;
  late String middleValue;
  late String endValue;
  String? trimmedPositionInfo;


  get apiCall => ApiService();

  // void _updatePositionInfo() {
  //   setState(() {
  //     List<String> options = ['initial', 'middle', 'end', 'N/A'];
  //     positionInfoLastPart = (options..shuffle()).first;
  //   });
  //   print("New position info: $positionInfoLastPart");
  // }

  @override
  void initState() {
    super.initState();

    // Access apiData right after the state object is created
    mostMatch = widget.apiData['Most Match'];
    userInput = widget.apiData['User Input'];

    if (widget.apiData['Position Info'] is List) {
      var positionInfo = widget.apiData['Position Info'][0].split(':').last;
      positionInfoLastPart = positionInfo;
    } else {
      // Handle other cases, if necessary.
      positionInfoLastPart = "N/A";
    }

    // Initialize trimmedPositionInfo here
    trimmedPositionInfo = positionInfoLastPart.trim();

    // Break the user input into initial, middle, and end portions.
    if (userInput.length > 2) { // Assuming word has at least 3 characters
      initialValue = userInput[0]; // First character
      middleValue = userInput.substring(1, userInput.length - 1); // Middle part excluding first and last characters
      endValue = userInput[userInput.length - 1]; // Last character
    } else {
      // Handle shorter words as you see fit.
      // Here, I'm just setting all values to be the same as the user input.
      initialValue = userInput;
      middleValue = userInput;
      endValue = userInput;
    }
    // Access apiData right after the state object is created
    print("API Data in initState: ${widget.apiData}");
    print("Most Match: $mostMatch");
    print("User Input: $userInput");
    print("Initial Value: $initialValue");
    print("Middle Value: $middleValue");
    print("End Value: $endValue");
    print("positionInfo: $positionInfoLastPart");
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
          'අකුරු වැරදි',
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
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _updatePositionInfo, // Update `positionInfoLastPart` when pressed
      //   child: Icon(Icons.refresh),
      // ),
      body: Stack(
          children:[
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/phonologicalAssets/background_image.jpg'), // Replace with your image path
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
                        color: Colors.yellowAccent.shade100,
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
                                  mostMatch,
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
                                  color: Colors.yellow,
                                  width: 3,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  initialValue,
                                  style:  TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
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
                                  color: Colors.yellow,
                                  width: 3,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  middleValue,
                                  style:  TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
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
                                  color: Colors.yellow,
                                  width: 3,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  endValue,
                                  style:  TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
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
                              child: Icon(
                                trimmedPositionInfo == 'initial'
                                    ? Icons.highlight_off_rounded
                                    : Icons.check_circle_rounded,
                                size: 40,
                                color: trimmedPositionInfo == 'initial' ? Colors.red : Colors.green,
                              ),
                            ),
                            Container(
                              child: Icon(
                                trimmedPositionInfo == 'middle'
                                    ? Icons.highlight_off_rounded
                                    : Icons.check_circle_rounded,
                                size: 40,
                                color: trimmedPositionInfo == 'middle' ? Colors.red : Colors.green,
                              ),
                            ),
                            Container(
                              child: Icon(
                                trimmedPositionInfo == 'end'
                                    ? Icons.highlight_off_rounded
                                    : Icons.check_circle_rounded,
                                size: 40,
                                color: trimmedPositionInfo == 'end' ? Colors.red : Colors.green,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: 150, // Adjust the width as needed
                    height: 50,
                    child: FutureBuilder<Map<String, dynamic>>(
                      future: apiCall.fetchPost(userInput), // This should return a Future<Map<String, dynamic>>
                      builder: (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          return ElevatedButton(
                            onPressed: () {
                              if (snapshot.data != null) {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => LetterErrorDetector(apiData: snapshot.data!),
                                  ),
                                );
                              }
                            }, // Closing parenthesis was missing here
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
                        }
                      },
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
