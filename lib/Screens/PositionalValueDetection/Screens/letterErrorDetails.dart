import 'package:flutter/material.dart';

import 'markCalculation.dart';

class LetterErrorDetails extends StatefulWidget {
  const LetterErrorDetails({Key? key}) : super(key: key);

  @override
  State<LetterErrorDetails> createState() => _LetterErrorDetailsState();
}

class _LetterErrorDetailsState extends State<LetterErrorDetails> {
  final String word = "KATHA"; // Replace "example" with your given word
  late int wordLength;
  late int numColumns;
  late int numRows;
  late double desiredRowHeight;

  @override
  void initState() {
    super.initState();
    wordLength = word.length;
    numColumns = 2; // Set the number of columns to 2
    numRows = wordLength; // Set the number of rows to 4
    desiredRowHeight = 85.0;
  }

  @override
  Widget build(BuildContext context) {
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
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.all(10),
                      width: 350, // Adjust the width as needed
                      height: numRows * desiredRowHeight, // Replace `desiredRowHeight` with the desired height for each row
                      decoration: BoxDecoration(
                        color: Colors.blue.shade300, // Replace with your desired color
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
                      child: ContainerGrid(numColumns: numColumns, numRows: numRows, word: word),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      width: 150, // Adjust the width as needed
                      height: 50, // Adjust the height as needed
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MarkCalculation()),
                          );
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

  ContainerGrid({required this.numColumns, required this.numRows, required this.word});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: List.generate(numRows, (rowIndex) {
            String containerText = word.length > rowIndex ? word[rowIndex] : '';

            return Container(
              margin: const EdgeInsets.all(10),
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Center(
                child: Text(containerText),
              ),
            );
          }),
        ),
        // Add a SizedBox to create space between the columns
        Expanded(
          child: Column(
            children: List.generate(numRows, (_) {
              return Container(
                margin: const EdgeInsets.all(10),
                width: 250,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}
