import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './add_patient.dart';
import './patient_profile.dart';
import '../model/patient_model.dart';
import '../../../../utils/configt.dart';

class TherapistDashboard extends StatefulWidget {
  const TherapistDashboard({Key? key}) : super(key: key);

  @override
  TherapistDashboardState createState() => TherapistDashboardState();
}

class TherapistDashboardState extends State<TherapistDashboard> {
  List<Patient> originalPatients = []; 
  List<Patient> filteredPatients = [];
  late double width, height;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    searchController.addListener(filterPatients);
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  Future<List<Patient>> _fetchPatientsFromDatabase() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('patients')
        .get();

    List<Patient> tempPatients = [];
    for (var doc in querySnapshot.docs) {
      if (doc.data() is Map<String, dynamic>) {
        tempPatients.add(Patient.fromMap(doc.data()! as Map<String, dynamic>));
      }
    }

    return tempPatients;
  }

  void filterPatients() {
    String query = searchController.text.toLowerCase();
    setState(() {
      filteredPatients = originalPatients.where((patient) {
        // Filter based on original list
        final nameLower = patient.name?.toLowerCase(); 
        final ageLower = patient.age?.toString().toLowerCase() ?? "";
        return nameLower!.contains(query) || ageLower.contains(query);
      }).toList();
    });
  }

  void navigateToPatientProfile(Patient patient) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PatientProfileScreen(patient: patient),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text('Therapist Dashboard'),
      ),
      body: FutureBuilder<List<Patient>>(
        future: _fetchPatientsFromDatabase(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          originalPatients = snapshot.data!;
          filteredPatients = List.from(originalPatients);

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
                        hintText: 'Search Patients...',
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
                          navigateToPatientProfile(filteredPatients[index]);
                        },
                        child: Card(
                          elevation: 2,
                          margin: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          child: ListTile(
                            title: Text(filteredPatients[index].name ?? ''),
                            subtitle:
                                Text('Age: ${filteredPatients[index].age}'),
                          ),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddPatient(
                onPatientAdded: () {
                  setState(() {}); // Trigger a rebuild
                },
              ),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
