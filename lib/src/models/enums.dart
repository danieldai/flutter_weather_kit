/// The direction of change of the sea-level air pressure.
///
/// https://developer.apple.com/documentation/weatherkit/pressuretrend
enum PressureTrend {
  /// The pressure is rising.
  rising,

  /// The pressure is falling.
  falling,

  /// The pressure is not changing.
  steady,
}

/// The type of precipitation.
///
/// https://developer.apple.com/documentation/weatherkit/precipitationtype
enum PrecipitationType {
  /// No precipitation.
  clear,

  /// Rain.
  rain,

  /// Snow.
  snow,

  /// A mix of rain and snow.
  mixed,

  /// Sleet or freezing rain.
  sleet,

  /// Hail.
  hail,
}

/// The type of weather data set.
enum DataSet {
  /// The current weather conditions for the requested location.
  currentWeather,

  /// The daily forecast for the requested location.
  forecastDaily,

  /// The hourly forecast for the requested location.
  forecastHourly,

  /// The next-hour precipitation forecast for the requested location.
  forecastNextHour,

  /// The weather alerts for the requested location.
  weatherAlerts,
}

extension DataSetExtension on DataSet {
  String get value {
    switch (this) {
      case DataSet.currentWeather:
        return 'currentWeather';
      case DataSet.forecastDaily:
        return 'forecastDaily';
      case DataSet.forecastHourly:
        return 'forecastHourly';
      case DataSet.forecastNextHour:
        return 'forecastNextHour';
      case DataSet.weatherAlerts:
        return 'weatherAlerts';
    }
  }
}
