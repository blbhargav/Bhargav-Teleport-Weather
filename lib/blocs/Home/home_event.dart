part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
  @override
  List<Object> get props => [];
}
class InitHomeScreen extends HomeEvent{}
class DashboardClickedEvent extends HomeEvent{}
class CitiesClickedEvent extends HomeEvent{}
class SettingsClickedEvent extends HomeEvent{}