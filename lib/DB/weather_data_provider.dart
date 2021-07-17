import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:teleport_weather_bhargav/models/current_weather.dart';
import 'package:teleport_weather_bhargav/models/forecast_weather.dart';

import 'base_provider.dart';
import 'shared_preference_service.dart';
import 'package:http/http.dart' as http;

class WeatherDataProvider extends BaseRepositoryProvider{

  Position? position;
  String apiKey="491607042ce394d4cbd7ec3490da4869";
  String imageURL="http://openweathermap.org/img/w/";
  SharedPreferencesService? sharedPrefService;
  final myClient = http.Client();
  WeatherDataProvider(){
    init();
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }

  @override
  Future<List<String>> getCities() async{
    List<String> cities=sharedPrefService!.getCitiesList;
    List<String> defaultCities=["Kuala Lumpur","Klang","Ipoh","Butterworth","George Town","Petaling Jaya","Kuantan","Shah Alam",
      "Johor Bahru","Kota Bharu","Melaka","Kota Kinabalu","Seremban","Sandakan","Sungai Petani","Kuching",
      "Kuala Terengganu","Alor Setar","Putrajaya","Kangar","Labuan","Pasir Mas","Tumpat","Ketereh","Kampung Lemal","Pulai Chondong"];

    defaultCities.addAll(cities);

    return defaultCities;
  }

  void init() async{
    sharedPrefService = await SharedPreferencesService.instance;
  }

  @override
  Future<CurrentWeather?> getCurrentWeather(String city) async{
    try{
      Uri uri=Uri.parse("http://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric");
      var response=await myClient.get(uri);
      if(response.statusCode==200){
        Map<String, dynamic> data = jsonDecode(response.body);
        CurrentWeather currentWeather=CurrentWeather.fromJson(data);
        return currentWeather;
      }else{
        return null;
      }
    }catch(_e){
      print("BLB getCurrentWeather exp $_e");
      return null;
    }
  }

  @override
  Future<CurrentWeather?> getCurrentWeatherFromLatLang(Position position) async{
    try{
      String urlString="http://api.openweathermap.org/data/2.5/weather?lat=${position.latitude}&lon=${position.longitude}&appid=$apiKey&units=metric";
      Uri uri=Uri.parse(urlString);
      var response=await myClient.get(uri);
      if(response.statusCode==200){
        Map<String, dynamic> data = jsonDecode(response.body);
        CurrentWeather currentWeather=CurrentWeather.fromJson(data);
        return currentWeather;
      }else{
        return null;
      }
    }catch(_e){
      print("BLB getCurrentWeatherFromLatLang exp $_e");
      return null;
    }
  }

  @override
  Future<ForecastWeather?> getWeatherForecast(String city) async{
    try{
      Uri uri=Uri.parse("http://api.openweathermap.org/data/2.5/forecast?q=$city&appid=$apiKey&units=metric");
      var response=await myClient.get(uri);
      if(response.statusCode==200){
        Map<String, dynamic> data = jsonDecode(response.body);
        ForecastWeather forecastWeather=ForecastWeather.fromJson(data);
        return forecastWeather;
      }else{
        return null;
      }
    }catch(_e){
      print("BLB getWeatherForecast exp $_e");
      return null;
    }
  }
}