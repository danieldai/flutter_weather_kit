import 'package:flutter/material.dart';

import 'enums.dart';
import 'metadata.dart';

/// The forecast for the next hour.
///
/// https://developer.apple.com/documentation/weatherkitrestapi/nexthourforecast
@immutable
class NextHourForecast {
  final String name;
  final Metadata metadata;

  /// The time the forecast ends.
  final DateTime? forecastEnd;

  /// The time the forecast begins.
  final DateTime? forecastStart;

  /// An array of minute forecasts.
  final List<MinuteForecast>? minutes;

  /// A summary of the forecast.
  final NextHourForecastSummary? summary;

  const NextHourForecast({
    required this.name,
    required this.metadata,
    this.forecastEnd,
    this.forecastStart,
    this.minutes,
    this.summary,
  });

  factory NextHourForecast.fromMap(Map<String, dynamic> map) {
    return NextHourForecast(
      name: map['name'] as String,
      metadata: Metadata.fromMap(map['metadata']),
      forecastEnd: map['forecastEnd'] != null
          ? DateTime.parse(map['forecastEnd']).toLocal()
          : null,
      forecastStart: map['forecastStart'] != null
          ? DateTime.parse(map['forecastStart']).toLocal()
          : null,
      minutes: map['minutes'] != null
          ? List<MinuteForecast>.from(
              map['minutes'].map((x) => MinuteForecast.fromMap(x)))
          : null,
      summary: map['summary'] != null
          ? NextHourForecastSummary.fromMap(map['summary'])
          : null,
    );
  }
}

/// The forecast for a specific minute.
@immutable
class MinuteForecast {
  /// (Required) The time of the forecast.
  final DateTime forecastStart;

  /// The precipitation intensity, in millimeters per hour.
  final double? precipitationIntensity;

  /// (Required) The type of precipitation forecasted.
  final PrecipitationType precipitationType;

  /// The probability of precipitation during this minute, from 0 to 1.
  final double? precipitationChance;

  const MinuteForecast({
    required this.forecastStart,
    this.precipitationIntensity,
    required this.precipitationType,
    this.precipitationChance,
  });

  factory MinuteForecast.fromMap(Map<String, dynamic> map) {
    return MinuteForecast(
      forecastStart: DateTime.parse(map['forecastStart']).toLocal(),
      precipitationIntensity: map['precipitationIntensity']?.toDouble(),
      precipitationType:
          PrecipitationType.values.byName(map['precipitationType']),
      precipitationChance: map['precipitationChance']?.toDouble(),
    );
  }
}

/// A summary of the next hour forecast.
@immutable
class NextHourForecastSummary {
  /// The start time of the forecast.
  final DateTime? startTime;

  /// The end time of the forecast.
  final DateTime? endTime;

  /// The type of precipitation in the forecast.
  final PrecipitationType? precipitationType;

  /// A description of the forecast.
  final String? condition;

  /// The maximum precipitation intensity during the forecast period.
  final double? maxPrecipitationIntensity;

  const NextHourForecastSummary({
    this.startTime,
    this.endTime,
    this.precipitationType,
    this.condition,
    this.maxPrecipitationIntensity,
  });

  factory NextHourForecastSummary.fromMap(Map<String, dynamic> map) {
    return NextHourForecastSummary(
      startTime: map['startTime'] != null
          ? DateTime.parse(map['startTime']).toLocal()
          : null,
      endTime: map['endTime'] != null
          ? DateTime.parse(map['endTime']).toLocal()
          : null,
      precipitationType: map['precipitationType'] != null
          ? PrecipitationType.values.byName(map['precipitationType'])
          : null,
      condition: map['condition'],
      maxPrecipitationIntensity:
          map['maxPrecipitationIntensity']?.toDouble(),
    );
  }
}
