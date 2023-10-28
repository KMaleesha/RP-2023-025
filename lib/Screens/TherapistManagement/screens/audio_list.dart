import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import '../model/patient_model.dart';
import '../model/audio_model.dart';
import '../../../../utils/configt.dart';
import 'audio_one.dart';
import 'patient_audio.dart';

class AudioList extends StatefulWidget {
  final String uid;

  AudioList({required this.uid});

  @override
  _AudioListState createState() => _AudioListState();
}

class _AudioListState extends State<AudioList> {
  late Future<List<AudioModel>> audioListFuture;

  @override
  void initState() {
    super.initState();
    audioListFuture = getAudios(widget.uid);
  }

  Future<List<AudioModel>> getAudios(String Uid) async {
    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(Uid)
        .collection('audios')
        .get();

    List<AudioModel> audios = snapshot.docs.map((doc) {
      return AudioModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
    }).toList();

    audios.sort((a, b) {
      // Move audios with feedback to the end
      if (a.feedback!.isNotEmpty && b.feedback!.isEmpty) {
        return -1;
      }
      if (a.feedback!.isEmpty && b.feedback!.isNotEmpty) {
        return 1;
      }

      // If feedback status is the same, sort by date in descending order
      return b.date!.compareTo(a.date!);
    });

    return audios;
  }

  void refreshList() {
    setState(() {
      audioListFuture = getAudios(widget.uid);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ඔබේ පටිගත කිරීම්'),
      ),
      body: FutureBuilder<List<AudioModel>>(
        future: getAudios(widget.uid),
        builder: (context, snapshot) {
          return Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Configt.app_background2),
                fit: BoxFit.fill,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (snapshot.connectionState == ConnectionState.waiting)
                  Expanded(
                    child: Center(child: CircularProgressIndicator()),
                  )
                else if (snapshot.hasError)
                  Expanded(
                    child: Center(child: Text('Error: ${snapshot.error}')),
                  )
                else if (snapshot.data!.isEmpty)
                  Expanded(
                    child: Center(child: Text('පටිගත කිරීම් නොමැත')),
                  )
                else
                  Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final audio = snapshot.data![index];
                        final formattedDate = audio.date != null
                            ? DateFormat('yyyy-MM-dd hh:mm a')
                                .format(audio.date!)
                            : "Unknown date";
                        return Card(
                          elevation: 2,
                          margin:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: ListTile(
                            title: Text('${audio.word ?? "Unknown word"}'),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(formattedDate),
                                if (audio.feedback != '')
                                  Icon(Icons.feedback,
                                      color: Colors.green), // Double-tick icon
                              ],
                            ),
                            onTap: () async {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AudioOne(
                                    patientUid: widget.uid,
                                    documentId: audio.id,
                                  ),
                                ),
                              );
                              refreshList(); // Refresh the list when you return from WordDetailScreen
                            },
                          ),
                        );
                      },
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
