import 'package:Katha/Screens/Users/screens/signUpScreen.dart';
import 'package:Katha/Screens/Users/screens/userHomeScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../../../Provider/sign_in_provider.dart';
import '../../../utils/configt.dart';
import '../../../utils/next_Screen.dart';
import '../../ScreenTest/HomeScreen.dart';
import 'homeScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Future<bool> _onWillPop() async {
    return false;
  }

  //firebase
  final _auth = FirebaseAuth.instance;

  //form key
  final _formKey = GlobalKey<FormState>();

  //editing controller
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    //email field
    final emailField = SizedBox(
      width: width * 0.90,
      child: TextFormField(
          autofocus: false,
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            if (value!.isEmpty) {
              return ("Please Enter Your Email");
            }
            //reg expression for email validation
            if (!RegExp(
                    "^[a-zA-Z0-9.a-zA-Z0-9.!#%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                .hasMatch(value)) {
              return ("Please Enter Valid Email");
            }
            return null;
          },
          onSaved: (value) {
            emailController.text = value!;
          },
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.mail),
            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            hintText: "Email",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          )),
    );

    //password field
    final passwordField = SizedBox(
      width: width * 0.90,
      child: TextFormField(
          autofocus: false,
          controller: passwordController,
          obscureText: true,
          validator: (value) {
            RegExp regex = new RegExp(r'^.{6,}$');
            if (value!.isEmpty) {
              return ("Password is required for login ");
            }
            if (!regex.hasMatch(value)) {
              return ("Enter Valid Password(Min 6 Characters)");
            }
          },
          onSaved: (value) {
            passwordController.text = value!;
          },
          textInputAction: TextInputAction.done,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.vpn_key),
            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            hintText: "Password",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          )),
    );

    final loginButton = SizedBox(
      width: width * 0.90,
      child: Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(30),
        color: Color(0xFF175c4c),
        child: MaterialButton(
          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () {
            signIn(emailController.text, passwordController.text);
          },
          child: const Text(
            "පිවිසෙන්න",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(

        body: SafeArea(
          child: Container(
            decoration:  BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(Configt.loginImage),
                  fit: BoxFit.fill,)
            ),
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
              image: AssetImage(Configt.bAnimation),
                  fit: BoxFit.fitHeight,)
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 65),

                    Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          const Text(
                            "පිවිසෙන්න",
                            style: TextStyle(
                              fontSize: 24.0,
                              color: Colors.black,

                              decorationColor: Colors.redAccent,
                              // fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5),
                          SizedBox(height: 245,
                          child: Container(
                            color: Colors.white10,
                            child: Center(
                              child: Lottie.asset(Configt.rabbit,
                                fit: BoxFit.contain,

                              ),
                            ),
                          ), ),

                          SizedBox(height: 25),
                          emailField,
                          SizedBox(height: 25),
                          passwordField,
                          SizedBox(height: 35),
                          Padding(
                            padding: EdgeInsets.only(left: width * 0.05),
                            child: Row(
                              children: <Widget>[
                                RichText(
                                  text: TextSpan(
                                    text: "මම අලුත් පරිශීලකයෙක්, ",
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.black,fontWeight: FontWeight.bold),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: 'ගිණුමක් සාදන්න',

                                          recognizer: new TapGestureRecognizer()
                                            ..onTap = () => Navigator.of(context)
                                                .pushReplacement(MaterialPageRoute(
                                                    builder: (context) =>
                                                        SignUpScreen())),
                                          style: const TextStyle(
                                              color: Color(0xFF175c4c),
                                              decoration: TextDecoration.underline,
                                              height: 1.2)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          loginButton,
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    // Image.asset(
                    //   "assets/divider_or.png",
                    // ),
                    const SizedBox(
                      height: 230,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }


  //handle After SignIn
  handleAfterSignIn() {
    Future.delayed(const Duration(milliseconds: 1000)).then((value) {
      nextScreenReplace(context,  HomeScreen());
    });
  }


  void signIn(String email, String password) async {
    User? user = _auth.currentUser;
    final sp = context.read<SignInProvider>();

    if (_formKey.currentState!.validate()) {
      await _auth.signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        sp.setSignIn();
        Fluttertoast.showToast(msg:"Login Successful");
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomeScreenAll()));
      })
          .catchError((e) {
        if (e is FirebaseAuthException && e.code == 'wrong-password') {

          Fluttertoast.showToast(msg:"Incorrect password");

        } else {
          Fluttertoast.showToast(msg: e!.message);
        }
      });
    }
  }
}
