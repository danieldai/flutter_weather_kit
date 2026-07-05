import 'dart:convert';

import 'current_weather.dart';
import 'daily_forecast.dart';
import 'hourly_forecast.dart';
import 'next_hour_forecast.dart';
import 'weather_alert.dart';

/// The weather data for the requested location.
///
/// This is the top-level container for all weather data returned by the
/// WeatherKit REST API.
///
/// https://developer.apple.com/documentation/weatherkitrestapi/weatherdata
class WeatherData {
  /// The current weather conditions.
  final CurrentWeather? currentWeather;

  /// The daily forecast.
  final DailyForecast? forecastDaily;

  /// The hourly forecast.
  final HourlyForecast? forecastHourly;

  /// The next-hour precipitation forecast.
  final NextHourForecast? forecastNextHour;

  /// The weather alerts for the location.
  final WeatherAlertCollection? weatherAlerts;

  const WeatherData({
    this.currentWeather,
    this.forecastDaily,
    this.forecastHourly,
    this.forecastNextHour,
    this.weatherAlerts,
  });

  factory WeatherData.fromMap(Map<String, dynamic> map) {
    return WeatherData(
      currentWeather: map['currentWeather'] != null
          ? CurrentWeather.fromMap(map['currentWeather'])
          : null,
      forecastDaily: map['forecastDaily'] != null
          ? DailyForecast.fromMap(map['forecastDaily'])
          : null,
      forecastHourly: map['forecastHourly'] != null
          ? HourlyForecast.fromMap(map['forecastHourly'])
          : null,
      forecastNextHour: map['forecastNextHour'] != null
          ? NextHourForecast.fromMap(map['forecastNextHour'])
          : null,
      weatherAlerts: map['weatherAlerts'] != null
          ? WeatherAlertCollection.fromMap(map['weatherAlerts'])
          : null,
    );
  }

  factory WeatherData.fromJson(String source) =>
      WeatherData.fromMap(json.decode(source) as Map<String, dynamic>);
}
