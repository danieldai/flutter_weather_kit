import 'package:flutter/material.dart';

import 'metadata.dart';

/// The severity of the weather alert.
///
/// https://developer.apple.com/documentation/weatherkit/weatheralertseverity
enum WeatherAlertSeverity {
  /// The event is potentially catastrophic (extreme).
  extreme,

  /// The event is potentially dangerous (severe).
  severe,

  /// The event may cause some disruption (moderate).
  moderate,

  /// The event is minor.
  minor,

  /// The severity is unknown.
  unknown,
}

/// The urgency of the weather alert.
///
/// https://developer.apple.com/documentation/weatherkit/weatheralerturgency
enum WeatherAlertUrgency {
  /// Take responsive action immediately.
  immediate,

  /// Take responsive action within an hour.
  expected,

  /// Take responsive action in the future.
  future,

  /// Responsive action is no longer required.
  past,

  /// The urgency is unknown.
  unknown,
}

/// The certainty of the weather alert.
///
/// https://developer.apple.com/documentation/weatherkit/weatheralertcertainty
enum WeatherAlertCertainty {
  /// The event has already been observed.
  observed,

  /// The event is likely to occur (>50% chance).
  likely,

  /// The event is possible (<50% chance).
  possible,

  /// The event is unlikely to occur.
  unlikely,

  /// The certainty is unknown.
  unknown,
}

/// A weather alert.
///
/// https://developer.apple.com/documentation/weatherkitrestapi/weatheralert
@immutable
class WeatherAlert {
  /// (Required) The unique identifier for the alert.
  final String id;

  /// The area of the alert.
  final String? areaId;

  /// The name of the area affected by the alert.
  final String? areaName;

  /// (Required) The description of the alert.
  final String description;

  /// The detailed description of the alert.
  final String? detailedDescription;

  /// A URL that provides more information about the alert.
  final String? detailsUrl;

  /// (Required) The effective time of the alert.
  final DateTime effectiveTime;

  /// The time the alert is no longer valid.
  final DateTime? expireTime;

  /// The time the alert was last updated.
  final DateTime? issuedTime;

  /// The time the alert event begins.
  final DateTime? onsetTime;

  /// The severity of the alert.
  final WeatherAlertSeverity? severity;

  /// The certainty of the alert.
  final WeatherAlertCertainty? certainty;

  /// The urgency of the alert.
  final WeatherAlertUrgency? urgency;

  /// The source of the alert.
  final String? source;

  /// The type of the alert event.
  final String? event;

  /// The response type for the alert.
  final String? responseType;

  /// The instruction for the alert.
  final String? instruction;

  /// The identifier of the headquarter office issuing the alert.
  final String? sender;

  /// The name of the headquarter office issuing the alert.
  final String? senderName;

  const WeatherAlert({
    required this.id,
    this.areaId,
    this.areaName,
    required this.description,
    this.detailedDescription,
    this.detailsUrl,
    required this.effectiveTime,
    this.expireTime,
    this.issuedTime,
    this.onsetTime,
    this.severity,
    this.certainty,
    this.urgency,
    this.source,
    this.event,
    this.responseType,
    this.instruction,
    this.sender,
    this.senderName,
  });

  factory WeatherAlert.fromMap(Map<String, dynamic> map) {
    return WeatherAlert(
      id: map['id'] as String,
      areaId: map['areaId'],
      areaName: map['areaName'],
      description: map['description'] as String,
      detailedDescription: map['detailedDescription'],
      detailsUrl: map['detailsUrl'],
      effectiveTime: DateTime.parse(map['effectiveTime']).toLocal(),
      expireTime: map['expireTime'] != null
          ? DateTime.parse(map['expireTime']).toLocal()
          : null,
      issuedTime: map['issuedTime'] != null
          ? DateTime.parse(map['issuedTime']).toLocal()
          : null,
      onsetTime: map['onsetTime'] != null
          ? DateTime.parse(map['onsetTime']).toLocal()
          : null,
      severity: map['severity'] != null
          ? WeatherAlertSeverity.values.byName(map['severity'])
          : null,
      certainty: map['certainty'] != null
          ? WeatherAlertCertainty.values.byName(map['certainty'])
          : null,
      urgency: map['urgency'] != null
          ? WeatherAlertUrgency.values.byName(map['urgency'])
          : null,
      source: map['source'],
      event: map['event'],
      responseType: map['responseType'],
      instruction: map['instruction'],
      sender: map['sender'],
      senderName: map['senderName'],
    );
  }
}

/// A collection of weather alerts.
///
/// https://developer.apple.com/documentation/weatherkitrestapi/weatheralertcollection
@immutable
class WeatherAlertCollection {
  final String name;
  final Metadata metadata;

  /// An array of weather alerts.
  final List<WeatherAlert>? alerts;

  const WeatherAlertCollection({
    required this.name,
    required this.metadata,
    this.alerts,
  });

  factory WeatherAlertCollection.fromMap(Map<String, dynamic> map) {
    return WeatherAlertCollection(
      name: map['name'] as String,
      metadata: Metadata.fromMap(map['metadata']),
      alerts: map['alerts'] != null
          ? List<WeatherAlert>.from(
              map['alerts'].map((x) => WeatherAlert.fromMap(x)))
          : null,
    );
  }
}
