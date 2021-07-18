
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:teleport_weather_bhargav/DB/weather_repository.dart';
import 'package:teleport_weather_bhargav/blocs/Cities/cities_bloc.dart';
import 'package:teleport_weather_bhargav/blocs/Dashboard/dashboard_bloc.dart';
import 'package:teleport_weather_bhargav/blocs/Home/home_bloc.dart';
import 'package:teleport_weather_bhargav/custom_color_scheme.dart';
import 'cities.dart';
import 'dashboard.dart';
import 'error_screen.dart';
import 'settings.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  late HomeBloc _bloc;

  int currentBottomIndex=0;
  late Widget _container;

  @override
  void initState() {
    super.initState();
    _bloc=BlocProvider.of<HomeBloc>(context);
    _bloc.add(InitHomeScreen());

    _container=Container(
      child: Center(child: CircularProgressIndicator(),),
    );
  }
  @override
  Widget build(BuildContext context) {
    var activeIconColor= Theme.of(context).colorScheme.activeBottomNavIconColor;
    var inActiveIconColor=Theme.of(context).colorScheme.inActiveBottomNavIconColor;
    return BlocListener<HomeBloc, HomeState>(
      listener: (context, state) {
        if(state is DashboardPageState){
          currentBottomIndex=0;
          _container=DashboardPage();
        }else if(state is CitiesPageState){
          currentBottomIndex=1;
          _container=CitiesPage();
        }else if(state is SettingsPageState){
          currentBottomIndex=2;
          _container=SettingsPage();
        }else if(state is HomeInitial){
          _container=Container(
            child: Center(child: CircularProgressIndicator(),),
          );
        }
      },
      child: BlocBuilder<HomeBloc, HomeState>(
          bloc: _bloc,
          builder: (BuildContext context, HomeState state) {
            if(state is ConnectionErrorState){
              return Scaffold(
                body: ErrorScreen(
                  callback: (){
                    _bloc.add(InitHomeScreen());
                  },
                ),
              );
            }

            return Scaffold(
              backgroundColor: Theme.of(context).colorScheme.homePageBackground,
              body: SafeArea(
                child: _container,
              ),
              floatingActionButton: getFloatingActionButton(),
              bottomNavigationBar: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(15),
                      topLeft: Radius.circular(15)),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x33000000),
                      offset: Offset(0.0, 2.0),
                      spreadRadius: 0,
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15.0),
                    topRight: Radius.circular(15.0),
                  ),
                  child: SizedBox(
                    child: BottomNavigationBar(
                      currentIndex: currentBottomIndex,
                      type: BottomNavigationBarType.fixed,
                      elevation: 10,
                      //showSelectedLabels: false,
                      //showUnselectedLabels: false,
                      onTap: (int i) {
                        switch (i) {
                          case 0:
                            _bloc.add(DashboardClickedEvent());
                            break;
                          case 1:
                            _bloc.add(CitiesClickedEvent());
                            break;
                          case 2:
                            _bloc.add(SettingsClickedEvent());
                            break;
                        }
                      },
                      items: <BottomNavigationBarItem>[
                        BottomNavigationBarItem(
                          icon: Container(
                            padding: EdgeInsets.only(bottom: 5),
                            child: SvgPicture.asset("assets/images/dashboard.svg",
                              semanticsLabel: 'Home icon',
                              color: currentBottomIndex==0?activeIconColor:inActiveIconColor,
                              height: 22,
                              width: 20,
                            ),
                          ),
                          label: "HOME",
                        ),
                        BottomNavigationBarItem(
                          icon: Container(
                            padding: EdgeInsets.only(bottom: 5),
                            child: SvgPicture.asset("assets/images/places.svg",
                              semanticsLabel: 'Home icon',
                              color: currentBottomIndex==1?activeIconColor:inActiveIconColor,
                              height: 22,
                              width: 20,
                            ),
                          ),
                          label: "CITIES",
                        ),
                        BottomNavigationBarItem(
                          icon: Container(
                            padding: EdgeInsets.only(bottom: 5),
                            child: SvgPicture.asset("assets/images/settings.svg",
                              semanticsLabel: 'Schedule icon',
                              color: currentBottomIndex==2?activeIconColor:inActiveIconColor,
                              height: 22,
                              width: 20,
                            ),
                          ),
                          label: "SETTINGS",
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
      ),
    );
  }

  getFloatingActionButton() {
    if(currentBottomIndex==0){
      return FloatingActionButton(
        onPressed: (){
          BlocProvider.of<DashboardBloc>(context).add(FetchUserLocationEvent());
        },
        backgroundColor: Theme.of(context).primaryColor,
        tooltip: 'Location',
        child: Icon(Icons.my_location,size: 30, color: Colors.white,),
      );
    }
    if(currentBottomIndex==1){
      return FloatingActionButton(
        onPressed: (){
          BlocProvider.of<CitiesBloc>(context).add(AllCityClickedEvent());
        },
        backgroundColor: Theme.of(context).primaryColor,
        tooltip: 'Add',
        child: Icon(Icons.add,size: 40, color: Colors.white,),
      );
    }
    return null;
  }
}