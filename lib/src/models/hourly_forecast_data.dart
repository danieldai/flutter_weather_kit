import 'package:flutter/material.dart';

import 'enums.dart';

/// The forecast of hourly measurements.
///
/// https://developer.apple.com/documentation/weatherkitrestapi/hourlyconditions
@immutable
class HourlyForecastData {
  /// (Required) The percentage of the sky covered with clouds during the period, from 0 to 1.
  final double? cloudCover;

  /// (Required) An enumeration value indicating the condition at the time.
  final String conditionCode;

  /// (Required) A Boolean value indicating whether there is daylight.
  final bool? daylight;

  /// (Required) The ending date and time of the hour.
  final DateTime forecastEnd;

  /// (Required) The starting date and time of the hour.
  final DateTime forecastStart;

  /// (Required) The relative humidity during the hour, from 0 to 1.
  final double humidity;

  /// (Required) The precipitation intensity during the hour, in millimeters per hour.
  final double precipitationIntensity;

  /// (Required) The probability of precipitation during the hour, from 0 to 1.
  final double precipitationChance;

  /// (Required) The type of precipitation forecasted to occur during the hour.
  final PrecipitationType precipitationType;

  /// (Required) The sea-level air pressure, in millibars.
  final double pressure;

  /// (Required) The direction of change of the sea-level air pressure.
  final PressureTrend? pressureTrend;

  /// (Required) The temperature during the hour, in degrees Celsius.
  final double temperature;

  /// (Required) The feels-like temperature when considering wind and humidity, in degrees Celsius.
  final double temperatureApparent;

  /// (Required) The temperature at which relative humidity is 100% in Celsius.
  final double temperatureDewPoint;

  /// (Required) The level of ultraviolet radiation.
  final int uvIndex;

  /// (Required) The distance at which terrain is visible, in meters.
  final double? visibility;

  /// (Required) The direction of the wind, in degrees.
  final int? windDirection;

  /// (Required) The maximum wind gust speed, in kilometers per hour.
  final double? windGust;

  /// (Required) The wind speed, in kilometers per hour.
  final double windSpeed;

  const HourlyForecastData({
    this.cloudCover,
    required this.conditionCode,
    this.daylight,
    required this.forecastEnd,
    required this.forecastStart,
    required this.humidity,
    required this.precipitationIntensity,
    required this.precipitationChance,
    required this.precipitationType,
    required this.pressure,
    this.pressureTrend,
    required this.temperature,
    required this.temperatureApparent,
    required this.temperatureDewPoint,
    required this.uvIndex,
    this.visibility,
    this.windDirection,
    this.windGust,
    required this.windSpeed,
  });

  factory HourlyForecastData.fromMap(Map<String, dynamic> map) {
    return HourlyForecastData(
      cloudCover: map['cloudCover']?.toDouble(),
      conditionCode: map['conditionCode'] as String,
      daylight: map['daylight'] as bool?,
      forecastEnd: DateTime.parse(map['forecastEnd']).toLocal(),
      forecastStart: DateTime.parse(map['forecastStart']).toLocal(),
      humidity: map['humidity']?.toDouble() ?? 0.0,
      precipitationIntensity:
          map['precipitationIntensity']?.toDouble() ?? 0.0,
      precipitationChance: map['precipitationChance']?.toDouble() ?? 0.0,
      precipitationType:
          PrecipitationType.values.byName(map['precipitationType']),
      pressure: map['pressure']?.toDouble() ?? 0.0,
      pressureTrend: map['pressureTrend'] != null
          ? PressureTrend.values.byName(map['pressureTrend'])
          : null,
      temperature: map['temperature']?.toDouble() ?? 0.0,
      temperatureApparent: map['temperatureApparent']?.toDouble() ?? 0.0,
      temperatureDewPoint: map['temperatureDewPoint']?.toDouble() ?? 0.0,
      uvIndex: map['uvIndex'] as int? ?? 0,
      visibility: map['visibility']?.toDouble(),
      windDirection: map['windDirection'] as int?,
      windGust: map['windGust']?.toDouble(),
      windSpeed: map['windSpeed']?.toDouble() ?? 0.0,
    );
  }
}
