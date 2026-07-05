# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2026-07-05

### Added

- Initial release of flutter_weather_kit
- Support for Apple WeatherKit REST API
- `WeatherKit` client class with JWT token management
- Current weather data (`DataSet.currentWeather`)
- Daily forecast (`DataSet.forecastDaily`) - up to 10 days
- Hourly forecast (`DataSet.forecastHourly`) - up to 24 hours
- Next-hour precipitation forecast (`DataSet.forecastNextHour`) - minute-by-minute
- Weather alerts (`DataSet.weatherAlerts`)
- Availability check API
- Attribution API
- Full type-safe model classes for all data sets
- Auto-renewing JWT token caching
