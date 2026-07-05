import 'package:flutter/material.dart';
import 'package:flutter_weather_kit/flutter_weather_kit.dart';

void main() {
  runApp(const WeatherKitExampleApp());
}

class WeatherKitExampleApp extends StatelessWidget {
  const WeatherKitExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WeatherKit Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const WeatherHomePage(),
    );
  }
}

class WeatherHomePage extends StatefulWidget {
  const WeatherHomePage({super.key});

  @override
  State<WeatherHomePage> createState() => _WeatherHomePageState();
}

class _WeatherHomePageState extends State<WeatherHomePage> {
  WeatherData? _weatherData;
  bool _isLoading = false;
  String? _error;

  final _latitudeController = TextEditingController(text: '37.3318');
  final _longitudeController = TextEditingController(text: '-122.0312');
  final _teamIdController = TextEditingController();
  final _keyIdController = TextEditingController();
  final _serviceIdController = TextEditingController();
  final _privateKeyController = TextEditingController();

  Future<void> _fetchWeather() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    final weatherKit = WeatherKit(
      config: WeatherKitConfig(
        teamId: _teamIdController.text,
        keyId: _keyIdController.text,
        serviceId: _serviceIdController.text,
        privateKeyPem: _privateKeyController.text,
        language: 'en_US',
        timezone: 'America/New_York',
      ),
    );

    try {
      final lat = double.tryParse(_latitudeController.text) ?? 0;
      final lon = double.tryParse(_longitudeController.text) ?? 0;

      final data = await weatherKit.getWeatherData(
        latitude: lat,
        longitude: lon,
        dataSets: {
          DataSet.currentWeather,
          DataSet.forecastDaily,
          DataSet.forecastHourly,
          DataSet.forecastNextHour,
          DataSet.weatherAlerts,
        },
        countryCode: 'US',
      );

      setState(() {
        _weatherData = data;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
      });
    } finally {
      weatherKit.close();
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('WeatherKit Demo')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildConfigSection(),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _isLoading ? null : _fetchWeather,
              child: Text(_isLoading ? 'Loading...' : 'Fetch Weather'),
            ),
            const SizedBox(height: 16),
            if (_error != null)
              Card(
                color: Colors.red.shade50,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text('Error: $_error',
                      style: TextStyle(color: Colors.red.shade900)),
                ),
              ),
            if (_weatherData != null) _buildWeatherDisplay(),
          ],
        ),
      ),
    );
  }

  Widget _buildConfigSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Configuration',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            TextField(
              controller: _teamIdController,
              decoration: const InputDecoration(labelText: 'Team ID'),
            ),
            TextField(
              controller: _keyIdController,
              decoration: const InputDecoration(labelText: 'Key ID'),
            ),
            TextField(
              controller: _serviceIdController,
              decoration: const InputDecoration(labelText: 'Service ID'),
            ),
            TextField(
              controller: _privateKeyController,
              decoration: const InputDecoration(labelText: 'Private Key (PEM)'),
              maxLines: 3,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _latitudeController,
                    decoration: const InputDecoration(labelText: 'Latitude'),
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    controller: _longitudeController,
                    decoration: const InputDecoration(labelText: 'Longitude'),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWeatherDisplay() {
    final current = _weatherData!.currentWeather;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Current Weather',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            if (current != null) ...[
              Text('Temperature: ${current.temperature}°C'),
              const SizedBox(height: 4),
              Text('Feels Like: ${current.temperatureApparent}°C'),
              const SizedBox(height: 4),
              Text('Condition: ${current.conditionCode}'),
              const SizedBox(height: 4),
              Text('Humidity: ${(current.humidity * 100).round()}%'),
              const SizedBox(height: 4),
              Text('Wind: ${current.windSpeed} km/h'),
              const SizedBox(height: 4),
              Text('UV Index: ${current.uvIndex}'),
            ],
            const Divider(height: 24),
            Text(
                'Daily Forecast: ${_weatherData?.forecastDaily?.days.length ?? 0} days'),
            const SizedBox(height: 4),
            Text(
                'Hourly Forecast: ${_weatherData?.forecastHourly?.hours?.length ?? 0} hours'),
            const SizedBox(height: 4),
            Text(
                'Next Hour Minutes: ${_weatherData?.forecastNextHour?.minutes?.length ?? 0}'),
            const SizedBox(height: 4),
            Text(
                'Alerts: ${_weatherData?.weatherAlerts?.alerts?.length ?? 0}'),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _latitudeController.dispose();
    _longitudeController.dispose();
    _teamIdController.dispose();
    _keyIdController.dispose();
    _serviceIdController.dispose();
    _privateKeyController.dispose();
    super.dispose();
  }
}
