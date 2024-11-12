import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';

import 'api_endpoints.dart';
import 'api_excepion.dart';

// ignore: constant_identifier_names
enum Method { POST, GET, PUT, DELETE, PATCH }

class APIHelper {
  Dio? _dio;

  static header() => {
        "Accept": "application/json",
        "Content-Type": "application/json",
      };

  Future<void> init() async {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiEndpoints.baseURL,
        headers: header(),
        //  connectTimeout: Duration(seconds: 5), // 5 seconds
        // receiveTimeout: Duration(seconds: 5),
      ),
    );
    initInterceptors();
  }

  void initInterceptors() {
    _dio!.interceptors.add(
      InterceptorsWrapper(
        onRequest: (requestOptions, handler) {
          return handler.next(requestOptions);
        },
        onResponse: (response, handler) {
          return handler.next(response);
        },
        onError: (err, handler) {
          return handler.next(err);
        },
      ),
    );
  }

  Future<Response> request({
    required String url,
    required Method method,
    params,
    String? loginToken,
  }) async {
    try {
      final response = await _performHttpRequest({
        'url': url,
        'method': method,
        'params': params,
        'Authorization': loginToken,
      });

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response;
      } else if (response.statusCode == 401) {
        throw APIException(
          message: 'Unauthorized',
          statusCode: response.statusCode!,
        );
      } else if (response.statusCode == 500) {
        throw APIException(
          message: 'Server Error',
          statusCode: response.statusCode!,
        );
      } else if (response.statusCode == 422) {
        throw APIException(
          message: 'Unprocessable content',
          statusCode: response.statusCode!,
        );
      } else {
        throw APIException(
          message: 'Something went wrong',
          statusCode: response.statusCode!,
        );
      }
    } on SocketException catch (_) {
      throw const APIException(
        message: 'No Internet Connection',
        statusCode: 500,
      );
    } on FormatException catch (_) {
      throw const APIException(
        message: 'Bad response format',
        statusCode: 500,
      );
    } on DioException catch (e) {
      throw APIException(
        message: '${e.toString()} Something went wrong',
        statusCode: 500,
      );
    } on APIException {
      rethrow;
    } catch (e) {
      throw const APIException(
        message: 'Something went wrong',
        statusCode: 500,
      );
    }
  }

  Future<Response> _performHttpRequest(Map<String, dynamic> data) async {
    log('Request data: ${data.toString()}');

    Dio dio = Dio(
      BaseOptions(
        baseUrl: ApiEndpoints.baseURL,
        headers: header(),
      ),
    );

    final url = data['url'];
    final method = data['method'];
    final params = data['params'] ?? {}; // Ensure params are not null
    final loginToken = data['Authorization'];

    Options options;
    if (loginToken != null && loginToken.isNotEmpty) {
      options = Options(headers: {"Authorization": "$loginToken"});
    } else {
      options = Options(); // No Authorization header if it's null or empty
    }

    try {
      Response response;

      switch (method) {
        case Method.POST:
          response = await dio.post(url, data: params, options: options);
          break;
        case Method.DELETE:
          response = await dio.delete(url, options: options);
          break;
        case Method.PATCH:
          response = await dio.patch(url);
          break;
        default:
          response = await dio.get(
            url,
            queryParameters: params,
            options: options,
          );
          break;
      }

      return response;
    } on DioException catch (e) {
      throw APIException(
        message: e.response?.data.toString() ?? "",
        statusCode: e.response?.statusCode ?? 500,
      );
    }
  }
}
