import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:connectivity/connectivity.dart';
import 'package:equatable/equatable.dart';
import 'package:teleport_weather_bhargav/DB/weather_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final WeatherRepository repository;
  HomeBloc({required this.repository}) : super(HomeInitial());

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    if(event is InitHomeScreen){
      yield HomeInitial();
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.none) {
        yield ConnectionErrorState();
      }else
        yield DashboardPageState();
    }else if(event is DashboardClickedEvent){
      yield DashboardPageState();
    }else if(event is CitiesClickedEvent){
      yield CitiesPageState();
    }else if(event is SettingsClickedEvent){
      yield SettingsPageState();
    }
  }
}
