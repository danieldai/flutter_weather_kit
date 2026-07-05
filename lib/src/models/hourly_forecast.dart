import 'package:flutter/material.dart';

import 'hourly_forecast_data.dart';
import 'metadata.dart';

/// The forecast for the next hour.
///
/// https://developer.apple.com/documentation/weatherkitrestapi/hourlyforecast
@immutable
class HourlyForecast {
  final String name;
  final Metadata metadata;

  /// An array of hourly forecasts.
  final List<HourlyForecastData>? hours;

  /// A URL that provides more information about the forecast.
  final String? learnMoreURL;

  const HourlyForecast({
    required this.name,
    required this.metadata,
    this.hours,
    this.learnMoreURL,
  });

  factory HourlyForecast.fromMap(Map<String, dynamic> map) {
    return HourlyForecast(
      name: map['name'] as String,
      metadata: Metadata.fromMap(map['metadata']),
      hours: map['hours'] != null
          ? List<HourlyForecastData>.from(
              map['hours'].map((x) => HourlyForecastData.fromMap(x)))
          : null,
      learnMoreURL: map['learnMoreURL'] as String?,
    );
  }
}
