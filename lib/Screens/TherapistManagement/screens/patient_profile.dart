import 'package:flutter/material.dart';
import '../../../../utils/configt.dart';
import '../model/patient_model.dart';
import 'patient_word.dart';

class PatientProfileScreen extends StatelessWidget {
  final Patient patient;

  const PatientProfileScreen({Key? key, required this.patient})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    void handleWordTap(String word, String date) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => WordDetailScreen(word: word, date: date),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Patient Profile'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Configt.app_background2),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              elevation: 2,
              margin: EdgeInsets.all(16),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage('assets/logo.jpg'), // Avatar image
                    ),
                    SizedBox(width: 16), // Add spacing between avatar and patient details
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            child: Text(
                              'Patient Name:',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 16),
                            child: Text(
                              patient.name,
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            child: Text(
                              'Age:', // Changed "Condition" to "Age"
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 16),
                            child: Text(
                              patient.age.toString(),
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          // Patient profile details
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Card(
                  elevation: 2,
                  margin: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Word',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              'Date',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: patient.wordList.length,
                          itemBuilder: (context, index) {
                            final word = patient.wordList[index].word;
                            final date = patient.wordList[index].date;
                            return ListTile(
                              onTap: () => handleWordTap(word, date),
                              title: Row(
                                children: [
                                  Expanded(child: Text(word)),
                                  Text(date),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
