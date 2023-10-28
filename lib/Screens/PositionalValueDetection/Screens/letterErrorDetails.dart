import 'package:flutter/material.dart';
import '../../Users/screens/homeScreen.dart';
import 'api_service.dart';
import 'markCalculation.dart';

class LetterErrorDetails extends StatefulWidget {
  final Map<String, dynamic> apiData;
  const LetterErrorDetails({Key? key, required this.apiData}) : super(key: key);

  @override
  State<LetterErrorDetails> createState() => _LetterErrorDetailsState();
}

class _LetterErrorDetailsState extends State<LetterErrorDetails> {
  List<int> getMismatchedPositions(String mostMatch, String userInput) {
    List<int> mismatchedPositions = [];

    for (int i = 0; i < mostMatch.length; i++) {
      if (i >= userInput.length || mostMatch[i] != userInput[i]) {
        mismatchedPositions.add(i);
      }
    }

    return mismatchedPositions;
  }

  late String userInput;
  late String mostMatch;
  late int wordLength;
  late int numColumns;
  late int numRows;
  late double desiredRowHeight;

  get apiCall => ApiService();

  @override
  void initState() {
    super.initState();

    mostMatch = widget.apiData['Most Match'] ?? "";
    userInput = widget.apiData['User Input'] ?? "";

    print("API Data in initState: ${widget.apiData}");
    print("Most Match: $mostMatch");
    print("User Input: $userInput");

    wordLength = mostMatch.length;
    numColumns = 2; // Set the number of columns to 2
    numRows = wordLength; // Set the number of rows to 4
    desiredRowHeight = 85.0;
  }

  @override
  Widget build(BuildContext context) {
    List<int> mismatchedPositions = getMismatchedPositions(mostMatch, userInput);
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightBlueAccent.shade100,
          elevation: 0.0,
          centerTitle: true,
          title: Text(
            'කියන ආකාරය',
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreenAll()),
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
                  image: AssetImage(
                      'assets/phonologicalAssets/background_image0.jpg'),
                  // Replace with your image path
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
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
                        )
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.all(10),
                      width: 350,
                      // Adjust the width as needed
                      height: numRows * desiredRowHeight,
                      // Replace `desiredRowHeight` with the desired height for each row
                      decoration: BoxDecoration(
                          color: Colors.lightGreenAccent.shade200,
                          // Replace with your desired color
                          borderRadius: BorderRadius.circular(40),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              // Shadow color and opacity
                              blurRadius: 5,
                              // Spread radius
                              spreadRadius: 2,
                              // Blur radius
                              offset: Offset(
                                  0, 3), // Offset in x and y direction
                            ),
                          ]
                      ),
                      child: ContainerGrid(
                        numColumns: numColumns, numRows: numRows, word: mostMatch, userInput: userInput,mismatchedPositions: mismatchedPositions,),
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
                                    builder: (context) => MarkCalculation(apiData: snapshot.data!), // data is non-null here
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
            ),
          ],
        ),
      ),
    );
  }
}

class ContainerGrid extends StatelessWidget {
  final int numColumns;
  final int numRows;
  final String word;
  final String userInput;
  final List<int> mismatchedPositions;

  ContainerGrid({
    required this.numColumns,
    required this.numRows,
    required this.word,
    required this.userInput,
    required this.mismatchedPositions,
  });

  String categorizeWord(String word) {
    String result = '';
    for (int i = 0; i < word.length; i++) {
      String letter = word[i];
      try {
        if ('අආඇ‌ාඉඊ‌ැඋඌ‌ෑඍඎඏඐඑ‌ිඒ‌ීඔඕඖ'.contains(letter)) {
          result += 'Independent vowel\n';
        } else if ('ගඝ'.contains(letter)) {
          result += 'Velar Voiced Consonant\n';
        } else if ('ජඣ'.contains(letter)) {
          result += 'Palatal Voiced Consonants\n';
        } else if ('ඩඪ'.contains(letter)) {
          result += 'Alveolar Voiced Consonants\n';
        } else if ('දධ'.contains(letter)) {
          result += 'Dental Voiced Consonants\n';
        } else if ('බභ'.contains(letter)) {
          result += 'Bilabial Voiced Consonants\n';
        }else if ('ඞ'.contains(letter)) {
          result += 'Velar Nasal Consonant\n';
        } else if ('ඤ'.contains(letter)) {
          result += 'Palatal Nasal Consonants\n';
        } else if ('ණ'.contains(letter)) {
          result += 'Alveolar Nasal Consonants\n';
        } else if ('න'.contains(letter)) {
          result += 'Dental Nasal Consonants\n';
        } else if ('ම'.contains(letter)) {
          result += 'Bilabial Nasal Consonants\n';
        } else if ('ඟ'.contains(letter)) {
          result += 'Velar Nasalised Voiced Consonant\n';
        } else if ('ඦ'.contains(letter)) {
          result += 'Palatal Nasalised Voiced Consonants\n';
        } else if ('ඬ'.contains(letter)) {
          result += 'Alveolar Nasalised Voiced Consonants\n';
        } else if ('ඳ'.contains(letter)) {
          result += 'Dental Nasalised Voiced Consonants\n';
        } else if ('ඹ'.contains(letter)) {
          result += 'Bilabial Nasalised Voiced Consonants\n';
        }else if ('යරලවශෂසහළෆ'.contains(letter)) {
          result += 'Glide or Fricative Consonants\n';
        } else if ('ඥක්‍රක්‍යර්‍'.contains(letter)) {
          result += 'Consonant cluster\n';
        } else if ('කඛ'.contains(letter)) {
          result += 'Velar Voiceless Consonant\n';
        } else if ('චඡ'.contains(letter)) {
          result += 'Palatal Voiceless Consonant\n';
        }else if ('ටඨ'.contains(letter)) {
          result += 'Alveolar Voiceless Consonant\n';
        }else if ('තථ'.contains(letter)) {
          result += 'Dental Voiceless Consonant\n';
        } else if ('පඵ'.contains(letter)) {
          result += 'Bilabial Voiceless Consonant\n';
        } else {
          result += 'Dependent Vowel\n';
        }
      } catch (e) {
        print(e);
      }
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: List.generate(numRows, (rowIndex) {
            String containerText = word.length > rowIndex ? word[rowIndex] : '';
            bool shouldHighlight = mismatchedPositions.contains(rowIndex); // use mismatchedPositions to determine highlighting
            return buildContainer(containerText, height: 60, width: 60, highlight: shouldHighlight);
          }),
        ),
        // SizedBox for spacing
        SizedBox(width: 20),
        // Second Column
        Column(
          children: List.generate(numRows, (rowIndex) {
            String containerText = '';
            if (rowIndex < word.length) {
              containerText = categorizeWord(word[rowIndex]);
            }
            return buildContainer(containerText, height: 60, width: 225);
          }),
        ),
      ],
    );
  }

  Widget buildContainer(String text, {double height = 60, double width = 225, bool highlight = false}) {
    return Container(
      margin: const EdgeInsets.all(10),
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: highlight ? Colors.red : Colors.white,
        border: Border.all(
          color: Colors.lightGreen.shade300,
          width: 3,
        ),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: highlight ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}