import 'package:teleport_weather_bhargav/blocs/Splash/splash_bloc.dart';
import 'package:teleport_weather_bhargav/custom_color_scheme.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controls.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late SplashBloc _splashBloc ;

  //Flare animation controller
  final FlareControls _controls = FlareControls();

  @override
  void initState() {

    super.initState();
    _splashBloc = BlocProvider.of<SplashBloc>(context);
    _splashBloc.add(SetSplash());
    _controls.play("get_cloudy");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.white10,
        child: BlocListener<SplashBloc, SplashState>(
          listener: (context, state) {
            if (state is NavigateToHomeScreen) {
              navigateToHomeScreen();
            }
          },

          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              getFlareWidget(),
              getAppTitleAndLogoWidget(),
              //To place the progress indicator to bottom of the page we are adding spacer. We can also use Align widget too.
              Spacer(),
              getProgressIndicator(),
              SizedBox(height: 20,)
            ],
          ),
        ),
      ),
    );
  }

  Widget getFlareWidget() {
    return Container(
      child: FlareActor(
        "assets/animations/get_cloudy.flr",
        alignment: Alignment.center,
        fit: BoxFit.contain,
        isPaused: false,
        animation: "get_cloudy",
        controller: _controls,
      ),
      height: 200,
      margin: EdgeInsets.only(top: 70, bottom: 10),
    );
  }

  getAppTitleAndLogoWidget() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Weather Monitor App",
          style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18,),
        ),
        Padding(
          child: Text(
            "by",
            style: TextStyle(fontWeight: FontWeight.w400),
          ),
          padding: EdgeInsets.all(10),
        ),
        Text(
          "B L Bhargav",
          style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16),
        ),
      ],
    );
  }

  getProgressIndicator() {
    return Container(
      child: CircularProgressIndicator(),
      margin: EdgeInsets.only(bottom: 15),
    );
  }

  void navigateToHomeScreen() {
    Navigator.popAndPushNamed(context, '/home');
  }
}