import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:teleport_weather_bhargav/DB/weather_repository.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitial());

  @override
  Stream<SplashState> mapEventToState(
    SplashEvent event,
  ) async* {
    if (event is SetSplash) {
      //Waiting for the splash animation to complete
      await Future.delayed(Duration(seconds: 5));

      yield NavigateToHomeScreen();
    }
  }
}
