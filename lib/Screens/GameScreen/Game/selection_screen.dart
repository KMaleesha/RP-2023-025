import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../utils/configt.dart';

class SelectionScreen extends StatefulWidget {
  const SelectionScreen({Key? key}) : super(key: key);

  @override
  State<SelectionScreen> createState() => _SelectionScreenState();
}

class _SelectionScreenState extends State<SelectionScreen> {

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
  }


  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Configt.app_SelectionPageBackground1),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Row(
                children: [
                  // Image.asset(Configt.app_man,height: 150,width: 150,),
                  Image.asset(Configt.app_balla,height: 150,width: 150,),
                  Image.asset(Configt.app_eluwa,height: 150,width: 150,),
                  Image.asset(Configt.app_gemba,height: 150,width: 150,),

                ],
              ),
              Row(
                children: [
                  Image.asset(Configt.app_hawa,height: 150,width: 150,),
                  Image.asset(Configt.app_ibba,height: 150,width: 150,),
                  Image.asset(Configt.app_makuluwa,height: 150,width: 150,),
                  Image.asset(Configt.app_samanalaya,height: 150,width: 150,),
                ],
              )


            ],
          ),
        ),
      ),
    );
  }
}

