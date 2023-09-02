import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import '../model/audio_model.dart';
import '../../../../utils/configt.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'dart:async'; 

class WordDetailScreen extends StatefulWidget {
  final String patientUid;
  final String documentId;

  const WordDetailScreen({
    Key? key,
    required this.patientUid,
    required this.documentId,
  }) : super(key: key);

  @override
  _WordDetailScreenState createState() => _WordDetailScreenState();
}

class _WordDetailScreenState extends State<WordDetailScreen> {
  String transcribedText = 'Transcribed text will appear here';
  String noteText = '';
  TextEditingController feedbackController = TextEditingController();
  FlutterSoundPlayer _player = FlutterSoundPlayer();
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _player.openAudioSession();
  }

  @override
  void dispose() {
    _player.closeAudioSession();
    super.dispose();
  }

  Future<AudioModel> getAudioDetail() async {
    final DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.patientUid)
        .collection('audios')
        .doc(widget.documentId)
        .get();

    return AudioModel.fromMap(
        snapshot.data() as Map<String, dynamic>, snapshot.id);
  }

  Future<void> startPlayback(String url) async {
    await _player.startPlayer(
      fromURI: url,
      whenFinished: () {
        setState(() {
          _isPlaying = false;
        });
      },
    );
    setState(() {
      _isPlaying = true;
    });
  }

  Future<void> stopPlayback() async {
    await _player.stopPlayer();
    setState(() {
      _isPlaying = false;
    });
  }

  Future<String> transcribeAudio() async {
    await Future.delayed(Duration(seconds: 2)); 
    return 'This is the transcribed text from the dummy API';
  }

  Future<void> saveFeedback() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.patientUid)
        .collection('audios')
        .doc(widget.documentId)
        .update({'feedback': feedbackController.text});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Audio Details'),
      ),
      body: FutureBuilder<AudioModel>(
        future: getAudioDetail(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final audio = snapshot.data!;
          feedbackController.text = audio.feedback ?? '';
          final formattedDate = audio.date != null
              ? DateFormat('yyyy-MM-dd hh:mm a').format(audio.date!)
              : "Unknown date";

          return Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Configt.app_background2),
                fit: BoxFit.fill,
              ),
            ),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Card for Audio Details
                        Card(
                          elevation: 2,
                          margin: EdgeInsets.all(16),
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween, 
                                  children: [
                                    Text(
                                      'Word: ',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                    Text(
                                      audio.word ?? "Unknown",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 16),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween, 
                                  children: [
                                    Text(
                                      'Date: ',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                    Text(
                                      formattedDate,
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 16),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween, 
                                  children: [
                                    Text(
                                      'System Generated Result: ',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                    Text(
                                      audio.result == null
                                          ? 'Not Generated'
                                          : (audio.result == true
                                              ? 'Correct '
                                              : 'Incorrect '),
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    Icon(
                                      audio.result == null
                                          ? Icons.help
                                          : (audio.result == true
                                              ? Icons.check_circle
                                              : Icons.cancel),
                                      color: audio.result == null
                                          ? Colors.grey
                                          : (audio.result == true
                                              ? Colors.green
                                              : Colors.red),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 16),
                                Center(
                                  child: IconButton(
                                    icon: Icon(
                                      _isPlaying
                                          ? Icons.stop
                                          : Icons.play_arrow,
                                    ),
                                    iconSize: 48,
                                    color: Colors.greenAccent,
                                    onPressed: _isPlaying
                                        ? stopPlayback
                                        : () => startPlayback(audio.url ?? ""),
                                  ),
                                ),
                                Center(
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      String transcribed =
                                          await transcribeAudio(); 
                                      setState(() {
                                        transcribedText =
                                            transcribed; // Update the transcribed text
                                      });
                                    },
                                    child: Text("Transcribe Audio"),
                                  ),
                                ),
                                SizedBox(height: 16),
                                Center(
                                  child: Text(
                                    '$transcribedText',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        // Second Card for Feedback
                        Card(
                          elevation: 2,
                          margin: EdgeInsets.all(16),
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextField(
                                  controller: feedbackController,
                                  decoration: InputDecoration(
                                    hintText: "Add feedback here",
                                    border: OutlineInputBorder(),
                                  ),
                                  maxLines: 3,
                                ),
                                SizedBox(height: 16),
                                Center(
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      await saveFeedback();
                                      Fluttertoast.showToast(
                                        msg: 'Feedback Added Successfully',
                                        toastLength: Toast.LENGTH_LONG,
                                        gravity: ToastGravity.BOTTOM,
                                      );
                                      Navigator.pop(context); // Navigate back
                                    },
                                    child: Text("Save"),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
