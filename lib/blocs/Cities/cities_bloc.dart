import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:teleport_weather_bhargav/DB/weather_repository.dart';

part 'cities_event.dart';
part 'cities_state.dart';

class CitiesBloc extends Bloc<CitiesEvent, CitiesState> {
  final WeatherRepository repository;
  CitiesBloc({required this.repository}) : super(CitiesInitial());
  List<String> cities=[];
  @override
  Stream<CitiesState> mapEventToState(
    CitiesEvent event,
  ) async* {
    if(event is GetCitiesEvent){
      yield CitiesInitial();
      cities= await repository.getCities();
      yield DisplayCitiesState(cities);
    }else if(event is RefreshEvent){
      yield CitiesInitial();
      yield RefreshCityState();
    }else if(event is AllCityClickedEvent){
      yield CitiesInitial();
      yield ShowAddCityUIState();
    }else if(event is AddCityEvent){
     yield* mapAddCityEventToState(event);
    }
  }

  Stream<CitiesState> mapAddCityEventToState(AddCityEvent event) async*{
    yield ShowAddingCityState();
    bool isCityValid=true;
    for(var i=0;i<cities.length;i++){
      if(cities[i].toLowerCase()==event.city.toLowerCase()){
        yield CloseProcessingState();
        yield CityAlreadyExistsState();
        isCityValid=false;
        break;
      }
    }

    if(isCityValid){
      bool response= await repository.addNewCity(event.city);
      await Future.delayed(Duration(seconds: 2));//Delaying purposefully to show processing animation
      yield CloseProcessingState();
      if(response){
        yield SuccessCityAddedState();
      }else{
        yield ErrorCityAddingState();
      }
    }
  }

}
