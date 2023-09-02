import 'package:Katha/splashScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'Provider/internet_provider.dart';
import 'Provider/sign_in_provider.dart';
import 'Screens/GameScreen/Game/testing/dancing_screen.dart';
import 'Screens/GameScreen/Game/questionAnimation.dart';
import 'Screens/GameScreen/Game/testing/questionPage.dart';
import 'Screens/GameScreen/Game/testing/question_screen.dart';
import 'Screens/ScreenTest/Correct.dart';
import 'Screens/ScreenTest/InCorrect.dart';
import 'Screens/ScreenTest/HowToSpeak.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
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
      child:  const MaterialApp(
        home: SplashScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
