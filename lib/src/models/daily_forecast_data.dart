import 'package:flutter/material.dart';

import 'day_part_forecast.dart';
import 'enums.dart';

///  The historical or forecasted weather conditions for a specified day.
/// https://developer.apple.com/documentation/weatherkitrestapi/dayweatherconditions
@immutable
class DailyForecastData {
  /// (Required) An enumeration value indicating the condition at the time.
  final String conditionCode;

  /// (Required) The ending date and time of the day.
  final DateTime forecastEnd;

  /// (Required) The starting date and time of the day.
  final DateTime forecastStart;

  /// (Required) The maximum ultraviolet index value during the day.
  final int maxUvIndex;

  /// (Required) The phase of the moon on the specified day.
  final String moonPhase;

  /// The time of moonrise on the specified day.
  final DateTime? moonrise;

  /// The time of moonset on the specified day.
  final DateTime? moonset;

  /// (Required) The amount of precipitation forecasted to occur during the day, in millimeters.
  final double precipitationAmount;

  /// (Required) The chance of precipitation forecasted to occur during the day.
  final double precipitationChance;

  /// (Required) The type of precipitation forecasted to occur during the day.
  final PrecipitationType precipitationType;

  /// (Required) The depth of snow as ice crystals forecasted to occur during the day, in millimeters.
  final double snowfallAmount;

  /// The time when the sun is lowest in the sky.
  final DateTime? solarMidnight;

  /// The time when the sun is highest in the sky.
  final DateTime? solarNoon;

  /// The time when the top edge of the sun reaches the horizon in the morning.
  final DateTime? sunrise;

  /// The time when the sun is 18 degrees below the horizon in the morning.
  final DateTime? sunriseAstronomical;

  /// The time when the sun is 6 degrees below the horizon in the morning.
  final DateTime? sunriseCivil;

  /// The time when the sun is 12 degrees below the horizon in the morning.
  final DateTime? sunriseNautical;

  /// The time when the top edge of the sun reaches the horizon in the evening.
  final DateTime? sunset;

  /// The time when the sun is 18 degrees below the horizon in the evening.
  final DateTime? sunsetAstronomical;

  /// The time when the sun is 6 degrees below the horizon in the evening.
  final DateTime? sunsetCivil;

  /// The time when the sun is 12 degrees below the horizon in the evening.
  final DateTime? sunsetNautical;

  /// (Required) The maximum temperature forecasted to occur during the day, in degrees Celsius.
  final double temperatureMax;

  /// (Required) The minimum temperature forecasted to occur during the day, in degrees Celsius.
  final double temperatureMin;

  /// The forecast between 7 AM and 7 PM for the day.
  final DayPartForecast? daytimeForecast;

  /// The day part forecast between 7 PM and 7 AM for the overnight.
  final DayPartForecast? overnightForecast;

  final DayPartForecast? restOfDayForecast;

  const DailyForecastData({
    required this.conditionCode,
    required this.forecastEnd,
    required this.forecastStart,
    required this.maxUvIndex,
    required this.moonPhase,
    this.moonrise,
    this.moonset,
    required this.precipitationAmount,
    required this.precipitationChance,
    required this.precipitationType,
    required this.snowfallAmount,
    this.solarMidnight,
    this.solarNoon,
    this.sunrise,
    this.sunriseAstronomical,
    this.sunriseCivil,
    this.sunriseNautical,
    this.sunset,
    this.sunsetAstronomical,
    this.sunsetCivil,
    this.sunsetNautical,
    required this.temperatureMax,
    required this.temperatureMin,
    this.daytimeForecast,
    this.overnightForecast,
    this.restOfDayForecast,
  });

  factory DailyForecastData.fromMap(Map<String, dynamic> map) {
    return DailyForecastData(
      conditionCode: map['conditionCode'] as String,
      forecastEnd: DateTime.parse(map['forecastEnd']).toLocal(),
      forecastStart: DateTime.parse(map['forecastStart']).toLocal(),
      maxUvIndex: map['maxUvIndex'] as int? ?? 0,
      moonPhase: map['moonPhase'] as String,
      moonrise:
          map['moonrise'] != null ? DateTime.parse(map['moonrise']).toLocal() : null,
      moonset: map['moonset'] != null ? DateTime.parse(map['moonset']).toLocal() : null,
      precipitationAmount: map['precipitationAmount']?.toDouble() ?? 0.0,
      precipitationChance: map['precipitationChance']?.toDouble() ?? 0.0,
      precipitationType:
          PrecipitationType.values.byName(map['precipitationType']),
      snowfallAmount: map['snowfallAmount']?.toDouble() ?? 0.0,
      solarMidnight: map['solarMidnight'] != null
          ? DateTime.parse(map['solarMidnight']).toLocal()
          : null,
      solarNoon:
          map['solarNoon'] != null ? DateTime.parse(map['solarNoon']).toLocal() : null,
      sunrise: map['sunrise'] != null ? DateTime.parse(map['sunrise']).toLocal() : null,
      sunriseAstronomical: map['sunriseAstronomical'] != null
          ? DateTime.parse(map['sunriseAstronomical']).toLocal()
          : null,
      sunriseCivil: map['sunriseCivil'] != null
          ? DateTime.parse(map['sunriseCivil']).toLocal()
          : null,
      sunriseNautical: map['sunriseNautical'] != null
          ? DateTime.parse(map['sunriseNautical']).toLocal()
          : null,
      sunset: map['sunset'] != null ? DateTime.parse(map['sunset']).toLocal() : null,
      sunsetAstronomical: map['sunsetAstronomical'] != null
          ? DateTime.parse(map['sunsetAstronomical']).toLocal()
          : null,
      sunsetCivil: map['sunsetCivil'] != null
          ? DateTime.parse(map['sunsetCivil']).toLocal()
          : null,
      sunsetNautical: map['sunsetNautical'] != null
          ? DateTime.parse(map['sunsetNautical']).toLocal()
          : null,
      temperatureMax: map['temperatureMax']?.toDouble() ?? 0.0,
      temperatureMin: map['temperatureMin']?.toDouble() ?? 0.0,
      daytimeForecast: map['daytimeForecast'] != null
          ? DayPartForecast.fromMap(map['daytimeForecast'])
          : null,
      overnightForecast: map['overnightForecast'] != null
          ? DayPartForecast.fromMap(map['overnightForecast'])
          : null,
      restOfDayForecast: map['restOfDayForecast'] != null
          ? DayPartForecast.fromMap(map['restOfDayForecast'])
          : null,
    );
  }
}
