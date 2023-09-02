import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';


import '../../../Provider/sign_in_provider.dart';
import '../../../provider/user_model.dart';
import '../../../utils/configt.dart';
import '../../../utils/next_Screen.dart';
import 'homeScreen.dart';
import 'loginScreen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  Future<bool> _onWillPop() async {
    return false;
  }

  final _auth = FirebaseAuth.instance;

  //our form key
  final _formkey = GlobalKey<FormState>();
  final GlobalKey _scaffoldKey = GlobalKey<ScaffoldState>();
  //editing Controller
  final emailEditingController = new TextEditingController();
  final passwordEditingController = new TextEditingController();
  final confirmPasswordEditingController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    //email  field
    final emailField = SizedBox(
      width: width * 0.90,
      child: TextFormField(
          autofocus: false,
          controller: emailEditingController,
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
            emailEditingController.text = value!;
          },
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.mail),
            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            hintText: "Email",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          )),
    );
    //password  field
    final passwordField = SizedBox(
      width: width * 0.90,
      child: TextFormField(
          autofocus: false,
          controller: passwordEditingController,
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
            passwordEditingController.text = value!;
          },
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.vpn_key),
            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            hintText: "Password",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          )),
    );
    //confirm Password  field
    final confirmPasswordField = SizedBox(
      width: width * 0.90,
      child: TextFormField(
          autofocus: false,
          controller: confirmPasswordEditingController,
          obscureText: true,
          validator: (value) {
            if (confirmPasswordEditingController.text !=
                passwordEditingController.text) {
              return ("Password don't match");
            }
            return null;
          },
          onSaved: (value) {
            confirmPasswordEditingController.text = value!;
          },
          textInputAction: TextInputAction.done,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.vpn_key),
            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            hintText: "Confirm Password",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          )),
    );
    //signUp button
    final signUpButton = SizedBox(
      width: width * 0.90,
      child: Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(30),
        color: Color(0xFF175c4c),
        child: MaterialButton(
          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () {
            signUp(emailEditingController.text, passwordEditingController.text);
          },
          child: const Text(
            "ලියාපදිංචි වන්න",
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
        backgroundColor: Colors.white,
        body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Configt.loginImage),
                fit: BoxFit.fitHeight,)
          ),
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(Configt.bAnimation),
                  fit: BoxFit.fill,)
            ),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding:
                        EdgeInsets.only(top: height * 0.05, left: width * 0.05),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center ,
                      children: const <Widget>[
                        Text(
                          "ලියාපදිංචි කිරීම",
                          style: TextStyle(
                            fontSize: 24.0,
                            color: Colors.black,

                            decorationColor: Colors.redAccent,
                            // fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Form(
                    key: _formkey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height: 245,
                          child: Container(
                            color: Colors.white10,
                            child: Center(
                              child: Lottie.asset(Configt.baby,
                                fit: BoxFit.fitWidth,

                              ),
                            ),
                          ), ),
                        emailField,
                        SizedBox(height: 20),
                        passwordField,
                        SizedBox(height: 20),
                        confirmPasswordField,
                        SizedBox(height: 20),
                        signUpButton,
                        SizedBox(height: 15),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 35,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment
                        .center, //Center Row contents horizontally,
                    crossAxisAlignment: CrossAxisAlignment
                        .center, //Center Row contents vertically,
                    children: <Widget>[
                      RichText(
                        text: TextSpan(
                          text: "පැරණි ගිණුමට පිවිසෙන්න , ",
                          style: TextStyle(fontSize: 12, color: Colors.black,fontWeight: FontWeight.bold),
                          children: <TextSpan>[
                            TextSpan(
                                text: ' ක්ලික් කරන්න',
                                recognizer: new TapGestureRecognizer()
                                  ..onTap = () => Navigator.of(context)
                                      .pushReplacement(MaterialPageRoute(
                                          builder: (context) => LoginScreen())),
                                style: const TextStyle(
                                    color: Color(0xFF175c4c),
                                    decoration: TextDecoration.underline,
                                    height: 1.2)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  //

  void signUp(String email, String password) async {
    if (_formkey.currentState!.validate()) {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {postDetailsToFirestore()})
          .catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
      });
    }
  }

  // //handle After SignIn
  handleAfterSignIn() {
    Future.delayed(const Duration(milliseconds: 1000)).then((value) {
      nextScreenReplace(context, const HomeScreenAll());
    });
  }

  postDetailsToFirestore() async {
    // calling our fireStore
    //calling our user model
    // sending these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;
    final sp = context.read<SignInProvider>();

    UserModel userModel = UserModel();

    if (user != null) {
      //writing all the values
      userModel.role = 0 ;
      userModel.email = user?.email;
      userModel.uid = user?.uid;


      await firebaseFirestore
          .collection("users")
          .doc(user?.uid)
          .set(userModel.toMap());

      Fluttertoast.showToast(msg: "Account created successfully ");
      Navigator.pushAndRemoveUntil(
          (context),
          MaterialPageRoute(builder: (context) => HomeScreenAll()),
          (route) => false);
    }
  }
}
