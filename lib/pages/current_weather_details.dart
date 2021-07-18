import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:teleport_weather_bhargav/models/current_weather.dart';
import 'package:teleport_weather_bhargav/custom_color_scheme.dart';

class CurrentWeatherDetailsPage extends StatefulWidget {
  final CurrentWeather? currentWeather;
  final String? city;
  CurrentWeatherDetailsPage({this.currentWeather,this.city});
  @override
  _CurrentWeatherDetailsPageState createState() => _CurrentWeatherDetailsPageState();
}

class _CurrentWeatherDetailsPageState extends State<CurrentWeatherDetailsPage> {
  CurrentWeather? currentWeather;
  @override
  void initState() {
    super.initState();

    currentWeather=widget.currentWeather;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.homePageBackground,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Stack(
                children: [
                  Center(
                    child: Text("${widget.city}",
                      style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w700),
                      textAlign: TextAlign.center,
                    )
                  ),

                  Positioned.fill(
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: GestureDetector(
                          child: Container(
                            margin: EdgeInsets.only(left: 20),
                            child: SvgPicture.asset("assets/images/arrow_left.svg",color: Colors.white,),
                          ),
                          onTap: (){
                            Navigator.pop(context);
                          },
                        ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Text("${DateFormat("EEE, dd MMM yyyy").format(DateTime.now())}",
              style: TextStyle(color: Color(0xffA7A7A7),fontSize: 14,fontWeight: FontWeight.w700),),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(top: 16,left: 16,right: 16,bottom: 40),
                margin: EdgeInsets.only(top: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Theme.of(context).cardColor,
                ),
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        getSmallTempCard(title:"Min Temp",body:"${currentWeather!.main!.tempMin!.toStringAsFixed(0)}°C"),
                        Column(
                          children: [
                            currentWeather!.weather![0].icon!=null?Image.network("http://openweathermap.org/img/w/${currentWeather!.weather![0].icon}.png",
                              width: 70,
                              height: 50,
                            ):Container(),
                            Text("${currentWeather!.main!.temp!.toStringAsFixed(0)}°C",
                              style: TextStyle(color:Theme.of(context).primaryColor,fontWeight: FontWeight.w800,fontSize: 50),
                            )
                          ],
                        ),
                        getSmallTempCard(title:"Max Temp",body:"${currentWeather!.main!.tempMax!.toStringAsFixed(0)}°C"),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Text("Feels Like ${currentWeather!.main!.feelsLike!.toStringAsFixed(0)}°C",
                      style: TextStyle(color: Color(0xffA7A7A7),fontWeight: FontWeight.w600,fontSize: 15),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10,),
                    Text("${currentWeather!.weather![0].main}",
                      style: TextStyle(fontWeight: FontWeight.w600,fontSize: 25),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        getSmallCard(title:"Wind",body:"${currentWeather!.wind!.speed}km/h"),
                        getSmallCard(title:"Clouds",body:"${currentWeather!.clouds!.all}%"),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        getSmallCard(title:"Humidity",body:"${currentWeather!.main!.humidity}%"),
                        getSmallCard(title:"Pressure",body:"${currentWeather!.main!.pressure} hPa"),
                      ],
                    ),

                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  getSmallCard({required String title, required String body}) {
    return Container(
      constraints: BoxConstraints(
          minWidth: 120,
          maxWidth: 200,
          minHeight: 40
      ),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          color: Theme.of(context).colorScheme.forecastCardColor
      ),
      child: Column(
        children: [
          Text("$title",
            style: TextStyle(color: Theme.of(context).colorScheme.iconsColor,fontSize: 14,fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 5,),
          Text("$body",
            style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 20,fontWeight: FontWeight.w700),)
        ],
      ),
    );
  }
  getSmallTempCard({required String title, required String body}) {
    return Container(
      constraints: BoxConstraints(
          minWidth: 80,
          maxWidth: 120,
          minHeight: 40
      ),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          color: Theme.of(context).colorScheme.forecastCardColor
      ),
      child: Column(
        children: [
          Text("$title",
            style: TextStyle(color: Theme.of(context).colorScheme.iconsColor,fontSize: 12,fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 5,),
          Text("$body",
            style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 15,fontWeight: FontWeight.w700),)
        ],
      ),
    );
  }
}