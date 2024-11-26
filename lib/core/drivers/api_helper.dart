import 'dart:convert';

import 'package:dio/dio.dart';

class ApiHelper {
  final Dio _dio = Dio();
  final username = "ck_b9e4e281dc7aa5595062207a479090a390304335";
  final password = "cs_95b5c4724a48737ed72daf8314dae9cbc83842ae";

  ApiHelper() {
    final basicAuth = 'Basic ${base64Encode(utf8.encode('$username:$password'))}';
    _dio.options.baseUrl = 'https://cloud.boostorder.com/bo-mart/api/v1/wp-json/wc/v1/bo/products';
    _dio.options.connectTimeout = const Duration(milliseconds: 5000); 
    _dio.options.receiveTimeout = const Duration(milliseconds: 3000); 
    _dio.options.headers['Authorization'] = basicAuth; 
  }

  Future<Response> getRequest(String endpoint, {Map<String, dynamic>? queryParameters}) async {
    try {
      print(queryParameters);
      final response = await _dio.get(endpoint, queryParameters: queryParameters);
      print(response);
      return response;
    } catch (e) {
      return _handleError(e);
    }
  }

  Future<Response> postRequest(String endpoint, {Map<String, dynamic>? data}) async {
    try {
      final response = await _dio.post(endpoint, data: data);
      return response;
    } catch (e) {
      return _handleError(e);
    }
  }

  Future<Response> putRequest(String endpoint, {Map<String, dynamic>? data}) async {
    try {
      final response = await _dio.put(endpoint, data: data);
      return response;
    } catch (e) {
      return _handleError(e);
    }
  }

  Future<Response> deleteRequest(String endpoint, {Map<String, dynamic>? data}) async {
    try {
      final response = await _dio.delete(endpoint, data: data);
      return response;
    } catch (e) {
      return _handleError(e);
    }
  }

  Response _handleError(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
          return Response(requestOptions: error.requestOptions, statusCode: 408, statusMessage: "Connection Timeout");
        case DioExceptionType.sendTimeout:
          return Response(requestOptions: error.requestOptions, statusCode: 408, statusMessage: "Send Timeout");
        case DioExceptionType.receiveTimeout:
          return Response(requestOptions: error.requestOptions, statusCode: 408, statusMessage: "Receive Timeout");
        case DioExceptionType.badResponse:
          return error.response!;
        case DioExceptionType.cancel:
          return Response(requestOptions: error.requestOptions, statusCode: 499, statusMessage: "Request Cancelled");
        case DioExceptionType.badCertificate:
          return Response(
            requestOptions: error.requestOptions,
            statusCode: 495,
            statusMessage: "SSL Certificate Error",
          );
        case DioExceptionType.connectionError:
          return Response(
            requestOptions: error.requestOptions,
            statusCode: 495,
            statusMessage: "Connection Error",
          );
        case DioExceptionType.unknown:
          return Response(requestOptions: error.requestOptions, statusCode: 500, statusMessage: "Unexpected Error");
      }
    }
    return Response(requestOptions: RequestOptions(path: ''), statusCode: 500, statusMessage: "Unknown Error");
  }
}
