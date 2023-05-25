import 'package:flutter/material.dart';
import '../../../utils/configt.dart';
import 'package:flutter_sound/public/flutter_sound_player.dart';

class WordDetailScreen extends StatefulWidget {
  final String word;
  final String date;

  const WordDetailScreen({Key? key, required this.word, required this.date})
      : super(key: key);

  @override
  _WordDetailScreenState createState() => _WordDetailScreenState();
}

class _WordDetailScreenState extends State<WordDetailScreen> {
  String transcribedText = 'Transcribed text will appear here';
  String noteText = '';
  FlutterSoundPlayer _player = FlutterSoundPlayer();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Word Details'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Configt.app_background2), // background image
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Word: ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          widget.word,
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Text(
                          'Date: ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          widget.date,
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    // Audio player widget
                    Container(
                      width: double.infinity,
                      color: Colors.grey[200],
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: IconButton(
                          icon: Icon(_player.isPlaying ? Icons.stop : Icons.play_arrow),
                          onPressed: () {
                            if (_player.isPlaying) {
                              _player.stopPlayer();
                            } else {
                              // Start playback
                              _player.startPlayer(
                                fromURI: 'YOUR_AUDIO_FILE_URI', // Audio file URI
                              );
                            }
                            setState(() {});
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    // Transcribe button widget
                    Center(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          // transcribe audio logic here
                          setState(() {
                            // transcribed text
                            transcribedText = 'Transcribed text goes here';
                          });
                        },
                        icon: Icon(Icons.mic),
                        label: Text('Transcribe Audio'),
                      ),
                    ),
                    SizedBox(height: 16),
                    // Display transcribed text
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(4),
                      ),
                      padding: EdgeInsets.all(8),
                      child: Center(
                        child: Text(
                          transcribedText,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600], 
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    // Note text field
                    TextField(
                      onChanged: (value) {
                        setState(() {
                          noteText = value;
                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'Add a note',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 4,
                    ),
                    SizedBox(height: 16),
                    // Save note button
                    Center(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          // save note logic here
                          setState(() {
                            // note text
                            noteText = 'Note saved';
                          });
                        },
                        icon: Icon(Icons.save),
                        label: Text('Save Note'),
                      ),
                    ),
                    SizedBox(height: 8),
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
