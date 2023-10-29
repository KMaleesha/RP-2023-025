import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import '../model/patient_model.dart';
import '../model/audio_model.dart';
import '../../../../utils/configt.dart';
import 'patient_audio.dart';

class PatientProfileScreen extends StatefulWidget {
  final Patient patient;

  const PatientProfileScreen({Key? key, required this.patient})
      : super(key: key);

  @override
  _PatientProfileScreenState createState() => _PatientProfileScreenState();
}

class _PatientProfileScreenState extends State<PatientProfileScreen> {
  late Future<List<AudioModel>> audioListFuture;

  @override
  void initState() {
    super.initState();
    audioListFuture = getAudios(widget.patient.uid);
  }

  Future<List<AudioModel>> getAudios(String patientUid) async {
    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(patientUid)
        .collection('audios')
        .get();

    List<AudioModel> audios = snapshot.docs.map((doc) {
      return AudioModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
    }).toList();

    audios.sort((a, b) {
      // Move audios with feedback to the end
      if (a.feedback!.isNotEmpty && b.feedback!.isEmpty) {
        return 1;
      }
      if (a.feedback!.isEmpty && b.feedback!.isNotEmpty) {
        return -1;
      }

      // If feedback status is the same, sort by date in descending order
      return b.date!.compareTo(a.date!);
    });

    return audios;
  }

  void refreshList() {
    setState(() {
      audioListFuture = getAudios(widget.patient.uid);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Patient Profile'),
      ),
      body: FutureBuilder<List<AudioModel>>(
        future: getAudios(widget.patient.uid),
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
                Card(
                  elevation: 2,
                  margin: EdgeInsets.all(16),
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Name:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              Text(
                                '${widget.patient.name ?? "Not specified"}',
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Age:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              Text(
                                '${widget.patient.age ?? "Not specified"}',
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Mobile:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              Text(
                                '${widget.patient.mobile ?? "Not specified"}',
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Patient Since:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              Text(
                                widget.patient.patientSince != null
                                    ? DateFormat('yyyy-MM-dd').format(
                                        widget.patient.patientSince!.toDate())
                                    : "Not specified",
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
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
                    child: Center(child: Text('No Audios to Display')),
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
                                  Icon(Icons.done_all,
                                      color: Colors.green), // Double-tick icon
                              ],
                            ),
                            onTap: () async {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => WordDetailScreen(
                                    patientUid: widget.patient.uid,
                                    documentId: audio.id,
                                    patient: widget.patient,
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
