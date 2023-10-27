import '../../../../utils/configt.dart';
import '../model/patient_model.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddPatient extends StatefulWidget {
  final Function? onPatientAdded;
  AddPatient({this.onPatientAdded});

  @override
  _AddPatientState createState() => _AddPatientState();
}

class _AddPatientState extends State<AddPatient> {
  User? doctorUser = FirebaseAuth.instance.currentUser;
  List<String> currentPatients = [];
  List<Map<String, dynamic>> availablePatients = [];
  TextEditingController searchController = TextEditingController();
  List<Map<String, dynamic>> filteredPatients = [];

  late Future<void> dataFuture;

  @override
  void initState() {
    super.initState();
    dataFuture = _getDoctorPatients();
    searchController.addListener(filterPatients);
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  Future<void> _getDoctorPatients() async {
    currentPatients.clear(); 
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(doctorUser?.uid)
        .collection('patients')
        .get();

    for (var doc in querySnapshot.docs) {
      currentPatients.add(doc.id);
    }
    await _getAvailablePatients();
  }

  Future<void> _getAvailablePatients() async {
    availablePatients.clear();
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('role', isEqualTo: 0)
        .get();

    for (var doc in querySnapshot.docs) {
      if (!currentPatients.contains(doc.id)) {
        if (doc.data() is Map<String, dynamic>) {
          availablePatients.add(doc.data()! as Map<String, dynamic>);
        }
      }
    }
    setState(() {
      filteredPatients = availablePatients;
    });
  }

  Future<void> _addPatientToDatabase(Patient patient) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(doctorUser?.uid)
        .collection('patients')
        .doc(patient.uid)
        .set(patient.toMap());

    if (widget.onPatientAdded != null) {
      widget.onPatientAdded!();
    }

    Navigator.pop(context);
  }

  void filterPatients() {
    String query = searchController.text.toLowerCase();
    setState(() {
      filteredPatients = availablePatients.where((patient) {
        final emailLower = patient['email'].toString().toLowerCase();
        return emailLower.contains(query);
      }).toList();
    });
  }

  void onTapPatient(Map<String, dynamic> patientData) async {
    int age = 0;
    String name = "";
    String mobile = "";

    GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Patient Details'),
          content: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Name'),
                    onChanged: (value) {
                      name = value;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Age'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          !RegExp(r'^\d+$').hasMatch(value)) {
                        return 'Please enter a valid age';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      age = int.parse(value);
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Mobile No'),
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          !RegExp(r'^\d{10}$').hasMatch(value)) {
                        return 'Please enter a valid 10 digit mobile number';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      mobile = value;
                    },
                  ),
                ],
              ),
            ),
          ),
          actions: [
            Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                child: Text('Add'),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    Patient newPatient = Patient(
                        uid: patientData['uid'],
                        name: name,
                        age: age,
                        mobile: mobile);
                    await _addPatientToDatabase(newPatient);
                    Navigator.pop(context);

                    // Explicitly reloading the patients after adding.
                    await _getDoctorPatients();
                  }
                },
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Patient'),
      ),
      body: FutureBuilder<void>(
        future: dataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(Configt.app_background2),
                  fit: BoxFit.fill,
                ),
              ),
              child: Column(
                children: [
                  Card(
                    margin: EdgeInsets.all(16),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: TextField(
                        controller: searchController,
                        decoration: InputDecoration(
                          hintText: 'Search Available Patients...',
                          border: InputBorder.none,
                        ),
                        onChanged: (value) {
                          filterPatients();
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: filteredPatients.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            onTapPatient(filteredPatients[index]);
                          },
                          child: Card(
                            elevation: 2,
                            margin: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            child: ListTile(
                              title: Text(filteredPatients[index]['email']),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
