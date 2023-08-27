import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:kathaappa/Screens/GameScreen/Game/selection_screen.dart';

import '../../../utils/configt.dart';
import '../../Users/screens/homeScreen.dart';
import 'model/childImage.dart';

class DataEntryScreen extends StatefulWidget {
  const DataEntryScreen({Key? key}) : super(key: key);

  @override
  State<DataEntryScreen> createState() => _DataEntryScreenState();
}

class _DataEntryScreenState extends State<DataEntryScreen> {
  late double width, height;
  File? _image;
  late bool child;
  final ImagePicker _imagePicker = ImagePicker();
  final ImageCropper _imageCropper = ImageCropper();
  User? user = FirebaseAuth.instance.currentUser;
  TextEditingController url = TextEditingController();
  // Snackbar for showing error
  void showSnackBar(String snackText, Duration duration) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(snackText),
        duration: duration,
      ),
    );
  }

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    child = false;
    super.initState();
    getData();
  }


  Future<void> getData() async {
    final reference = FirebaseFirestore.instance
        .collection("users")
        .doc(user?.uid)
        .collection("child")
        .doc(user?.uid);
    final snapshot = await reference.get();
    final result =
    snapshot.data() == null ? null : ChildImage.fromJson(snapshot.data()!);

    setState(() {
      url.text = result?.url ?? '';
      child = result?.child ?? false;
      print("dd $child");
    });
    // Check if 'child' is true and navigate to SelectionScreen
    if (child) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SelectionScreen()),
      );
    }
  }

  List<Offset> _points = <Offset>[];

  Future<void> pickImage() async {
    try {
      final pickedFile = await _imagePicker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        final croppedFile = await _imageCropper.cropImage(
          sourcePath: pickedFile.path,
          aspectRatio: CropAspectRatio(ratioX: 4.0, ratioY: 3.0),
          cropStyle: CropStyle.rectangle,  // This will allow freeform rectangular cropping
          androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Crop Image',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            hideBottomControls: false,  // This shows the control for aspect ratio
            showCropGrid: false,  // This hides the grid
            initAspectRatio: CropAspectRatioPreset.ratio4x3,
          ),
          iosUiSettings: const IOSUiSettings(
            title: 'Crop Image',
            minimumAspectRatio: 1.0,  // This allows a more freeform crop on iOS
          ),
        );

        if (croppedFile != null) {
          setState(() {
            _image = File(croppedFile.path);
          });
        } else {
          showSnackBar("No file selected", const Duration(milliseconds: 400));
        }
      }
    } catch (e) {
      print("Failed to pick or crop image: $e");
      showSnackBar("Error: $e", const Duration(seconds: 2));
    }
  }





  // Add a state variable to track whether the content is loading
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    print("child $child");


    // Delay for 3 seconds to simulate loading
    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        isLoading = false; // Content is now loaded
      });
    });
    return   (isLoading) ?
    Scaffold(
        backgroundColor: Colors.white,
        body: Container(

          child: Container(
            color: Colors.white10,
            child: Center(
              child: Image.asset(Configt.appLogo),
            ),
          ),
        )
    )
        :
    Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Configt.app_background2),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: height * 0.04),
                  child: Row(
                    children: <Widget>[
                      GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomeScreenAll()),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(left: width * 0.04),
                          child: Icon(
                            Icons.arrow_back_ios_outlined,
                            size: 28,
                            color: const Color.fromARGB(255, 12, 63, 112),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: width * 0.29),
                        child: Text(
                          Configt.app_dataentrytitle,
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: height * 0.03),
                SizedBox(
                  child: Center(
                    child: GestureDetector(
                      onTap: pickImage,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                border: Border.all(
                                  color: Colors.black,
                                  width: 2.0,
                                ),
                              ),
                              child: SizedBox(
                                width: width * 0.5,
                                height: height * 0.19,
                                child: Container(
                                  child: _image != null
                                      ? Image.file(_image!)
                                      : url.text.isNotEmpty
                                      ? Image.network(url.text)
                                      : Image.asset(Configt.app_addImage),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed:  check,
                  child: Text(Configt.app_upload),
                ),
              ],
            ),
          ),
          // Circular progress indicator overlay

        ],
      ),
    );
  }
  void check(){
    if(_image == null)
    {
      showSnackBar("add image", Duration(seconds: 2));
    }
    else{
      Add();
    }
  }
  Future<void> Add() async {


    final postID = DateTime.now().millisecondsSinceEpoch.toString();
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    // Uploading the image (if available)
    String? downloadURL;
    if (_image != null) {
      Reference ref =
      FirebaseStorage.instance.ref().child("pets").child("post_$postID");
      await ref.putFile(_image!);
      downloadURL = await ref.getDownloadURL();
      print("downloadURL: $downloadURL");
    }

    // Uploading pet details to Cloud Firestore
    await firebaseFirestore
        .collection("users")
        .doc(user?.uid)
        .collection("child")
        .doc(user?.uid)
        .set({
      'child':true,
      'url': downloadURL ?? "", // May be null if image upload failed
    }).then((_) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => SelectionScreen(),
      ));
      showSnackBar("Child Image Added successfully", Duration(seconds: 2));
    }).catchError((error) {
      print("Error adding pet: $error");
      showSnackBar("Failed to add Child Image", Duration(seconds: 2));
    });
  }
}
