import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:teleport_weather_bhargav/DB/shared_preference_service.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState(ThemeMode.light));

  ThemeState get initialState => ThemeState(ThemeMode.light);

  @override
  Stream<ThemeState> mapEventToState(ThemeEvent event) async* {
    if (event is ThemeLoadStarted) {
      yield* _mapThemeLoadStartedToState();
    } else if (event is ThemeChanged) {
      yield* _mapThemeChangedToState(event.value);
    }else if(event is LightThemeEvent){
      final sharedPrefService = await SharedPreferencesService.instance;
      await sharedPrefService.setDarkModeInfo(false);
      yield ThemeState(ThemeMode.light);
    }else if(event is DarkThemeEvent){
      final sharedPrefService = await SharedPreferencesService.instance;
      await sharedPrefService.setDarkModeInfo(true);
      yield ThemeState(ThemeMode.dark);
    }
  }

  Stream<ThemeState> _mapThemeLoadStartedToState() async* {
    final sharedPrefService = await SharedPreferencesService.instance;
    bool isDarkModeEnabled = sharedPrefService.isDarkModeEnabled;

    if (isDarkModeEnabled) {
      yield ThemeState(ThemeMode.dark);
    } else {
      yield ThemeState(ThemeMode.light);
    }
  }

  Stream<ThemeState> _mapThemeChangedToState(bool value) async* {
    final sharedPrefService = await SharedPreferencesService.instance;
    final isDarkModeEnabled = sharedPrefService.isDarkModeEnabled;

    if (value && !isDarkModeEnabled) {
      await sharedPrefService.setDarkModeInfo(true);
      yield ThemeState(ThemeMode.dark);
    } else if (!value && isDarkModeEnabled) {
      await sharedPrefService.setDarkModeInfo(false);
      yield ThemeState(ThemeMode.light);
    }
  }
}
