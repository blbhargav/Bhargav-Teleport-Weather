part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();
}

class HomeInitial extends HomeState {
  @override
  List<Object> get props => [];
}

class ConnectionErrorState extends HomeState {
  @override
  List<Object> get props => [];
}
class DashboardPageState extends HomeState{
  @override
  List<Object> get props => [];
}
class CitiesPageState extends HomeState{
  @override
  List<Object> get props => [];
}
class SettingsPageState extends HomeState{
  @override
  List<Object> get props => [];
}