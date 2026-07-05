import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

/// Utility class for signing WeatherKit JWT tokens.
///
/// To use WeatherKit REST API, you need to:
/// 1. Have an Apple Developer account
/// 2. Create a WeatherKit Service key in the Apple Developer Portal
/// 3. Create a Service ID with WeatherKit capability
/// 4. Download the private key (.p8 file)
class WeatherKitSign {
  /// Generate a WeatherKit JWT token.
  ///
  /// [teamId] is your Apple Developer Team ID.
  /// [keyId] is the ID of the WeatherKit Service key.
  /// [serviceId] is the Service ID (e.g., com.example.weather).
  /// [privateKeyPem] is the content of the .p8 private key file.
  ///
  /// Returns a signed JWT token valid for 1 hour.
  static String sign({
    required String teamId,
    required String keyId,
    required String serviceId,
    required String privateKeyPem,
    Duration expiresIn = const Duration(hours: 1),
  }) {
    final jwt = JWT(
      {
        'sub': serviceId,
      },
      issuer: teamId,
      audience: Audience.one('https://appleid.apple.com'),
      jwtId: '${DateTime.now().millisecondsSinceEpoch}',
      header: {
        'kid': keyId,
        'id': '$teamId.$serviceId',
        'alg': 'ES256',
      },
    );

    final key = ECPrivateKey(privateKeyPem);

    return jwt.sign(key,
        algorithm: JWTAlgorithm.ES256, expiresIn: expiresIn);
  }
}
