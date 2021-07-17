/// coord : {"lon":77.2167,"lat":28.6667}
/// weather : [{"id":721,"main":"Haze","description":"haze","icon":"50d"}]
/// base : "stations"
/// main : {"temp":309.2,"feels_like":316.2,"temp_min":309.2,"temp_max":309.2,"pressure":1003,"humidity":56}
/// visibility : 3000
/// wind : {"speed":1.54,"deg":260}
/// clouds : {"all":40}
/// dt : 1626504494
/// sys : {"type":1,"id":9165,"country":"IN","sunrise":1626480236,"sunset":1626529812}
/// timezone : 19800
/// id : 1273294
/// name : "Delhi"
/// cod : 200

class CurrentWeather {
  Coord? _coord;
  List<Weather>? _weather;
  String? _base;
  Main? _main;
  num? _visibility;
  Wind? _wind;
  Clouds? _clouds;
  num? _dt;
  Sys? _sys;
  num? _timezone;
  num? _id;
  String? _name;
  num? _cod;

  Coord? get coord => _coord;
  List<Weather>? get weather => _weather;
  String? get base => _base;
  Main? get main => _main;
  num? get visibility => _visibility;
  Wind? get wind => _wind;
  Clouds? get clouds => _clouds;
  num? get dt => _dt;
  Sys? get sys => _sys;
  num? get timezone => _timezone;
  num? get id => _id;
  String? get name => _name;
  num? get cod => _cod;

  CurrentWeather({
      Coord? coord, 
      List<Weather>? weather, 
      String? base, 
      Main? main, 
      num? visibility, 
      Wind? wind, 
      Clouds? clouds, 
      num? dt, 
      Sys? sys, 
      num? timezone, 
      num? id, 
      String? name, 
      num? cod}){
    _coord = coord;
    _weather = weather;
    _base = base;
    _main = main;
    _visibility = visibility;
    _wind = wind;
    _clouds = clouds;
    _dt = dt;
    _sys = sys;
    _timezone = timezone;
    _id = id;
    _name = name;
    _cod = cod;
}

  CurrentWeather.fromJson(dynamic json) {
    _coord = json["coord"] != null ? Coord.fromJson(json["coord"]) : null;
    if (json["weather"] != null) {
      _weather = [];
      json["weather"].forEach((v) {
        _weather?.add(Weather.fromJson(v));
      });
    }
    _base = json["base"];
    _main = json["main"] != null ? Main.fromJson(json["main"]) : null;
    _visibility = json["visibility"];
    _wind = json["wind"] != null ? Wind.fromJson(json["wind"]) : null;
    _clouds = json["clouds"] != null ? Clouds.fromJson(json["clouds"]) : null;
    _dt = json["dt"];
    _sys = json["sys"] != null ? Sys.fromJson(json["sys"]) : null;
    _timezone = json["timezone"];
    _id = json["id"];
    _name = json["name"];
    _cod = json["cod"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_coord != null) {
      map["coord"] = _coord?.toJson();
    }
    if (_weather != null) {
      map["weather"] = _weather?.map((v) => v.toJson()).toList();
    }
    map["base"] = _base;
    if (_main != null) {
      map["main"] = _main?.toJson();
    }
    map["visibility"] = _visibility;
    if (_wind != null) {
      map["wind"] = _wind?.toJson();
    }
    if (_clouds != null) {
      map["clouds"] = _clouds?.toJson();
    }
    map["dt"] = _dt;
    if (_sys != null) {
      map["sys"] = _sys?.toJson();
    }
    map["timezone"] = _timezone;
    map["id"] = _id;
    map["name"] = _name;
    map["cod"] = _cod;
    return map;
  }

}

/// type : 1
/// id : 9165
/// country : "IN"
/// sunrise : 1626480236
/// sunset : 1626529812

class Sys {
  num? _type;
  num? _id;
  String? _country;
  num? _sunrise;
  num? _sunset;

