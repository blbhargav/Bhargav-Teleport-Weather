part of 'cities_bloc.dart';

abstract class CitiesEvent extends Equatable {
  const CitiesEvent();
  @override
  List<Object> get props => [];
}
class GetCitiesEvent extends CitiesEvent{}
class RefreshEvent extends CitiesEvent{}

class AllCityClickedEvent extends CitiesEvent{}

class AddCityEvent extends CitiesEvent{
  final String city;
  AddCityEvent(this.city);
}