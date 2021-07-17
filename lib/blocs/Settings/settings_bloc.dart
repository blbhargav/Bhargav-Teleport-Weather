import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:teleport_weather_bhargav/DB/weather_repository.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final WeatherRepository repository;
  SettingsBloc({required this.repository}) : super(SettingsInitial());

  @override
  Stream<SettingsState> mapEventToState(
    SettingsEvent event,
  ) async* {
    if(event is ChangeStateEvent){
      yield ChangeState();
      yield SettingsInitial();
    }
  }
}
