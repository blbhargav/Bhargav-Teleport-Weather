
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:teleport_weather_bhargav/blocs/Cities/cities_bloc.dart';
import 'package:teleport_weather_bhargav/custom_color_scheme.dart';
import 'package:teleport_weather_bhargav/blocs/Dashboard/dashboard_bloc.dart';
import 'package:teleport_weather_bhargav/models/current_weather.dart';
import 'package:teleport_weather_bhargav/models/forecast_weather.dart';

class DashboardPage extends StatefulWidget {

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late DashboardBloc _dashboardBloc;
  late CitiesBloc _citiesBloc;
  List<String> cities=[];
  String? selectedCity;

  CurrentWeather? currentWeather;
  ForecastWeather? forecastWeather;
  @override
  void initState() {
    super.initState();
    _dashboardBloc=BlocProvider.of<DashboardBloc>(context);
    _citiesBloc=BlocProvider.of<CitiesBloc>(context);

    _citiesBloc.add(GetCitiesEvent());


  }
  @override
  Widget build(BuildContext context) {
    return BlocListener<DashboardBloc, DashboardState>(
      listener: (context, state) {
        if(state is DisplayCurrentWeatherState){
          currentWeather=state.currentWeather;
        }else if(state is RefreshCitiesState){
          selectedCity=currentWeather!.name;
          _citiesBloc.add(RefreshEvent());
        }else if(state is DisplayForecastWeatherState){
          forecastWeather=state.forecastWeather;
        }
      },
      child: ListView(
        padding: EdgeInsets.only(bottom: 100),
        children: [
          getCitiesWidget(),
          SizedBox(height: 20,),
          getCurrentWeatherWidget(),

          Container(
            constraints: BoxConstraints(
              minHeight: 400,
            ),
            padding: EdgeInsets.all(16),
            margin: EdgeInsets.only(top: 30),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: Theme.of(context).cardColor,
            ),
            child: Column(
              children: [
                Text("Next 5 days",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 18),),
                BlocBuilder<DashboardBloc, DashboardState>(
                    bloc: _dashboardBloc,
                    buildWhen: (previous, current) {
                      if (current is ForecastWeatherInitial ||
                          current is ErrorForecastWeatherState ||
                          current is DisplayForecastWeatherState || current is DashboardInitial) {
                        return true;
                      }
                      return false;
                    },
                    builder: (BuildContext context, DashboardState state){
                      if(state is ForecastWeatherInitial || state is DashboardInitial){
                        return Container(
                          height: 100,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                      if(state is ErrorForecastWeatherState){
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 200,
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: Theme.of(context).cardColor,
                                  borderRadius: BorderRadius.all(Radius.circular(10))
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Error fetching the forecast weather",
                                    style: TextStyle(fontSize: 10,color: Theme.of(context).errorColor),
                                  ),
                                  SizedBox(height: 10,),
                                  GestureDetector(
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      width: 80,
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).primaryColor,
                                        borderRadius: BorderRadius.all(Radius.circular(20)),

                                      ),
                                      child: Text("RETRY",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    onTap: (){
                                      _dashboardBloc.add(GetWeatherForecastEvent(selectedCity!));
                                    },
                                  )
                                ],
                              ),
                            )
                          ],
                        );
                      }
                      return forecastWeather==null?Container():ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: forecastWeather!.weatherlist!.length>6?6:forecastWeather!.weatherlist!.length,
                        separatorBuilder: (context, index) {
                          return Container(
                            height: 1,
                            color: Theme.of(context).colorScheme.iconsColor,
                            margin: EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
                          );
                        },
                        itemBuilder: (BuildContext context,int index){
                          WeatherList weather=forecastWeather!.weatherlist![index];
                          return Text("${weather.main!.temp}°C");
                        },
                      );
                    }
                )
              ],
            ),
          )

        ],
      ),
    );
  }

  Widget getCitiesWidget() {
    return BlocListener<CitiesBloc, CitiesState>(listener: (context, state){
      if(state is DisplayCitiesState){
        cities=state.cities;
        selectedCity=cities[0];
        _dashboardBloc.add(GetCurrentWeatherEvent(selectedCity!));
        _dashboardBloc.add(GetWeatherForecastEvent(selectedCity!));
      }
    },
      child: BlocBuilder<CitiesBloc, CitiesState>(
          bloc: _citiesBloc,
          buildWhen: (previous, current) {
            if (current is CitiesInitial ||
                current is DisplayCitiesState ||
                current is RefreshCityState) {
              return true;
            }
            return false;
          },
          builder: (BuildContext context, CitiesState state){
            if(state is CitiesInitial){
              return Container(
                height: 50,
                child: Center(
                  child: LinearProgressIndicator(),
                ),
              );
            }

            return cities.length==0?Container():Container(
              height: 50,
              margin: EdgeInsets.only(top: 20),
              child: ListView.builder(
                itemCount: cities.length,
                scrollDirection: Axis.horizontal,
                itemBuilder:(BuildContext context, int index){
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        child: Container(
                          margin: EdgeInsets.only(left: index==0?20:0,right: 20),
                          constraints: BoxConstraints(
                              minWidth: 50,
                              maxHeight: 48,
                              maxWidth: 200
                          ),
                          padding:EdgeInsets.all(8),
                          decoration: selectedCity==cities[index]?BoxDecoration(
                              color: Theme.of(context).cardColor,
                              borderRadius: BorderRadius.all(Radius.circular(20))
                          ):null,
                          child: Text("${cities[index]}",
                            style: TextStyle(fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: selectedCity==cities[index]?Theme.of(context).colorScheme.activeBottomNavIconColor:Colors.white,
                            ),
                          ),

                        ),
                        onTap: (){
                          selectedCity=cities[index];
                          _citiesBloc.add(RefreshEvent());
                          _dashboardBloc.add(GetCurrentWeatherEvent(selectedCity!));
                          _dashboardBloc.add(GetWeatherForecastEvent(selectedCity!));
                        },
                      )
                    ],
                  );
                },
              ),
            );
          }
      ),
    );
  }

  Widget getCurrentWeatherWidget() {
    return BlocBuilder<DashboardBloc, DashboardState>(
        bloc: _dashboardBloc,
        buildWhen: (previous, current) {
          if (current is CurrentWeatherInitial ||
              current is ErrorCurrentWeatherState ||
              current is DisplayCurrentWeatherState || current is DashboardInitial) {
            return true;
          }
          return false;
        },
        builder: (BuildContext context, DashboardState state){
          if(state is CurrentWeatherInitial || state is DashboardInitial){
            return Container(
              height: 300,
              child: Center(
                child: CircularProgressIndicator(color: Colors.white,),
              ),
            );
          }
          if(state is ErrorCurrentWeatherState){
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 200,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.all(Radius.circular(10))
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Error fetching the current weather",
                        style: TextStyle(fontSize: 10,color: Theme.of(context).errorColor),
                      ),
                      SizedBox(height: 10,),
                      GestureDetector(
                        child: Container(
                          padding: EdgeInsets.all(10),
                          width: 80,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.all(Radius.circular(20)),

                          ),
                          child: Text("RETRY",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        onTap: (){
                          _dashboardBloc.add(GetCurrentWeatherEvent(selectedCity!));
                        },
                      )
                    ],
                  ),
                )
              ],
            );
          }
          return currentWeather==null?Container():Column(
            children: [
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.place,color: Colors.white,),
                  SizedBox(width: 5,),
                  Text("${currentWeather!.name}",
                    style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700,color: Colors.white),
                  ),
                ],
              ),
              Container(
                margin:EdgeInsets.only(top: 20,bottom: 10),
                child: Text("Today",style: TextStyle(color: Color(0xffA7A7A7)),),
              ),
              Text("${DateFormat("EEE, dd MMM, yyyy").format(DateTime.now())}",
                style: TextStyle(color: Color(0xffA7A7A7),fontWeight: FontWeight.w600,fontSize: 15),
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  currentWeather!.weather![0].icon!=null?Image.network("http://openweathermap.org/img/w/${currentWeather!.weather![0].icon}.png",
                    width: 70,
                    height: 70,
                  ):Container(),
                  Text("${currentWeather!.main!.temp!.toStringAsFixed(0)}°C",
                    style: TextStyle(color: Colors.white,fontWeight: FontWeight.w800,fontSize: 50),
                  )
                ],
              ),
              Text("${currentWeather!.weather![0].main}",
                style: TextStyle(color: Color(0xffA7A7A7),fontWeight: FontWeight.w600,fontSize: 25),
              ),
              SizedBox(height: 20,),

              Container(
                width: 150,
                height: 35,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    border: Border.all(width: 1,color: Color(0xffA7A7A7))
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("See Details",style: TextStyle(color: Color(0xffA7A7A7)),),
                    SizedBox(width: 5,),
                    Icon(Icons.keyboard_arrow_right_outlined,size: 20,color: Color(0xffA7A7A7),)
                  ],

                ),

              )

            ],
          );
        }
    );
  }
}