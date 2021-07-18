import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:teleport_weather_bhargav/DB/weather_repository.dart';
import 'package:teleport_weather_bhargav/models/current_weather.dart';
import 'package:teleport_weather_bhargav/models/forecast_weather.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final WeatherRepository repository;
  DashboardBloc({required this.repository}) : super(DashboardInitial());

  @override
  Stream<DashboardState> mapEventToState(
    DashboardEvent event,
  ) async* {
    if(event is GetCurrentWeatherEvent){
      yield* mapGetCurrentWeatherEventToState(event);
    }else if(event is FetchUserLocationEvent){
      yield* mapFetchUserLocationEventToState(event);
    }else if(event is GetWeatherForecastEvent){
      yield* mapGetWeatherForecastEventToState(event);
    }else if(event is GetCurrentWeatherByLatLangEvent){
      yield CurrentWeatherInitial();
      CurrentWeather? currentWeather=await repository.getCurrentWeatherFromLatLang(event.position);
      if(currentWeather==null){
        yield ErrorCurrentWeatherState();
      }else{
        yield DisplayCurrentWeatherState(currentWeather);
        yield RefreshCitiesState();
      }
    }else if(event is GetWeatherForecastByLatLangEvent){
      yield ForecastWeatherInitial();
      ForecastWeather? forecastWeather=await repository.getWeatherForecastByLatLang(event.position);
      yield* processForecastData(forecastWeather);
    }
  }

  Stream<DashboardState> mapGetCurrentWeatherEventToState(GetCurrentWeatherEvent event) async*{
    yield CurrentWeatherInitial();
    CurrentWeather? currentWeather=await repository.getCurrentWeather(event.city);
    if(currentWeather==null){
      yield ErrorCurrentWeatherState();
    }else{
      yield DisplayCurrentWeatherState(currentWeather);
    }
  }

  Stream<DashboardState> mapFetchUserLocationEventToState(FetchUserLocationEvent event) async*{
    yield CurrentWeatherInitial();
    yield ForecastWeatherInitial();
    Position position = await Geolocator.getCurrentPosition();
    yield LocationFetchedState(position);

  }

  Stream<DashboardState> mapGetWeatherForecastEventToState(GetWeatherForecastEvent event)async* {
    yield ForecastWeatherInitial();
    ForecastWeather? forecastWeather=await repository.getWeatherForecast(event.city);
    yield* processForecastData(forecastWeather);
  }

  Stream<DashboardState> processForecastData(ForecastWeather? forecastWeather) async*{
    if(forecastWeather==null){
      yield ErrorForecastWeatherState();
    }else{
      List<WeatherList> forecastWeatherList=[];
      DateFormat dateFormat=DateFormat("yyyy-MM-dd HH:mm:ss");
      DateFormat standardDateFormat=DateFormat("yyyy-MM-dd");
      DateTime tomorrow=DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day+1);

      var j=1;
      for(var i=0;i<forecastWeather.weatherlist!.length;i++){
        WeatherList weatherInfo=forecastWeather.weatherlist![i];
        DateTime weatherDate=dateFormat.parse(weatherInfo.dtTxt!);
        if(standardDateFormat.format(weatherDate)==standardDateFormat.format(tomorrow)){
          ++j;
          tomorrow=DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day+j);
          forecastWeatherList.add(weatherInfo);
        }
      }

      yield DisplayForecastWeatherState(forecastWeatherList);
    }
  }
}
