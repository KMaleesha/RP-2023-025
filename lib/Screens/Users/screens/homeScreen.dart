import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_swiper_plus/flutter_swiper_plus.dart';
import 'package:lottie/lottie.dart';

import '../../../Provider/user_model.dart';
import '../../../utils/configt.dart';
import '../../GameScreen/Game/animationScreen.dart';
import '../../GameScreen/Game/dataentry_screen.dart';
import '../../GameScreen/Game/selection_screen.dart';
import '../../GameScreen/testing/questionPage.dart';
import '../../PositionalValueDetection/Screens/PositionalErrorDetection.dart';
import '../../PositionalValueDetection/Screens/letterErrorDetails.dart';
import '../../PositionalValueDetection/Screens/letterErrorDetection.dart';
import '../../PositionalValueDetection/Screens/markCalculation.dart';
import '../../TherapistManagement/screens/audio_list.dart';
import '../../TherapistManagement/screens/therapist_dashboard.dart';
import '../../ScreenTest/HomeScreen.dart';
import '../../ScreenTest/ListWords.dart';
import '../../ScreenTest/RecordScreen.dart';
import 'constants.dart';
import 'datas.dart';
import 'loginScreen.dart';

class HomeScreenAll extends StatefulWidget {
  const HomeScreenAll({super.key});

  @override
  State<HomeScreenAll> createState() => _HomeScreenAllState();
}

class _HomeScreenAllState extends State<HomeScreenAll> {
  @override
  void initState() {
    super.initState();
    fetchUserRole();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  int roleCheck = 0;
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  int role = 0;

  Future<int> fetchUserRole() async {
    print("fetchUserRole");

    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user?.uid)
        .get();

    role = userDoc.get('role') ?? 0;
    print("role $role");
    setState(() {
      roleCheck = role;
    });

    return role;
  }

  List<PlanetInfo> get displayPlanets {
    List<PlanetInfo> planets = [
      PlanetInfo(1,
          name: 'අකුරු වැරදි ',
          iconImage: Configt.letterError,
          description: "",
          images: []),
      PlanetInfo(2,
          name: 'පැවරුම්',
          iconImage: Configt.exercise,
          description: "",
          images: []),
      PlanetInfo(3,
          name: 'ගේම්ස්',
          iconImage: Configt.games,
          description: "",
          images: []),
      if (role == 0)
        PlanetInfo(4,
            name: '       ප්‍රතිචාර',
            iconImage: Configt.therapist,
            description: "",
            images: [
              // 'https://d2pn8kiwq2w21t.cloudfront.net/images/imagesmars20160421PIA00407-16.width-1320.jpg',
              // 'https://solarsystem.nasa.gov/rails/active_storage/blobs/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBBaDRTIiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--57fdc4ee44fe502a585880710f8113dd538c2a08/marspolarcrater_1600.jpg?disposition=attachment',
              // 'https://solarsystem.nasa.gov/rails/active_storage/blobs/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBBcGNSIiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--50b01c602bd1b0830fd2c2727220c4c1558e2ab5/PIA00567.jpg?disposition=attachment',
              // 'https://www.nasa.gov/sites/default/files/styles/full_width_feature/public/thumbnails/image/pia25450.jpeg',
              // 'https://www.nasa.gov/sites/default/files/styles/full_width_feature/public/thumbnails/image/pia24420.jpeg',
            ]),
      if (role == 2)
        PlanetInfo(5,
            name: ' Therapist',
            iconImage: Configt.therapist,
            description: "",
            images: [
              // 'https://d2pn8kiwq2w21t.cloudfront.net/images/imagesmars20160421PIA00407-16.width-1320.jpg',
              // 'https://solarsystem.nasa.gov/rails/active_storage/blobs/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBBaDRTIiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--57fdc4ee44fe502a585880710f8113dd538c2a08/marspolarcrater_1600.jpg?disposition=attachment',
              // 'https://solarsystem.nasa.gov/rails/active_storage/blobs/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBBcGNSIiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--50b01c602bd1b0830fd2c2727220c4c1558e2ab5/PIA00567.jpg?disposition=attachment',
              // 'https://www.nasa.gov/sites/default/files/styles/full_width_feature/public/thumbnails/image/pia25450.jpeg',
              // 'https://www.nasa.gov/sites/default/files/styles/full_width_feature/public/thumbnails/image/pia24420.jpeg',
            ]),
    ];
    return planets;
  }

