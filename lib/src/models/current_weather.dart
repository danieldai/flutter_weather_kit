import 'package:flutter/material.dart';

import 'enums.dart';
import 'metadata.dart';

/// The current weather conditions for the specified location.
///
/// https://developer.apple.com/documentation/weatherkitrestapi/currentweather
@immutable
class CurrentWeather {
  final String name;
  final Metadata metadata;

  /// (Required) The date and time.
  final DateTime asOf;

  /// The percentage of the sky covered with clouds during the period, from 0 to 1.
  final double? cloudCover;

  /// (Required) An enumeration value indicating the condition at the time.
  /// https://developer.apple.com/documentation/weatherkit/weathercondition
  final String conditionCode;

  /// A Boolean value indicating whether there is daylight.
  final bool? daylight;

  /// (Required) The relative humidity, from 0 to 1.
  final double humidity;

  /// (Required) The precipitation intensity, in millimeters per hour.
  final double precipitationIntensity;

  /// (Required) The sea level air pressure, in millibars.
  final double pressure;

  /// (Required) The direction of change of the sea-level air pressure.
  final PressureTrend pressureTrend;

  /// (Required) The current temperature, in degrees Celsius.
  final double temperature;

  /// (Required) The feels-like temperature when factoring wind and humidity, in degrees Celsius.
  final double temperatureApparent;

  /// (Required) The temperature at which relative humidity is 100%, in Celsius.
  final double temperatureDewPoint;

  /// (Required) The level of ultraviolet radiation.
  final int uvIndex;

  /// (Required) The distance at which terrain is visible, in meters.
  final double visibility;

  /// The direction of the wind, in degrees.
  final int? windDirection;

  /// The maximum wind gust speed, in kilometers per hour.
  final double? windGust;

  /// (Required) The wind speed, in kilometers per hour.
  final double windSpeed;

  const CurrentWeather({
    required this.name,
    required this.metadata,
    required this.asOf,
    this.cloudCover,
    required this.conditionCode,
    this.daylight,
    required this.humidity,
    required this.precipitationIntensity,
    required this.pressure,
    required this.pressureTrend,
    required this.temperature,
    required this.temperatureApparent,
    required this.temperatureDewPoint,
    required this.uvIndex,
    required this.visibility,
    this.windDirection,
    this.windGust,
    required this.windSpeed,
  });

  factory CurrentWeather.fromMap(Map<String, dynamic> map) {
    return CurrentWeather(
      name: map['name'] as String,
      metadata: Metadata.fromMap(map['metadata']),
      asOf: DateTime.parse(map['asOf']).toLocal(),
      cloudCover: map['cloudCover']?.toDouble(),
      conditionCode: map['conditionCode'] as String,
      daylight: map['daylight'] as bool?,
      humidity: map['humidity']?.toDouble() ?? 0.0,
      precipitationIntensity: map['precipitationIntensity']?.toDouble() ?? 0.0,
      pressure: map['pressure']?.toDouble() ?? 0.0,
      pressureTrend: PressureTrend.values.byName(map['pressureTrend']),
      temperature: map['temperature']?.toDouble() ?? 0.0,
      temperatureApparent: map['temperatureApparent']?.toDouble() ?? 0.0,
      temperatureDewPoint: map['temperatureDewPoint']?.toDouble() ?? 0.0,
      uvIndex: map['uvIndex'] as int? ?? 0,
      visibility: map['visibility']?.toDouble() ?? 0.0,
      windDirection: map['windDirection'] as int?,
      windGust: map['windGust']?.toDouble(),
      windSpeed: map['windSpeed']?.toDouble() ?? 0.0,
    );
  }

  factory CurrentWeather.fromJson(Map<String, dynamic> json) =>
      CurrentWeather.fromMap(json);
}
