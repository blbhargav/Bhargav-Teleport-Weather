
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teleport_weather_bhargav/DB/shared_preference_service.dart';
import 'package:teleport_weather_bhargav/blocs/Settings/settings_bloc.dart';
import 'package:teleport_weather_bhargav/blocs/Theme/theme_bloc.dart';
import 'package:teleport_weather_bhargav/custom_color_scheme.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> with SingleTickerProviderStateMixin,RouteAware{
  int themeMode=-1;
  late SharedPreferencesService sharedPrefService;
  late SettingsBloc _settingsBloc;
  @override
  void initState() {
    super.initState();
    _settingsBloc=BlocProvider.of<SettingsBloc>(context);
    init();
  }
  void init() async{
    sharedPrefService = await SharedPreferencesService.instance;
    final isDarkModeEnabled = sharedPrefService.isDarkModeEnabled;

    if (isDarkModeEnabled) {
      themeMode=2;
    } else {
      themeMode=1;
    }
    _settingsBloc.add(ChangeStateEvent());
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    var scalingWidth = screenWidth/360;
    return BlocListener<SettingsBloc, SettingsState>(
      listener: (context, state) {

      },
      child: BlocBuilder<SettingsBloc, SettingsState>(
          bloc: _settingsBloc,
          builder: (BuildContext context, SettingsState state) {
            return Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Text("Settings",
                    style: TextStyle(fontWeight: FontWeight.w700,color: Colors.white,fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                    child: Container(
                      margin: EdgeInsets.only(top: 20,left: 10,right: 10,bottom: 10),
                      decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.all(Radius.circular(30))
                      ),
                      padding: EdgeInsets.all(10),
                      child: ListView(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 20,left: 10,bottom: 20),
                            child: Text("Change App Theme",
                              style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                          ),

                          themeMode==1?selectedCard("Light", scalingWidth):unSelectedCard("Light", scalingWidth, lightThemeSelected),
                          Container(
                            child: Divider(),
                          ),
                          themeMode==2?selectedCard("Dark", scalingWidth):unSelectedCard("Dark", scalingWidth, darkModeSelected),

                        ],
                      ),
                    )
                )
              ],
            );
          }
      ),
    );


  }
  Widget selectedCard(var title, double scalingWidth){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 300* scalingWidth,
          padding: EdgeInsets.only(left: 32*scalingWidth,right: 32*scalingWidth,bottom: 20,top: 20),
          decoration: new BoxDecoration(
            borderRadius: new BorderRadius.circular(10.0),
            color: Theme.of(context).cardColor,
            border: new Border.all(
              width: 2.0,
              color: Theme.of(context).primaryColor,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("$title",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 14),),
              Spacer(),
              Container(
                height: 24,
                width: 24,
                decoration: new BoxDecoration(
                  borderRadius: new BorderRadius.circular(25.0),
                  color: Theme.of(context).primaryColor,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFFb3c2e7),
                      offset: Offset(0.0, 6.0),
                      spreadRadius: 0,
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: Center(
                  child: Container(
                      height: 12,
                      width: 12,
                      decoration: new BoxDecoration(
                        borderRadius: new BorderRadius.circular(25.0),
                        color: Theme.of(context).cardColor,
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xFFb3c2e7),
                            offset: Offset(0.0, 6.0),
                            spreadRadius: 0,
                            blurRadius: 10,
                          ),
                        ],
                      )
                  ),
                ),
              ),

            ],
          ),
        )
      ],
    );
  }

  Widget unSelectedCard(var title,double scalingWidth,var onTap){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          splashColor: Theme.of(context).primaryColor,
          child: Container(
            width: 300* scalingWidth,
            padding: EdgeInsets.only(left: 32*scalingWidth,right: 32*scalingWidth,bottom: 20,top: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("$title",
                  style: TextStyle(fontWeight: FontWeight.w700,fontSize: 14,color: Theme.of(context).colorScheme.iconsColor),
                ),
                Spacer(),
                Container(
                  height: 24,
                  width: 24,
                  decoration: new BoxDecoration(
                    borderRadius: new BorderRadius.circular(25.0),
                    color: Theme.of(context).cardColor,
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x33000000),
                        offset: Offset(0.0, 2.0),
                        spreadRadius: 0,
                        blurRadius: 10,
                      ),
                    ],
                  ),
                )

              ],
            ),
          ),
          onTap: onTap,
        )
      ],
    );
  }

  void darkModeSelected() {
    themeMode=2;
    BlocProvider.of<ThemeBloc>(context).add(DarkThemeEvent());
  }

  void lightThemeSelected() {
    themeMode=1;
    BlocProvider.of<ThemeBloc>(context).add(LightThemeEvent());
  }
}