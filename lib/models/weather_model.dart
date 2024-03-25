import 'package:weather_app/services/dto/weather_model_dto.dart';
import 'package:weather_app/utils/assets_utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum WeatherType {
  cloudyWindyMoon,
  nightTimeShower,
  wind,
  windyMoon,
  cloudy,
  rainySun,
  sunny,
  mainlyClear,
  snow,
  zap;

  String get iconPath {
    switch (this) {
      case WeatherType.wind:
        return AssetsUtils.windIconPath;
      case WeatherType.zap:
        return AssetsUtils.zapIconPath;
      case WeatherType.cloudy:
        return AssetsUtils.cloudyIconPath;
      case WeatherType.cloudyWindyMoon:
        return AssetsUtils.cloudyWindyMoonIconPath;
      case WeatherType.nightTimeShower:
        return AssetsUtils.nightTimeShowerIconPath;
      case WeatherType.rainySun:
        return AssetsUtils.rainySunIconPath;
      case WeatherType.windyMoon:
        return AssetsUtils.windyMoonIconPath;
      case WeatherType.sunny:
        return AssetsUtils.sunnyIconPath;
      case WeatherType.mainlyClear:
        return AssetsUtils.mainlyClearIconPath;
      case WeatherType.snow:
        return AssetsUtils.snowIconPath;
    }
  }

  String description(context) {
    var localizations = AppLocalizations.of(context)!;
    switch (this) {
      case WeatherType.wind:
        return localizations.tornadoLabel;
      case WeatherType.zap:
        return localizations.electricalStormLabel;
      case WeatherType.cloudy:
        return localizations.cloudyLabel;
      case WeatherType.cloudyWindyMoon:
        return localizations.fastWindLabel;
      case WeatherType.nightTimeShower:
        return localizations.nightTimeShowerLabel;
      case WeatherType.rainySun:
        return localizations.rainyLabel;
      case WeatherType.windyMoon:
        return localizations.clearNightLabel;
      case WeatherType.sunny:
        return localizations.sunnyLabel;
      case WeatherType.mainlyClear:
        return localizations.mainlyClearLabel;
      case WeatherType.snow:
        return localizations.snowLabel;
    }
  }
}

WeatherType determineWeatherType(int? weatherCode, int? weatherIsDay) {
  switch (weatherCode) {
    case 0:
      return (weatherIsDay == 0) ? WeatherType.windyMoon : WeatherType.sunny;
    case 1:
    case 2:
    case 3:
      return (weatherIsDay == 0)
          ? WeatherType.cloudyWindyMoon
          : WeatherType.mainlyClear;
    case 45:
    case 48:
    case 51:
    case 53:
    case 55:
    case 61:
    case 63:
    case 65:
      return (weatherIsDay == 0)
          ? WeatherType.cloudyWindyMoon
          : WeatherType.rainySun;
    case 66:
    case 67:
    case 71:
    case 73:
    case 75:
    case 77:
    case 85:
    case 86:
      return (weatherIsDay == 0)
          ? WeatherType.cloudyWindyMoon
          : WeatherType.snow;
    case 80:
    case 81:
    case 82:
      return (weatherIsDay == 0)
          ? WeatherType.cloudyWindyMoon
          : WeatherType.cloudy;
    case 56:
    case 57:
      return (weatherIsDay == 0)
          ? WeatherType.cloudyWindyMoon
          : WeatherType.nightTimeShower;
    case 95:
      return WeatherType.zap;
    case 96:
    case 99:
      return (weatherIsDay == 0)
          ? WeatherType.cloudyWindyMoon
          : WeatherType.cloudy;
    default:
      return (weatherIsDay == 0)
          ? WeatherType.cloudyWindyMoon
          : WeatherType.mainlyClear;
  }
}

class Weather {
  Weather({
    required this.locationName,
    this.temperature,
    required this.temperatureMin,
    required this.temperatureMax,
    required this.weatherType,
  });
  final String locationName;
  final int? temperature;
  final int temperatureMin;
  final int temperatureMax;
  final WeatherType weatherType;
  factory Weather.fromDtoWithName(WeatherData dto, String name) {
    int? weatherCode = dto.current?.weatherCode;
    int? weatherIsDay = dto.current?.isDay;
    WeatherType weatherType = determineWeatherType(weatherCode, weatherIsDay);
    return Weather(
      locationName: name,
      temperature: dto.current?.temperature2m.toInt(),
      temperatureMax: dto.daily!.temperature2mMax[0].toInt(),
      temperatureMin: dto.daily!.temperature2mMin[0].toInt(),
      weatherType: weatherType,
    );
  }
}
