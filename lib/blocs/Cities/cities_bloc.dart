import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:teleport_weather_bhargav/DB/weather_repository.dart';

part 'cities_event.dart';
part 'cities_state.dart';

class CitiesBloc extends Bloc<CitiesEvent, CitiesState> {
  final WeatherRepository repository;
  CitiesBloc({required this.repository}) : super(CitiesInitial());

  @override
  Stream<CitiesState> mapEventToState(
    CitiesEvent event,
  ) async* {
    if(event is GetCitiesEvent){
      yield CitiesInitial();
      List<String> cities= await repository.getCities();
      yield DisplayCitiesState(cities);
    }else if(event is RefreshEvent){
      yield CitiesInitial();
      yield RefreshCityState();
    }
  }
}
