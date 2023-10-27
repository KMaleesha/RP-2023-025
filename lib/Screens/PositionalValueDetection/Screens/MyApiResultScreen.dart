import 'package:flutter/material.dart';
import '../../Users/screens/homeScreen.dart';
import 'PositionalErrorDetection.dart';
import 'api_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyApiResultScreen extends StatefulWidget {
  @override
  _MyApiResultScreenState createState() => _MyApiResultScreenState();
}

class _MyApiResultScreenState extends State<MyApiResultScreen> {
  final ApiService apiService = ApiService();

  Future<Map<String, dynamic>> fetchLatestTranscribedTextAndMakeApiCall() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final User? user = _auth.currentUser;

    if (user == null) {
      // Handle the situation where the user is not logged in.
      throw Exception('User not logged in.');
    }

    final String uid = user.uid;
    final FirebaseFirestore _db = FirebaseFirestore.instance;

    QuerySnapshot querySnapshot = await _db
        .collection('users')
        .doc(uid)  // Replacing 'yourUserId' with the actual user ID
        .collection('audios')
        .orderBy('date', descending: true)
        .limit(1)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      Map<String, dynamic> latestAudio = querySnapshot.docs.first.data() as Map<String, dynamic>;
      String transcribedText = latestAudio['transcribedtext'];
      return await apiService.fetchPost(transcribedText);
    }
    // Handle the error case when the document is not found.
    throw Exception('No latest transcribed text found.');
  }

  Future<Map<String, dynamic>> get apiCall => fetchLatestTranscribedTextAndMakeApiCall();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent.shade100,
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          'ප්‍රතිඵල',
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
        actions: [
          IconButton(
            icon: Icon(
              Icons.home,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => HomeScreenAll(),
                ),
              );
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/phonologicalAssets/backgroud1.jpeg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Main content
          Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Other content above the blue container
                  Center(
                    child: Container(
                      width: 350,
                      height: 450,
                      decoration: BoxDecoration(
                        color: Colors.purple.shade200,
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
                      child: FutureBuilder<Map<String, dynamic>>(
                        future: apiCall,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  width: 300,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.white54,
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: Colors.white30,
                                      width: 3,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'User Input: ${snapshot.data!['User Input']}',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 300,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.white54,
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: Colors.white30,
                                      width: 3,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Most Match : ${snapshot.data!['Most Match']}',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 300,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.white54,
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: Colors.white30,
                                      width: 3,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Differing Letters: ${snapshot.data!['Differing Letters']}',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 300,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.white54,
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: Colors.white30,
                                      width: 3,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Position Info: ${snapshot.data!['Position Info'][0].split(':').last}',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 300,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.white54,
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: Colors.white30,
                                      width: 3,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Marks: ${((snapshot.data!['Most Match'].length - snapshot.data!['Differing Letters'].length) / snapshot.data!['Most Match'].length * 100).toStringAsFixed(2)}%',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 160,
                                  height: 90,
                                  padding: const EdgeInsets.all(18.0),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      if (snapshot.data != null) {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) => PositionalErrorDetector(apiData: snapshot.data!),
                                          ),
                                        );
                                      }
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
                                  ),
                                ),
                              ],
                            );
                          }
                        },
                      ),
                    ),
                  ),
                  // Button at the bottom

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
