import 'package:app_piloto/core/http/http.dart';

///
/// A classe abstrata [HttpClientServices] define um conjunto de métodos que devem ser implementados pelas
/// classes que a implemetarem. Esses métodos são responsáveis por realizar requisições HTTP para uma determinada API,
/// utilizando diferentes métodos HTTP (GET, POST, PUT, DELETE, etc.), e retornar uma resposta em formato JSON.
/// Além disso, a classe também define um método para obter o endereço IP do dispositivo que está realizando
/// a requisição. Essa classe é utilizada como base para a implementação de serviços de comunicação
/// com APIs em diferentes plataformas.
///
abstract class HttpClientServices {
  ///
  /// Método para obter o endereço IP do dispositivo que está realizando a requisição.
  ///
  Future<String?> getDeviceIp();

  ///
  /// Método responsável por realizar requisições HTTP para uma determinada API,
  /// utilizando diferentes métodos HTTP (GET, POST, PUT, DELETE, etc.), e retornar uma resposta em formato JSON
  /// dentro o [GClientResponse] no parametro data.
  ///
  Future<AppPilotoResponse> request({
    // requiredAppPilotoApiName apiName,
    required String endpoint,
    // required AHttpMethod method,
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    bool useBytes = false,
  });
}
