import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ErrorScreen extends StatelessWidget {
  final Function() callback;
  ErrorScreen({required this.callback});
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    var scalingWidth = screenWidth / 360;
    var scalingHeight = screenHeight / 640;
    return SafeArea(
      child: ListView(
        shrinkWrap: true,
        children: [
          Container(
            margin: EdgeInsets.only(
              top: 50,),
            child: Center(
              child: SvgPicture.asset("assets/images/error_illustration.svg",
                  height: 200.00,
                  width: 263.0,
                  semanticsLabel: 'Error Illustration'),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
                top: 30.0 , bottom: 20.0 ),
            child: Text(
              "Error connecting to server",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            margin: EdgeInsets.only(
                left: 30.0*scalingWidth, right: 30.0*scalingWidth),
            child: Text(
              "There seems to be a connection error or server error. Please try again after ensuring that you have enabled your internet connection.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(top: 30),
                width: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ElevatedButton(
                  child: Container(
                    child: Center(
                      child: Text("REFRESH",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14),),
                    ),
                    height: 48,
                  ),
                  onPressed: callback,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
