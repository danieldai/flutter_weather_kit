import 'package:flutter/material.dart';

import 'daily_forecast_data.dart';
import 'metadata.dart';

/// A collection of day forecasts for a specified range of days.
/// https://developer.apple.com/documentation/weatherkitrestapi/dailyforecast
@immutable
class DailyForecast {
  final String name;
  final Metadata metadata;

  /// (Required) An array of the day forecast weather conditions.
  final List<DailyForecastData> days;

  /// A URL that provides more information about the forecast.
  final String? learnMoreURL;

  const DailyForecast({
    required this.name,
    required this.metadata,
    required this.days,
    this.learnMoreURL,
  });

  factory DailyForecast.fromMap(Map<String, dynamic> map) {
    return DailyForecast(
      name: map['name'] as String,
      metadata: Metadata.fromMap(map['metadata']),
      days: List<DailyForecastData>.from(
          map['days'].map((d) => DailyForecastData.fromMap(d))),
      learnMoreURL: map['learnMoreURL'] as String?,
    );
  }
}
