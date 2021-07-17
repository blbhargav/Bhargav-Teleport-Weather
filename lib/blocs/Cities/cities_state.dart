part of 'cities_bloc.dart';

abstract class CitiesState extends Equatable {
  const CitiesState();
}

class CitiesInitial extends CitiesState {
  @override
  List<Object> get props => [];
}
class DisplayCitiesState extends CitiesState{
  final List<String> cities;
  DisplayCitiesState(this.cities);
  @override
  List<Object> get props => [];
}
class RefreshCityState extends CitiesState{
  @override
  List<Object> get props => [];
}