  late double width, height;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: gradientEndColor,
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: height * 0.05),
            child: Row(children: <Widget>[
              Spacer(), // This will push the next widget (IconButton) to the right
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: IconButton(
                  icon: Icon(Icons.logout),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => LoginScreen(),
                    ));
                  },
                ),
              ),
            ]),
          ),
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [gradientStartColor, gradientEndColor],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 32, right: 32, top: 40),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: [
                          Text(
                            'කතා',
                            style: TextStyle(
                                fontFamily: 'Avenir',
                                fontSize: 40,
                                color: Color(0xffffffff),
                                fontWeight: FontWeight.w900),
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                      // Row(
                      //   children: [
                      //     DropdownButton(
                      //       items: const [
                      //         DropdownMenuItem(
                      //           child: Text(
                      //             'Solar System',
                      //             style: TextStyle(
                      //                 fontFamily: 'Avenir',
                      //                 fontSize: 24,
                      //                 color: Color(0x7cdbf1ff),
                      //                 fontWeight: FontWeight.w500),
                      //             textAlign: TextAlign.left,
                      //           ),
                      //         )
                      //       ],
                      //       onChanged: (value) {},
                      //       icon: Padding(
                      //         padding: const EdgeInsets.all(16.0),
                      //         child: Image.asset("assets/drop_down_icon.png"),
                      //       ),
                      //       underline: const SizedBox(),
                      //     ),
                      //   ],
                      // ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 500,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 32.0),
                    child: Swiper(
                      itemCount: displayPlanets.length,
                      fade: 0.3,
                      itemWidth: MediaQuery.of(context).size.width - 2 * 64,
                      layout: SwiperLayout.STACK,
                      pagination: SwiperPagination(
                          builder: DotSwiperPaginationBuilder(
                              activeSize: 20,
                              activeColor: Colors.yellow.shade300,
                              space: 5)),
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            if (displayPlanets[index].position == 1) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        PositionalErrorDetector()),
                              );
                            } else if (displayPlanets[index].position == 2) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomeScreen()),
                              );
                            } else if (displayPlanets[index].position == 3) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DataEntryScreen()),
                              );
                            } else if (displayPlanets[index].position == 4) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AudioList(
                                      uid:
                                          user?.uid ?? ''), // pass the uid here
                                ),
                              );
                            } else if (displayPlanets[index].position == 5) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => TherapistDashboard()),
                              );
                            }
                            // Add more conditions here for other planets
                          },
                          child: Stack(
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  const SizedBox(
                                    height: 100,
                                  ),
                                  Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(32)),
                                    elevation: 8,
                                    color: Colors.white,
                                    child: Padding(
                                      padding: const EdgeInsets.all(32.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          const SizedBox(
                                            height: 100,
                                          ),
                                          Text(
                                            displayPlanets[index]
                                                .name
                                                .toString(),
                                            style: const TextStyle(
                                                fontSize: 40,
                                                fontFamily: 'Avenir',
                                                color: Color(0xff47455f),
                                                fontWeight: FontWeight.w900),
                                            textAlign: TextAlign.left,
                                          ),
                                          // Text(
                                          //   "Solar System",
                                          //   style: TextStyle(
                                          //       fontSize: 23,
                                          //       fontFamily: 'Avenir',
                                          //       color: primaryTextColor,
                                          //       fontWeight: FontWeight.w400),
                                          //   textAlign: TextAlign.left,
                                          // ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 32.0),
                                            child: Row(
                                              children: [
                                                Text(
                                                  "ක්ලික් කරන්න",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontFamily: 'Avenir',
                                                      color: secondaryTextColor,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                  textAlign: TextAlign.left,
                                                ),
                                                Icon(
                                                  Icons.arrow_forward_rounded,
                                                  color: secondaryTextColor,
                                                  size: 18,
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Hero(
                                  tag: displayPlanets[index].position,
                                  child: Image.asset(displayPlanets[index]
                                      .iconImage
                                      .toString()))
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
