part of 'dashboard_bloc.dart';

abstract class DashboardEvent extends Equatable {
  const DashboardEvent();
}
class GetCurrentWeatherEvent extends DashboardEvent{
  final String city;
  GetCurrentWeatherEvent(this.city);
  @override
  List<Object> get props => [];
}
class FetchUserLocationEvent extends DashboardEvent{
  @override
  List<Object> get props => [];
}
class GetWeatherForecastEvent extends DashboardEvent{
  final String city;
  GetWeatherForecastEvent(this.city);
  @override
  List<Object> get props => [];
}