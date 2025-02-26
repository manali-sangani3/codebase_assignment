import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_project/app/db/app_preferences.dart';
import 'package:get_it/get_it.dart';
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

  /// GET base API with token.
  Future<Response> getBaseAPIWithToken(
      {required String url, Map<String, dynamic>? queryParams}) async {
    try {
      // Create RequestOptions and set the headers, including the API token
      Options requestOptions = Options(
        headers: {
          "Authorization": "Bearer ${await _getAuthToken()}",
          "userAgent": "mobile",
        },
      );
      return await mDio.get(
        url,
        queryParameters: queryParams,
        options: requestOptions,
      );
    } on DioException catch (ex) {
      // OverlayLoadingProgress.stop();
      if (ex.type == DioExceptionType.badResponse) {
        // Parse the response data to get the message string
        String message = ex.response?.data != null
            ? ex.response?.data['message'] ?? 'Unknown error occurred'
            : 'Unknown error occurred';
        // printf(" Message-----------${message}");

        return Response(
            data: message,
            statusMessage: message,
            statusCode: ex.response?.statusCode ?? 500,
            requestOptions: RequestOptions());
      } else if (ex.type == DioExceptionType.connectionError) {
        // Parse the response data to get the message string
        String message = 'No internet connection !';
        // printf(" Message-----------${message}");

        return Response(
            data: message,
            statusMessage: message,
            statusCode: ex.response?.statusCode ?? 500,
            requestOptions: RequestOptions());
      } else if (ex.type == DioExceptionType.unknown) {
        // Parse the response data to get the message string
        String message = 'No internet connection !';
        // printf(" Message-----------${message}");

        return Response(
            data: message,
            statusMessage: message,
            statusCode: ex.response?.statusCode ?? 500,
            requestOptions: RequestOptions());
      } else if (ex.type == DioExceptionType.unknown) {
        // Parse the response data to get the message string
        String message = 'No internet connection !';
        // printf(" Message-----------${message}");

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

  /// PATCH base API with Token.
  Future<Response> patchBaseAPIWithToken(
      {required String url,
      dynamic data,
      Map<String, dynamic>? queryParameters,
      required String id}) async {
    try {
      // Create RequestOptions and set the headers, including the API token
      Options requestOptions = Options(
        headers: {
          "Authorization": "Bearer ${await _getAuthToken()}",
          "userAgent": "mobile",
        },
      );
      return await mDio.patch(
        url + id,
        data: data,
        options: requestOptions,
      );
    } on DioException catch (ex) {
      // OverlayLoadingProgress.stop();
      if (ex.type == DioExceptionType.badResponse) {
        // Parse the response data to get the message string
        String message =
            ex.response?.data['message'] ?? 'Unknown error occurred';
        // printf(" Message-----------${message}");

        return Response(
            data: message,
            statusMessage: message,
            statusCode: ex.response?.statusCode ?? 500,
            requestOptions: RequestOptions());
      } else if (ex.type == DioExceptionType.connectionError) {
        // Parse the response data to get the message string
        String message = 'No internet connection !';
        // printf(" Message-----------${message}");

        return Response(
            data: message,
            statusMessage: message,
            statusCode: ex.response?.statusCode ?? 500,
            requestOptions: RequestOptions());
      } else if (ex.type == DioExceptionType.unknown) {
        // Parse the response data to get the message string
        String message = 'No internet connection !';
        // printf(" Message-----------${message}");

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

  /// POST base API with Token.
  Future<Response> postBaseAPIWithToken(
      {required String url,
      dynamic data,
      Map<String, dynamic>? queryParameters,
      bool? isExceptionNeeded = false}) async {
    try {
      // Create RequestOptions and set the headers, including the API token
      Options requestOptions = Options(
        headers: {
          "Authorization": "Bearer ${await getAuthToken()}",
          "userAgent": "mobile",
        },
      );
      return await mDio.post(
        url,
        data: data,
        options: requestOptions,
      );
    } on DioException catch (ex) {
      // OverlayLoadingProgress.stop();
      if (ex.type == DioExceptionType.badResponse) {
        // Parse the response data to get the message string
        String message =
            ex.response?.data['message'] ?? 'Unknown error occurred';
        return Response(
            data: isExceptionNeeded ?? false ? ex.response?.data : message,
            statusMessage: message,
            statusCode: ex.response?.statusCode ?? 500,
            requestOptions: RequestOptions());
      } else if (ex.type == DioExceptionType.connectionTimeout) {
        return Response(
            data: AppStrings.connectionTimeoutMessage,
            statusMessage: AppStrings.connectionTimeoutMessage,
            statusCode: 500,
            requestOptions: RequestOptions());
      } else if (ex.type == DioExceptionType.connectionError) {
        // Parse the response data to get the message string
        String message = 'No internet connection !';
        return Response(
            data: message,
            statusMessage: message,
            statusCode: ex.response?.statusCode ?? 500,
            requestOptions: RequestOptions());
      } else if (ex.type == DioExceptionType.unknown) {
        // Parse the response data to get the message string
        String message = 'No internet connection !';
        // printf(" Message-----------${message}");

        return Response(
            data: message,
            statusMessage: message,
            statusCode: ex.response?.statusCode ?? 500,
            requestOptions: RequestOptions());
      } else {
        return Response(
            data: ex.message,
            statusMessage: ex.message,
            statusCode: 500,
            requestOptions: RequestOptions());
      }
    }
  }

  /// PUT base API with Token.
  Future<Response> putBaseAPIWithToken(
      {required String url,
      dynamic data,
      Map<String, dynamic>? queryParameters,
      required String id}) async {
    try {
      // Create RequestOptions and set the headers, including the API token
      Options requestOptions = Options(
        headers: {
          "Authorization": "Bearer ${await _getAuthToken()}",
          "userAgent": "mobile",
        },
      );
      return await mDio.put(
        url + id,
        data: data,
        options: requestOptions,
      );
    } on DioException catch (ex) {
      // OverlayLoadingProgress.stop();
      if (ex.type == DioExceptionType.badResponse) {
        // Parse the response data to get the message string
        String message =
            ex.response?.data['message'] ?? 'Unknown error occurred';
        // printf(" Message-----------${message}");

        return Response(
            data: message,
            statusMessage: message,
            statusCode: ex.response?.statusCode ?? 500,
            requestOptions: RequestOptions());
      } else if (ex.type == DioExceptionType.connectionError) {
        // Parse the response data to get the message string
        String message = 'No internet connection !';
        // printf(" Message-----------${message}");

        return Response(
            data: message,
            statusMessage: message,
            statusCode: ex.response?.statusCode ?? 500,
            requestOptions: RequestOptions());
      } else if (ex.type == DioExceptionType.unknown) {
        // Parse the response data to get the message string
        String message = 'No internet connection !';
        // printf(" Message-----------${message}");

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

  /// PUT base API with Token.
  Future<Response> putBaseAPI({
    required String url,
    dynamic data,
  }) async {
    try {
      // Create RequestOptions and set the headers, including the API token
      Options requestOptions = Options(
        headers: {
          "Authorization": "Bearer ${await _getAuthToken()}",
          "userAgent": "mobile",
        },
      );
      return await mDio.put(
        url,
        data: data,
        options: requestOptions,
      );
    } on DioException catch (ex) {
      // OverlayLoadingProgress.stop();
      if (ex.type == DioExceptionType.badResponse) {
        // Parse the response data to get the message string
        String message =
            ex.response?.data['message'] ?? 'Unknown error occurred';
        // printf(" Message-----------${message}");

        return Response(
            data: message,
            statusMessage: message,
            statusCode: ex.response?.statusCode ?? 500,
            requestOptions: RequestOptions());
      } else if (ex.type == DioExceptionType.connectionError) {
        // Parse the response data to get the message string
        String message = 'No internet connection !';
        // printf(" Message-----------${message}");

        return Response(
            data: message,
            statusMessage: message,
            statusCode: ex.response?.statusCode ?? 500,
            requestOptions: RequestOptions());
      } else if (ex.type == DioExceptionType.unknown) {
        // Parse the response data to get the message string
        String message = 'No internet connection !';
        // printf(" Message-----------${message}");

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

  /// DELETE base API with token.
  Future<Response> deleteBaseAPIWithToken(
      {required String url,
      Map<String, dynamic>? queryParams,
      required String id}) async {
    try {
      // Create RequestOptions and set the headers, including the API token
      Options requestOptions = Options(
        headers: {
          "Authorization": "Bearer ${await _getAuthToken()}",
          "userAgent": "mobile",
        },
      );
      return await mDio.delete(
        url + id,
        queryParameters: queryParams,
        options: requestOptions,
      );
    } on DioException catch (ex) {
      // OverlayLoadingProgress.stop();
      if (ex.type == DioExceptionType.badResponse) {
        // Parse the response data to get the message string
        String message =
            ex.response?.data['message'] ?? 'Unknown error occurred';
        // printf(" Message-----------${message}");

        return Response(
            data: message,
            statusMessage: message,
            statusCode: ex.response?.statusCode ?? 500,
            requestOptions: RequestOptions());
      } else if (ex.type == DioExceptionType.connectionError) {
        // Parse the response data to get the message string
        String message = 'No internet connection !';
        // printf(" Message-----------${message}");

        return Response(
            data: message,
            statusMessage: message,
            statusCode: ex.response?.statusCode ?? 500,
            requestOptions: RequestOptions());
      } else if (ex.type == DioExceptionType.unknown) {
        // Parse the response data to get the message string
        String message = 'No internet connection !';
        // printf(" Message-----------${message}");

        return Response(
            data: message,
            statusMessage: message,
            statusCode: ex.response?.statusCode ?? 500,
            requestOptions: RequestOptions());
      } else if (ex.type == DioExceptionType.unknown) {
        // Parse the response data to get the message string
        String message = 'No internet connection !';
        // printf(" Message-----------${message}");

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

  /// Get authentication token.
  Future<String> _getAuthToken() async {
    String token = await GetIt.I<AppPreferences>().getApiToken();
    if (kDebugMode) {
      print("Auth token: $token");
    }
    return token;
  }

  Future<String> getAuthToken() async {
    String token = await GetIt.I<AppPreferences>().getApiToken();
    if (kDebugMode) {
      print("Auth token: $token");
    }
    return token;
  }
}
