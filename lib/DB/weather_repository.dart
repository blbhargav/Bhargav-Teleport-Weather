import 'package:geolocator/geolocator.dart';
import 'package:teleport_weather_bhargav/models/current_weather.dart';
import 'package:teleport_weather_bhargav/models/forecast_weather.dart';

import 'weather_data_provider.dart';

class WeatherRepository {
  WeatherDataProvider _weatherDataProvider = WeatherDataProvider();

  Future<List<String>> getCities()=>_weatherDataProvider.getCities();
  Future<CurrentWeather?> getCurrentWeather(String city) => _weatherDataProvider.getCurrentWeather(city);
  Future<CurrentWeather?> getCurrentWeatherFromLatLang(Position position) => _weatherDataProvider.getCurrentWeatherFromLatLang(position);

  Future<ForecastWeather?> getWeatherForecast(String city) =>_weatherDataProvider.getWeatherForecast(city);
}