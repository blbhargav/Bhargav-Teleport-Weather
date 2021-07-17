import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
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
    Position position = await Geolocator.getCurrentPosition();
    CurrentWeather? currentWeather=await repository.getCurrentWeatherFromLatLang(position);
    if(currentWeather==null){
      yield ErrorCurrentWeatherState();
    }else{
      yield DisplayCurrentWeatherState(currentWeather);
      yield RefreshCitiesState();
    }
  }

  Stream<DashboardState> mapGetWeatherForecastEventToState(GetWeatherForecastEvent event)async* {
    yield ForecastWeatherInitial();
    ForecastWeather? forecastWeather=await repository.getWeatherForecast(event.city);
    if(forecastWeather==null){
      yield ErrorForecastWeatherState();
    }else{
      yield DisplayForecastWeatherState(forecastWeather);
    }
  }
}
