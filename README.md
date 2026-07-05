# flutter_weather_kit

[![pub package](https://img.shields.io/pub/v/flutter_weather_kit.svg)](https://pub.dev/packages/flutter_weather_kit)
[![license](https://img.shields.io/badge/license-MIT-blue.svg)](https://opensource.org/licenses/MIT)
[![flutter](https://img.shields.io/badge/flutter-3.0%2B-blue)](https://flutter.dev/)

A Flutter package for Apple WeatherKit REST API. Provides a clean, type-safe interface to fetch current weather, daily/hourly forecasts, next-hour precipitation, and weather alerts.

## Features

- 🌤️ **Current Weather** - Real-time weather conditions
- 📅 **Daily Forecast** - Up to 10 days of daily forecasts
- ⏰ **Hourly Forecast** - Hourly forecasts for up to 24 hours
- 🌧️ **Next-Hour Precipitation** - Minute-by-minute precipitation forecast
- ⚠️ **Weather Alerts** - Severe weather alerts and warnings
- 🔐 **JWT Auth** - Built-in JWT token generation and auto-renewal
- 🌍 **Multi-language** - Support for multiple languages and timezones

## Getting Started

### Prerequisites

1. An [Apple Developer](https://developer.apple.com/) account
2. A WeatherKit Service Key (created in [Apple Developer Portal](https://developer.apple.com/account/))
3. A Service ID with WeatherKit capability enabled
4. The private key file (`.p8`) downloaded from Apple Developer Portal

### Installation

Add this to your package's `pubspec.yaml`:

```yaml
dependencies:
  flutter_weather_kit: ^1.0.0
```

Then run:

```bash
flutter pub get
```

## Usage

### Basic Example

```dart
import 'package:flutter_weather_kit/flutter_weather_kit.dart';

void main() async {
  // Initialize the WeatherKit client
  final weatherKit = WeatherKit(
    config: WeatherKitConfig(
      teamId: 'YOUR_TEAM_ID',
      keyId: 'YOUR_KEY_ID',
      serviceId: 'com.yourcompany.weather',
      privateKeyPem: '''-----BEGIN PRIVATE KEY-----
YOUR_PRIVATE_KEY_HERE
-----END PRIVATE KEY-----''',
      language: 'en_US',
      timezone: 'America/New_York',
    ),
  );

  try {
    // Fetch weather data
    final data = await weatherKit.getWeatherData(
      latitude: 37.3318,
      longitude: -122.0312,
      dataSets: {
        DataSet.currentWeather,
        DataSet.forecastDaily,
        DataSet.forecastHourly,
        DataSet.forecastNextHour,
        DataSet.weatherAlerts,
      },
      countryCode: 'US',
    );

    // Current weather
    print('Temperature: ${data.currentWeather?.temperature}°C');
    print('Condition: ${data.currentWeather?.conditionCode}');
    print('Humidity: ${(data.currentWeather!.humidity * 100).round()}%');

    // Daily forecast
    for (final day in data.forecastDaily?.days ?? []) {
      print('${day.forecastStart}: '
          '${day.temperatureMin}° - ${day.temperatureMax}°');
    }

    // Hourly forecast
    for (final hour in data.forecastHourly?.hours ?? []) {
      print('${hour.forecastStart.hour}:00 - ${hour.temperature}°C');
    }

    // Next-hour precipitation
    print('Minutes: ${data.forecastNextHour?.minutes?.length}');

    // Alerts
    print('Alerts: ${data.weatherAlerts?.alerts?.length}');

  } catch (e) {
    print('Error: $e');
  } finally {
    weatherKit.close();
  }
}
```

### Available Data Sets

| DataSet | Description |
|---------|-------------|
| `currentWeather` | Current weather conditions |
| `forecastDaily` | Daily forecast (default 10 days) |
| `forecastHourly` | Hourly forecast (default 24 hours) |
| `forecastNextHour` | Next-hour minute-by-minute precipitation |
| `weatherAlerts` | Weather alerts for the location |

### Checking Availability

```dart
final available = await weatherKit.getAvailability(
  latitude: 37.3318,
  longitude: -122.0312,
);

print('Available data sets: $available');
```

### Getting Attribution

```dart
final attribution = await weatherKit.getAttribution();
print('Logo URL: ${attribution['logo']}');
```

## API Reference

### WeatherKitConfig

| Property | Type | Description |
|----------|------|-------------|
| `teamId` | `String` | Apple Developer Team ID (required) |
| `keyId` | `String` | WeatherKit Service Key ID (required) |
| `serviceId` | `String` | Service ID (required) |
| `privateKeyPem` | `String` | Private key in PEM format (required) |
| `baseUrl` | `String` | API base URL (default: production) |
| `language` | `String` | Language tag (default: `en_US`) |
| `timezone` | `String` | Time zone (default: `America/New_York`) |

### WeatherKit Methods

| Method | Returns | Description |
|--------|---------|-------------|
| `getWeatherData()` | `Future<WeatherData>` | Fetch weather data for a location |
| `getAvailability()` | `Future<List<DataSet>>` | Check available data sets |
| `getAttribution()` | `Future<Map<String, dynamic>>` | Get attribution info |
| `close()` | `void` | Close the HTTP client |

## Data Models

### WeatherData
- `currentWeather` - Current conditions
- `forecastDaily` - Daily forecast collection
- `forecastHourly` - Hourly forecast collection
- `forecastNextHour` - Next-hour precipitation
- `weatherAlerts` - Weather alert collection

### CurrentWeather
- `asOf` - Observation time
- `temperature` - Current temperature (°C)
- `temperatureApparent` - Feels-like temperature
- `conditionCode` - Weather condition
- `humidity` - Relative humidity (0-1)
- `pressure` - Sea-level pressure (mb)
- `windSpeed` - Wind speed (km/h)
- `windDirection` - Wind direction (degrees)
- `visibility` - Visibility (meters)
- `uvIndex` - UV index
- `cloudCover` - Cloud cover (0-1)
- ...and more

### DailyForecastData
- `forecastStart` / `forecastEnd` - Day period
- `temperatureMax` / `temperatureMin` - High/low temps
- `conditionCode` - Daytime condition
- `precipitationChance` - Rain probability (0-1)
- `sunrise` / `sunset` - Sun times
- `moonPhase` / `moonrise` / `moonset` - Moon info
- `daytimeForecast` / `overnightForecast` - Day/night details
- ...and more

### HourlyForecastData
- `forecastStart` / `forecastEnd` - Hour period
- `temperature` - Temperature (°C)
- `conditionCode` - Weather condition
- `precipitationChance` - Rain probability
- ...and more

### WeatherAlert
- `id` - Unique alert ID
- `description` - Alert title
- `severity` - Severity (extreme/severe/moderate/minor)
- `urgency` - Urgency level
- `certainty` - Certainty level
- `effectiveTime` / `expireTime` - Validity period
- ...and more

## Weather Condition Codes

The `conditionCode` field uses Apple WeatherKit condition values:

`Clear`, `MostlyClear`, `PartlyCloudy`, `MostlyCloudy`, `Cloudy`,
`Foggy`, `Haze`, `Smoke`, `Dust`, `Windy`, `Breezy`,
`Rain`, `HeavyRain`, `Showers`, `Drizzle`,
`Thunderstorms`, `SevereThunderstorm`, `ScatteredThunderstorms`,
`Snow`, `HeavySnow`, `Flurries`, `Sleet`, `Hail`,
`MixedRainAndSnow`, `MixedRainAndSleet`,
`Hot`, `Cold`, `Hurricane`, `Tornado`, ...

See [Apple WeatherCondition docs](https://developer.apple.com/documentation/weatherkit/weathercondition) for the full list.

## Pricing & Quotas

WeatherKit is included with the Apple Developer Program:

- **500,000 calls/month** included with Apple Developer membership
- Additional calls can be purchased

See [Apple WeatherKit Pricing](https://developer.apple.com/weatherkit/) for details.

## License

This package is released under the **MIT License**. See the [LICENSE](LICENSE) file for details.

---

**Disclaimer**: This is an unofficial community package. Apple and WeatherKit are trademarks of Apple Inc.
