part of 'dashboard_bloc.dart';

abstract class DashboardState extends Equatable {
  const DashboardState();
}

class DashboardInitial extends DashboardState {
  @override
  List<Object> get props => [];
}

class CurrentWeatherInitial extends DashboardState {
  @override
  List<Object> get props => [];
}

class ErrorCurrentWeatherState extends DashboardState {
  @override
  List<Object> get props => [];
}
class DisplayCurrentWeatherState extends DashboardState{
  final CurrentWeather currentWeather;
  DisplayCurrentWeatherState(this.currentWeather);
  @override
  List<Object> get props => [];
}
class RefreshCitiesState extends DashboardState{
  @override
  List<Object> get props => [];
}


class ForecastWeatherInitial extends DashboardState {
  @override
  List<Object> get props => [];
}

class ErrorForecastWeatherState extends DashboardState {
  @override
  List<Object> get props => [];
}
class DisplayForecastWeatherState extends DashboardState{
  final List<WeatherList> forecastWeatherList;
  DisplayForecastWeatherState(this.forecastWeatherList);
  @override
  List<Object> get props => [];
}
class LocationFetchedState extends DashboardState{
  final Position position;
  LocationFetchedState(this.position);
  @override
  List<Object> get props => [];
}