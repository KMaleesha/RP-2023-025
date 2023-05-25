import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../../../utils/configt.dart';
import '../../Users/screens/homeScreen.dart';


class DataEntryScreen extends StatefulWidget {
  const DataEntryScreen({Key? key}) : super(key: key);

  @override
  State<DataEntryScreen> createState() => _DataEntryScreenState();
}

class _DataEntryScreenState extends State<DataEntryScreen> {
  late double width, height;
  File? _image;
  final imagePicker = ImagePicker();
  //snackbar for  showing error
  showSnackBar(String snackText, Duration d) {
    final snackBar = SnackBar(content: Text(snackText), duration: d);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
  Future imagePickerMethod() async {
    //picking the file
    final pick = await imagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pick != null) {
        _image = File(pick.path);
      } else {
        //showing a snackbar with error
        showSnackBar("No file selected", Duration(milliseconds: 400));
      }
    });
  }
  TextEditingController url = TextEditingController();
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      body:Container(
        decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(Configt.app_background2),
          fit: BoxFit.cover,
        ),
      ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: height * 0.03),
              child: Row(children: <Widget>[
                GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: width * 0.04),
                    child: Icon(
                      Icons.arrow_back_ios_outlined,
                      size: 28,
                      color: Color.fromARGB(255, 12, 63, 112),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: width * 0.29),
                  child: Text(
                    Configt.app_dataentrytitle,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                  ),
                ),
              ]),
            ),
            SizedBox(
              height: height * 0.03,
            ),
            SizedBox(

              child: Center(
                child: GestureDetector(

                  onTap: imagePickerMethod,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(5),
                            topRight: Radius.circular(5),
                            bottomLeft: Radius.circular(5),
                            bottomRight: Radius.circular(5)),
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            border: Border.all(
                              color: Colors.black, // Replace with your desired border color
                              width: 2.0, // Replace with your desired border width
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
            ElevatedButton(onPressed: (){}, child: Text(Configt.app_upload))
          ],
        ),
      )
    );
  }
}
