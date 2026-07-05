import 'package:dio/dio.dart';

import 'models/enums.dart';
import 'models/weather_data.dart';
import 'token.dart';

/// Configuration for the WeatherKit API client.
class WeatherKitConfig {
  /// Apple Developer Team ID.
  final String teamId;

  /// WeatherKit Service Key ID.
  final String keyId;

  /// WeatherKit Service ID.
  final String serviceId;

  /// Private key in PEM format.
  final String privateKeyPem;

  /// API base URL. Defaults to Apple's production endpoint.
  final String baseUrl;

  /// Language tag for localized data (e.g., 'en-US', 'zh-Hans').
  final String language;

  /// Time zone for the weather data (e.g., 'America/New_York').
  final String timezone;

  const WeatherKitConfig({
    required this.teamId,
    required this.keyId,
    required this.serviceId,
    required this.privateKeyPem,
    this.baseUrl = 'https://weatherkit.apple.com/api/v1',
    this.language = 'en_US',
    this.timezone = 'America/New_York',
  });
}

/// The main WeatherKit API client.
///
/// Usage:
/// ```dart
/// final weatherKit = WeatherKit(
///   config: WeatherKitConfig(
///     teamId: 'YOUR_TEAM_ID',
///     keyId: 'YOUR_KEY_ID',
///     serviceId: 'com.yourcompany.weather',
///     privateKeyPem: '-----BEGIN PRIVATE KEY-----\n...\n-----END PRIVATE KEY-----',
///   ),
/// );
///
/// final data = await weatherKit.getWeatherData(
///   latitude: 37.3318,
///   longitude: -122.0312,
///   dataSets: {DataSet.currentWeather, DataSet.forecastDaily},
/// );
/// ```
class WeatherKit {
  final WeatherKitConfig config;
  final Dio _dio;

  String? _cachedToken;
  DateTime? _tokenExpiry;

  WeatherKit({required this.config, Dio? dio})
      : _dio = dio ?? Dio(BaseOptions(
          baseUrl: config.baseUrl,
          headers: {
            'Accept': 'application/json',
          },
        ));

  /// Get a valid JWT token, caching it until near expiry.
  Future<String> _getToken() async {
    if (_cachedToken != null &&
        _tokenExpiry != null &&
        DateTime.now().isBefore(_tokenExpiry!)) {
      return _cachedToken!;
    }

    _cachedToken = WeatherKitSign.sign(
      teamId: config.teamId,
      keyId: config.keyId,
      serviceId: config.serviceId,
      privateKeyPem: config.privateKeyPem,
    );

    // Renew 5 minutes before actual expiry
    _tokenExpiry = DateTime.now().add(const Duration(minutes: 55));

    return _cachedToken!;
  }

  /// Get weather data for the given location.
  ///
  /// [latitude] and [longitude] specify the location.
  /// [dataSets] specifies which data sets to include.
  /// [countryCode] is the ISO 3166 country code (required for weather alerts).
  ///
  /// Returns a [WeatherData] object with the requested data sets.
  Future<WeatherData> getWeatherData({
    required double latitude,
    required double longitude,
    Set<DataSet> dataSets = const {
      DataSet.currentWeather,
      DataSet.forecastDaily,
      DataSet.forecastHourly,
      DataSet.forecastNextHour,
      DataSet.weatherAlerts,
    },
    String? countryCode,
    String? timezone,
    String? language,
  }) async {
    final token = await _getToken();

    final dataSetStr = dataSets.map((d) => d.value).join(',');

    final queryParams = <String, String>{
      'dataSets': dataSetStr,
      if (timezone != null) 'timezone': timezone,
      if (language != null) 'language': language,
      if (countryCode != null) 'countryCode': countryCode,
    };

    final response = await _dio.get(
      '/weather/$latitude/$longitude',
      queryParameters: queryParams,
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
    );

    if (response.statusCode == 200) {
      return WeatherData.fromMap(response.data as Map<String, dynamic>);
    }

    throw DioException(
      requestOptions: response.requestOptions,
      response: response,
      error: 'Failed to fetch weather data: ${response.statusCode}',
    );
  }

  /// Get the availability of data sets for a location.
  ///
  /// Returns a list of available [DataSet] values that are available for the location.
  Future<List<DataSet>> getAvailability({
    required double latitude,
    required double longitude,
    String? countryCode,
  }) async {
    final token = await _getToken();

    final queryParams = <String, String>{
      if (countryCode != null) 'countryCode': countryCode,
    };

    final response = await _dio.get(
      '/availability/$latitude/$longitude',
      queryParameters: queryParams,
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
    );

    if (response.statusCode == 200) {
      final available = List<String>.from(response.data['available'] as List);
      return available
          .map((name) => DataSet.values.byName(name))
          .toList();
    }

    throw DioException(
      requestOptions: response.requestOptions,
      response: response,
      error: 'Failed to fetch availability: ${response.statusCode}',
    );
  }

  /// Get attribution information (branded Apple Weather.
  ///
  /// Returns a URL to attribution data including the legal attribution text and logo URL.
  Future<Map<String, dynamic>> getAttribution() async {
    final token = await _getToken();

    final response = await _dio.get(
      '/attribution',
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
    );

    if (response.statusCode == 200) {
      return response.data as Map<String, dynamic>;
    }

    throw DioException(
      requestOptions: response.requestOptions,
      response: response,
      error: 'Failed to fetch attribution: ${response.statusCode}',
    );
  }

  /// Close the HTTP client.
  void close() {
    _dio.close();
  }
}
