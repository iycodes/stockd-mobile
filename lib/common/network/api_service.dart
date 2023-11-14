import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:stockd/common/models/api_response.dart';
import 'package:stockd/common/network/Http_Response_Handler.dart';

class ApiService {
// Global options
  final options = CacheOptions(
    // A default store is required for interceptor.
    store: MemCacheStore(),

    // All subsequent fields are optional.

    // Default.
    policy: CachePolicy.request,
    // Returns a cached response on error but for statuses 401 & 403.
    // Also allows to return a cached response on network errors (e.g. offline usage).
    // Defaults to [null].
    hitCacheOnErrorExcept: [401, 403],
    // Overrides any HTTP directive to delete entry past this duration.
    // Useful only when origin server has no cache config or custom behaviour is desired.
    // Defaults to [null].
    maxStale: const Duration(days: 7),
    // Default. Allows 3 cache sets and ease cleanup.
    priority: CachePriority.normal,
    // Default. Body and headers encryption with your own algorithm.
    cipher: null,
    // Default. Key builder to retrieve requests.
    keyBuilder: CacheOptions.defaultCacheKeyBuilder,
    // Default. Allows to cache POST requests.
    // Overriding [keyBuilder] is strongly recommended when [true].
    allowPostMethod: false,
  );

  final Dio _dio = Dio(
    BaseOptions(
      // baseUrl: baseUrl,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        // 'Authorization': 'Bearer ${APIVariables.token}',
      },
    ),
  );

  final String _url = Uri.encodeFull("http://localhost:3000");

  Future<ApiResponse> fetchSingle(String path) async {
    try {
      Response res = await _dio.get("$_url/$path");
      return _handleResponseCode(res);
    } catch (err, stacktrace) {
      printErr(err, stacktrace);
      return ApiResponse.error(message: err.toString());
    }
  }

  Future<ApiResponse> fetchMultiple(
    String path,
  ) async {
    try {
      Response res = await _dio.get("$_url/$path");
      return _handleResponseCode(res);
    } catch (err, stacktrace) {
      printErr(err, stacktrace);
      return ApiResponse.error(message: err.toString());
    }
  }

  Future<ApiResponse> postSingle(String path, Map<String, dynamic> data) async {
    try {
      // var serializedJson = Item().toJson();
      Response res = await _dio.post("$_url/$path", data: data);
      return _handleResponseCode(res);
    } catch (err, stacktrace) {
      printErr(err, stacktrace);
      return ApiResponse.error(message: err.toString());
    }
  }

  Future<ApiResponse> patch(String path, List<String> data) async {
    try {
      print(data);
      Response res = await _dio.patch("$_url/$path", data: jsonEncode(data));
      return _handleResponseCode(res);
    } catch (err, stacktrace) {
      printErr(err, stacktrace);
      return ApiResponse.error(message: err.toString());
    }
  }

  dynamic _handleResponseCode(Response response) {
    switch (response.statusCode) {
      case 200:
        return ApiResponse.success(data: response.data);
      case 400:
        throw HttpErrorBadRequest(context: response.data);
      case 401:
        throw HttpErrorUnauthorized(context: response.data);
      case 403:
        throw HttpErrorForbidden(context: response.data);
      case 404:
        throw HttpErrorUnauthorized(context: response.data);
      case 500:
        throw HttpErrorServerError(
          context: response.data,
        );
      default:
        throw HttpErrorCustomError(
            context: response.data, statuscode: response.statusCode);
    }
  }
}

void printErr(e, s) => print("error:$e ; stacktrace: $s");
String not200(s, sm) => ("statuscode:$s, statuscode message:$sm");
