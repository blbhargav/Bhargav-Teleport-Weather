import 'package:geolocator/geolocator.dart';
import 'package:teleport_weather_bhargav/models/current_weather.dart';
import 'package:teleport_weather_bhargav/models/forecast_weather.dart';

abstract class BaseProvider {
  void dispose();
}
abstract class BaseRepositoryProvider extends BaseProvider {
  Future<List<String>> getCities();
  Future<CurrentWeather?> getCurrentWeather(String city);
  Future<CurrentWeather?> getCurrentWeatherFromLatLang(Position position);
  Future<ForecastWeather?> getWeatherForecast(String city);

  Future<bool> addNewCity(String city);
}