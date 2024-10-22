import 'package:app_piloto/core/http/http.dart';

abstract class HttpClientServices {
  Future<String?> getDeviceIp();

  Future<AppPilotoResponse> request({
    required String endpoint,
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    bool useBytes = false,
  });
}
