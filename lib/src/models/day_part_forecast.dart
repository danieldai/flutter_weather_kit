import 'package:flutter/material.dart';

import 'enums.dart';

/// A summary forecast for a daytime or overnight period.
///
/// https://developer.apple.com/documentation/weatherkitrestapi/daypartforecast
@immutable
class DayPartForecast {
  /// (Required) The percentage of the sky covered with clouds during the period, from 0 to 1.
  final double cloudCover;

  /// (Required) An enumeration value indicating the condition at the time.
  final String conditionCode;

  /// (Required) The ending date and time of the forecast.
  final DateTime forecastEnd;

  /// (Required) The starting date and time of the forecast.
  final DateTime forecastStart;

  /// (Required) The relative humidity during the period, from 0 to 1.
  final double humidity;

  /// (Required) The amount of precipitation forecasted to occur during the period, in millimeters.
  final double precipitationAmount;

  /// (Required) The chance of precipitation forecasted to occur during the period.
  final double precipitationChance;

  /// (Required) The type of precipitation forecasted to occur during the period.
  final PrecipitationType precipitationType;

  /// (Required) The depth of snow as ice crystals forecasted to occur during the period, in millimeters.
  final double snowfallAmount;

  /// The direction the wind is forecasted to come from during the period, in degrees.
  final int? windDirection;

  /// (Required) The average speed the wind is forecasted to be during the period, in kilometers per hour.
  final double windSpeed;

  const DayPartForecast({
    required this.cloudCover,
    required this.conditionCode,
    required this.forecastEnd,
    required this.forecastStart,
    required this.humidity,
    required this.precipitationAmount,
    required this.precipitationChance,
    required this.precipitationType,
    required this.snowfallAmount,
    this.windDirection,
    required this.windSpeed,
  });

  factory DayPartForecast.fromMap(Map<String, dynamic> map) {
    return DayPartForecast(
      cloudCover: map['cloudCover']?.toDouble() ?? 0.0,
      conditionCode: map['conditionCode'] as String,
      forecastEnd: DateTime.parse(map['forecastEnd']).toLocal(),
      forecastStart: DateTime.parse(map['forecastStart']).toLocal(),
      humidity: map['humidity']?.toDouble() ?? 0.0,
      precipitationAmount: map['precipitationAmount']?.toDouble() ?? 0.0,
      precipitationChance: map['precipitationChance']?.toDouble() ?? 0.0,
      precipitationType:
          PrecipitationType.values.byName(map['precipitationType']),
      snowfallAmount: map['snowfallAmount']?.toDouble() ?? 0.0,
      windDirection: map['windDirection'] as int?,
      windSpeed: map['windSpeed']?.toDouble() ?? 0.0,
    );
  }
}