  num? get type => _type;
  num? get id => _id;
  String? get country => _country;
  num? get sunrise => _sunrise;
  num? get sunset => _sunset;

  Sys({
      num? type, 
      num? id, 
      String? country, 
      num? sunrise, 
      num? sunset}){
    _type = type;
    _id = id;
    _country = country;
    _sunrise = sunrise;
    _sunset = sunset;
}

  Sys.fromJson(dynamic json) {
    _type = json["type"];
    _id = json["id"];
    _country = json["country"];
    _sunrise = json["sunrise"];
    _sunset = json["sunset"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["type"] = _type;
    map["id"] = _id;
    map["country"] = _country;
    map["sunrise"] = _sunrise;
    map["sunset"] = _sunset;
    return map;
  }

}

/// all : 40

class Clouds {
  num? _all;

  num? get all => _all;

  Clouds({
      num? all}){
    _all = all;
}

  Clouds.fromJson(dynamic json) {
    _all = json["all"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["all"] = _all;
    return map;
  }

}

/// speed : 1.54
/// deg : 260

class Wind {
  num? _speed;
  num? _deg;

  num? get speed => _speed;
  num? get deg => _deg;

  Wind({
      num? speed, 
      num? deg}){
    _speed = speed;
    _deg = deg;
}

  Wind.fromJson(dynamic json) {
    _speed = json["speed"];
    _deg = json["deg"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["speed"] = _speed;
    map["deg"] = _deg;
    return map;
  }

}

/// temp : 309.2
/// feels_like : 316.2
/// temp_min : 309.2
/// temp_max : 309.2
/// pressure : 1003
/// humidity : 56

class Main {
  num? _temp;
  num? _feelsLike;
  num? _tempMin;
  num? _tempMax;
  num? _pressure;
  num? _humidity;

  num? get temp => _temp;
  num? get feelsLike => _feelsLike;
  num? get tempMin => _tempMin;
  num? get tempMax => _tempMax;
  num? get pressure => _pressure;
  num? get humidity => _humidity;

  Main({
      num? temp, 
      num? feelsLike, 
      num? tempMin, 
      num? tempMax, 
      num? pressure, 
      num? humidity}){
    _temp = temp;
    _feelsLike = feelsLike;
    _tempMin = tempMin;
    _tempMax = tempMax;
    _pressure = pressure;
    _humidity = humidity;
}

  Main.fromJson(dynamic json) {
    _temp = json["temp"];
    _feelsLike = json["feels_like"];
    _tempMin = json["temp_min"];
    _tempMax = json["temp_max"];
    _pressure = json["pressure"];
    _humidity = json["humidity"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["temp"] = _temp;
    map["feels_like"] = _feelsLike;
    map["temp_min"] = _tempMin;
    map["temp_max"] = _tempMax;
    map["pressure"] = _pressure;
    map["humidity"] = _humidity;
    return map;
  }

}

/// id : 721
/// main : "Haze"
/// description : "haze"
/// icon : "50d"

class Weather {
  num? _id;
  String? _main;
  String? _description;
  String? _icon;

  num? get id => _id;
  String? get main => _main;
  String? get description => _description;
  String? get icon => _icon;

  Weather({
      num? id, 
      String? main, 
      String? description, 
      String? icon}){
    _id = id;
    _main = main;
    _description = description;
    _icon = icon;
}

  Weather.fromJson(dynamic json) {
    _id = json["id"];
    _main = json["main"];
    _description = json["description"];
    _icon = json["icon"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["main"] = _main;
    map["description"] = _description;
    map["icon"] = _icon;
    return map;
  }

}

/// lon : 77.2167
/// lat : 28.6667

class Coord {
  num? _lon;
  num? _lat;

  num? get lon => _lon;
  num? get lat => _lat;

  Coord({
      num? lon, 
      num? lat}){
    _lon = lon;
    _lat = lat;
}

  Coord.fromJson(dynamic json) {
    _lon = json["lon"];
    _lat = json["lat"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["lon"] = _lon;
    map["lat"] = _lat;
    return map;
  }

}