import 'package:flutter/material.dart';
import 'patient_model.dart';
import 'patient_profile.dart';
import '../../../utils/configt.dart';

class PatientDashboard extends StatefulWidget {
  const PatientDashboard({Key? key}) : super(key: key);

  @override
  State<PatientDashboard> createState() => PatientDashboardState();
}

class PatientDashboardState extends State<PatientDashboard> {
  List<Patient> patients = [
    Patient(
      name: 'Saman Kumara',
      age: 2,
      wordList: [
        PatientWord(word: 'සමනලයා', date: '06-05-2023'),
        PatientWord(word: 'බල්ලා', date: '04-05-2023'),
      ],
    ),
    Patient(
      name: 'Kamal Perera',
      age: 3,
      wordList: [
        PatientWord(word: 'මකුළුවා', date: '20-05-2023'),
        PatientWord(word: 'බල්ලා', date: '10-05-2023'),
      ],
    ),
    Patient(
      name: 'Minindu Peiris',
      age: 4,
      wordList: [
        PatientWord(word: 'වඳුරා', date: '10-05-2023'),
        PatientWord(word: 'සමනලයා', date: '06-05-2023'),
      ],
    ),
  ];

  late double width, height;
  TextEditingController searchController = TextEditingController();
  List<Patient> filteredPatients = [];

  @override
  void initState() {
    super.initState();
    filteredPatients = patients;
    searchController.addListener(filterPatients);
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void filterPatients() {
    String query = searchController.text.toLowerCase();
    setState(() {
      filteredPatients = patients.where((patient) {
        final nameLower = patient.name.toLowerCase();
        final ageString = patient.age.toString(); 
        final ageLower = ageString.toLowerCase(); 
        return nameLower.contains(query) || ageLower.contains(query); 
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
        title: Text('Patient Dashboard'),
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
                      margin:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: ListTile(
                        title: Text(filteredPatients[index].name),
                        subtitle: Text(
                            'Age: ${filteredPatients[index].age}'),
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
          // Handle the onPressed event for the floating action button
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
