import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../app_strings.dart';
import '../flavor_config.dart';

class DioProvider {
  late Dio mDio;

  void initialise() {
    mDio = Dio(
      BaseOptions(
          baseUrl: FlavorConfig.instance.values.baseUrl,
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 30),
          receiveDataWhenStatusError: true,
          headers: {'Content-Type': 'application/json'}),
    );
    mDio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        request: true));
  }

  /// Get base API.
  Future<Response> getBaseAPI(
      {required String url, Map<String, dynamic>? queryParams}) async {
    try {
      return await mDio.get(url, queryParameters: queryParams);
    } on DioException catch (ex) {
      if (ex.type == DioExceptionType.unknown) {
        // Parse the response data to get the message string
        String message = 'No internet connection !';

        return Response(
            data: message,
            statusMessage: message,
            statusCode: ex.response?.statusCode ?? 500,
            requestOptions: RequestOptions());
      } else if (ex.type == DioExceptionType.connectionTimeout) {
        return Response(
            data: AppStrings.connectionTimeoutMessage,
            statusMessage: AppStrings.connectionTimeoutMessage,
            statusCode: 500,
            requestOptions: RequestOptions());
      }
      return Response(
          data: ex.message,
          statusMessage: ex.message,
          statusCode: 500,
          requestOptions: RequestOptions());
    }
  }

  /// Post base API.
  Future<Response> postBaseAPI({required String url, dynamic data}) async {
    try {
      return await mDio.post(url, data: data);
    } on DioException catch (ex) {
      if (ex.type == DioExceptionType.connectionTimeout) {
        return Response(
            data: AppStrings.connectionTimeoutMessage,
            statusMessage: AppStrings.connectionTimeoutMessage,
            statusCode: 500,
            requestOptions: RequestOptions());
      }
      return Response(
          data: ex.message,
          statusMessage: ex.message,
          statusCode: 500,
          requestOptions: RequestOptions());
    }
  }
}
