import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kathaappa/Screens/Users/screens/homeScreen.dart';
import 'package:kathaappa/Screens/Users/screens/loginScreen.dart';
import 'package:kathaappa/splashScreen.dart';

import 'package:provider/provider.dart';

import 'Provider/internet_provider.dart';
import 'Provider/sign_in_provider.dart';
import 'Screens/GameScreen/Game/animationScreen.dart';
import 'Screens/GameScreen/Game/dancing_screen.dart';
import 'Screens/GameScreen/Game/dataentry_screen.dart';
import 'Screens/GameScreen/Game/loserScreen.dart';
import 'Screens/GameScreen/Game/questionAnimation.dart';
import 'Screens/GameScreen/Game/question_screen.dart';
import 'Screens/GameScreen/Game/selection_screen.dart';
import 'Screens/GameScreen/Game/winnerScreen.dart';
import 'Screens/GameScreen/testing/bubbles.dart';
import 'Screens/GameScreen/testing/questionPage.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: ((context) => SignInProvider()),
        ),
        ChangeNotifierProvider(
          create: ((context) => InternetProvider()),
        )
      ],
      child:  MaterialApp(
        home: SplashScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
