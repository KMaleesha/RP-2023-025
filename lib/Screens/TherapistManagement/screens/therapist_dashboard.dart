import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'add_patient.dart';
import '../model/patient_model.dart';
import 'patient_profile.dart';
import '../../../../utils/configt.dart';

class TherapistDashboard extends StatefulWidget {
  const TherapistDashboard({Key? key}) : super(key: key);

  @override
  TherapistDashboardState createState() => TherapistDashboardState();
}

class TherapistDashboardState extends State<TherapistDashboard> {
  List<Patient> filteredPatients = [];
  late double width, height;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchPatientsFromDatabase();
    searchController.addListener(filterPatients);
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  Future<void> _fetchPatientsFromDatabase() async {
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

    setState(() {
      filteredPatients = tempPatients;
    });
  }

  void filterPatients() {
    String query = searchController.text.toLowerCase();
    setState(() {
      filteredPatients = filteredPatients.where((patient) {
        final uidLower = patient.uid?.toLowerCase() ?? ""; // null check here
        final ageLower =
            patient.age?.toString().toLowerCase() ?? ""; // null check here
        final mobileLower =
            patient.mobile?.toLowerCase() ?? ""; // null check here
        return uidLower.contains(query) ||
            ageLower.contains(query) ||
            mobileLower.contains(query);
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
      body: Container(
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
                    hintText: 'Search patients...',
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
                      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: ListTile(
                        title: Text(filteredPatients[index].uid),
                        subtitle: Text(
                            'Age: ${filteredPatients[index].age} \nMobile: ${filteredPatients[index].mobile}'),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddPatient(
                onPatientAdded: () {
                  _fetchPatientsFromDatabase();
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
