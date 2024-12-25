import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:tasky_apis/core/auth_helper.dart';
import 'package:tasky_apis/core/constants/network.dart';

class DioHelper {
  static Dio? _dio;

  static Future<dynamic> refreshToken(String refreshToken) async {
    final response = await DioHelper.getData(
      endPoint: endPoints['refresh-token']!,
      queryParams: {"token": refreshToken},
    );
    return response.data;
  }

  static void init() {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseAPIURL,
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 5),
        receiveDataWhenStatusError: true,
      ),
    );

    _dio!.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      request: true,
      error: true,
    ));

    // Adding an interceptor to check for 401 Unauthorized
    _dio!.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        // If there's a valid token, add it to the request header
        final token = AuthHelper.authorization;
        if (token != null) {
          options.headers["Authorization"] = token;
        }
        return handler.next(options);
      },
      onResponse: (response, handler) {
        return handler
            .next(response); // no change needed for successful responses
      },
      onError: (DioException error, handler) async {
        if (error.response?.statusCode == 401) {
          final newTokens =
              await DioHelper.refreshToken(AuthHelper.refreshToken);
          if (newTokens != null) {
            AuthHelper.authenticate(newTokens['access_token']);

            // Retry the request with the new token
            final options = error.requestOptions;
            options.headers["Authorization"] = AuthHelper.authorization;
            final cloneReq = await _dio!.request(
              options.path,
              options: Options(
                method: options.method,
                headers: options.headers,
              ),
              data: options.data,
              queryParameters: options.queryParameters,
            );
            return handler.resolve(cloneReq);
          }
        }
        return handler.next(error);
      },
    ));
  }

  static Dio? get instance {
    return _dio;
  }

  static Future<Response> getData(
      {required String endPoint, Map<String, dynamic>? queryParams}) async {
    final response = await _dio!.get(endPoint, queryParameters: queryParams);
    return response;
  }

  static Future<Response> postData(
      {required String endPoint, dynamic body}) async {
    final response = await _dio!.post(endPoint, data: body);
    return response;
  }

  static Future<Response> deleteData({
    required String endPoint,
  }) async {
    final response = await _dio!.delete(endPoint);
    return response;
  }

  static Future<Response> putData(
      {required String endPoint, dynamic body}) async {
    final response = await _dio!.put(endPoint, data: body);
    return response;
  }
}
