import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefKeys {
  SharedPrefKeys._();
  static const String darkModeEnabled = 'darkModeEnabled';
  static const String cities = 'cities';
}

class SharedPreferencesService {
  static SharedPreferencesService? _instance;
  static SharedPreferences? _preferences;

  SharedPreferencesService._internal();

  static Future<SharedPreferencesService> get instance async {
    //SharedPreferences.setMockInitialValues({});
    if (_instance == null) {
      _instance = SharedPreferencesService._internal();
    }

    if (_preferences == null) {
      _preferences = await SharedPreferences.getInstance();
    }

    return _instance!;
  }

  Future<void> setDarkModeInfo(bool isDarkModeEnabled) async =>
      await _preferences!.setBool(SharedPrefKeys.darkModeEnabled, isDarkModeEnabled);

  bool get isDarkModeEnabled => _preferences!.getBool(SharedPrefKeys.darkModeEnabled)??false;

  Future<bool> clearDatabase()async{
    return await _preferences!.clear();
  }

  Future<void> saveCities(List<String> cities)async =>
    await _preferences!.setStringList(SharedPrefKeys.cities, cities);
  List<String> get getCitiesList => _preferences!.getStringList(SharedPrefKeys.cities)??[];

}