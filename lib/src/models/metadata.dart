import 'package:flutter/material.dart';

/// Descriptive information about the weather data.
///
/// https://developer.apple.com/documentation/weatherkitrestapi/metadata
@immutable
class Metadata {
  /// The URL of the legal attribution for the data source.
  final String attributionURL;

  /// (Required) The time when the weather data is no longer valid.
  final DateTime expireTime;

  /// The ISO language code for localizable fields.
  final String? language;

  /// (Required) The latitude of the relevant location.
  final double latitude;

  /// (Required) The longitude of the relevant location.
  final double longitude;

  /// The URL of a logo for the data provider.
  final String? providerLogo;

  /// The name of the data provider.
  final String? providerName;

  /// (Required) The time the weather data was procured.
  final DateTime readTime;

  /// The time the provider reported the weather data.
  final DateTime reportedTime;

  /// The weather data is temporarily unavailable from the provider.
  final bool? temporarilyUnavailable;

  /// The system of units that the weather data is reported in. This is set to metric.
  final String units;

  /// (Required) The data format version.
  final int version;

  const Metadata({
    required this.attributionURL,
    required this.expireTime,
    this.language,
    required this.latitude,
    required this.longitude,
    this.providerLogo,
    this.providerName,
    required this.readTime,
    required this.reportedTime,
    this.temporarilyUnavailable,
    required this.units,
    required this.version,
  });

  factory Metadata.fromMap(Map<String, dynamic> map) {
    return Metadata(
      attributionURL: map['attributionURL'] as String,
      expireTime: DateTime.parse(map['expireTime']).toLocal(),
      language: map['language'],
      latitude: map['latitude']?.toDouble() ?? 0.0,
      longitude: map['longitude']?.toDouble() ?? 0.0,
      providerLogo: map['providerLogo'],
      providerName: map['providerName'],
      readTime: DateTime.parse(map['readTime']).toLocal(),
      reportedTime: DateTime.parse(map['reportedTime']).toLocal(),
      temporarilyUnavailable: map['temporarilyUnavailable'],
      units: map['units'] as String,
      version: map['version'] as int,
    );
  }
}
