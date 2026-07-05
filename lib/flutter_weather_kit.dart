/// flutter_weather_kit - A Flutter package for Apple WeatherKit REST API
///
/// This package provides a clean, type-safe interface to Apple's WeatherKit
/// REST API, supporting current weather, daily/hourly forecasts, next-hour
/// precipitation, and weather alerts.
///
/// Usage:
/// ```dart
/// import 'package:flutter_weather_kit/flutter_weather_kit.dart';
///
/// final weatherKit = WeatherKit(
///   config: WeatherKitConfig(
///     teamId: 'YOUR_TEAM_ID',
///     keyId: 'YOUR_KEY_ID',
///     serviceId: 'com.yourcompany.weather',
///     privateKeyPem: '-----BEGIN PRIVATE KEY-----\n...\n-----END PRIVATE KEY-----',
///     language: 'en_US',
///     timezone: 'America/New_York',
///   ),
/// );
///
/// final data = await weatherKit.getWeatherData(
///   latitude: 37.3318,
///   longitude: -122.0312,
///   dataSets: {
///     DataSet.currentWeather,
///     DataSet.forecastDaily,
///     DataSet.forecastHourly,
///   },
///   countryCode: 'US',
/// );
/// ```
library flutter_weather_kit;

export 'src/models/current_weather.dart';
export 'src/models/daily_forecast.dart';
export 'src/models/daily_forecast_data.dart';
export 'src/models/day_part_forecast.dart';
export 'src/models/enums.dart';
export 'src/models/hourly_forecast.dart';
export 'src/models/hourly_forecast_data.dart';
export 'src/models/metadata.dart';
export 'src/models/next_hour_forecast.dart';
export 'src/models/weather_alert.dart';
export 'src/models/weather_data.dart';
export 'src/token.dart';
export 'src/weather_kit.dart';
