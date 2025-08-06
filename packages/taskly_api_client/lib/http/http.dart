import 'package:dio/dio.dart' show Dio, BaseOptions;

enum HttpMethod { get }

class HttpResponse<T> {
  int? statusCode;
  T? body;

  HttpResponse({this.statusCode, this.body});
}

abstract class HttpClientInterface {
  Future<HttpResponse<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
  });
}

class HttpClientImpl implements HttpClientInterface {
  late final Dio _httpClient;

  HttpClientImpl({required String baseUrl}) {
    _httpClient = Dio(BaseOptions(baseUrl: baseUrl));
  }

  @override
  Future<HttpResponse<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    final response = await _httpClient.get(
      path,
      queryParameters: queryParameters,
    );

    return HttpResponse<T>(
      statusCode: response.statusCode,
      body: response.data as T?,
    );
  }
}
