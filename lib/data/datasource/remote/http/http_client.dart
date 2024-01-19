import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:live_app/utils/constants.dart';

import 'package:http_parser/http_parser.dart';

class HttpApiClient {
  final String baseUrl = Constants.baseUrl;
  final int requestTimeout = 30;

  HttpApiClient();

  Future<http.Response> get(String path, {String? bearerToken}) async {
    try {
      final headers = _buildHeaders(bearerToken, 'application/json');

      log('GET Request: $baseUrl$path');
      log('Request Headers: $headers');

      final response = await http.get(
        Uri.parse('$baseUrl$path'),
        headers: headers,
      ).timeout(Duration(seconds: requestTimeout), onTimeout: _handleTimeout);

      _logResponse(response);

      return response;
    } catch (e) {
      return _handleApiException(e);
    }
  }

  Future<http.Response> post(String path, dynamic body, {String? bearerToken}) async {
    try {
      final headers = _buildHeaders(bearerToken, 'application/json');

      log('POST Request: $baseUrl$path');
      log('Request Headers: $headers');
      log('Request Body: ${json.encode(body)}');

      final response = await http.post(
        Uri.parse('$baseUrl$path'),
        headers: headers,
        body: json.encode(body),
      ).timeout(Duration(seconds: requestTimeout), onTimeout: _handleTimeout);

      _logResponse(response);

      return response;
    } catch (e) {
      return _handleApiException(e);
    }
  }

  Future<http.Response> put(String path, dynamic body, {String? bearerToken}) async {
    try {
      final headers = _buildHeaders(bearerToken, 'application/json');

      log('PUT Request: $baseUrl$path');
      log('Request Headers: $headers');
      log('Request Body: ${json.encode(body)}');

      final response = await http.put(
        Uri.parse('$baseUrl$path'),
        headers: headers,
        body: json.encode(body),
      ).timeout(Duration(seconds: requestTimeout), onTimeout: _handleTimeout);

      _logResponse(response);

      return response;
    } catch (e) {
      return _handleApiException(e);
    }
  }

  Future<http.Response> patch(String path, dynamic body, {String? bearerToken}) async {
    try {
      final headers = _buildHeaders(bearerToken, 'application/json');

      log('PATCH Request: $baseUrl$path');
      log('Request Headers: $headers');
      log('Request Body: ${json.encode(body)}');

      final response = await http.patch(
        Uri.parse('$baseUrl$path'),
        headers: headers,
        body: json.encode(body),
      ).timeout(Duration(seconds: requestTimeout), onTimeout: _handleTimeout);

      _logResponse(response);

      return response;
    } catch (e) {
      return _handleApiException(e);
    }
  }

  Future<http.Response> delete(String path, dynamic body, {String? bearerToken}) async {
    try {
      final headers = _buildHeaders(bearerToken, 'application/json');

      log('DELETE Request: $baseUrl$path');
      log('Request Headers: $headers');
      log('Request Body: ${json.encode(body)}');

      final response = await http.delete(
        Uri.parse('$baseUrl$path'),
        body: json.encode(body),
        headers: headers,
      ).timeout(Duration(seconds: requestTimeout), onTimeout: _handleTimeout);

      _logResponse(response);

      return response;
    } catch (e) {
      return _handleApiException(e);
    }
  }

  Future<http.Response> postMultipart(String path, Map<String, dynamic> fields, {String? bearerToken,String? method}) async {
    try {
      final headers = _buildHeaders(bearerToken, 'multipart/form-data');

      log('POST Multipart Request: $baseUrl$path');
      log('Request Headers: $headers');
      log('Multipart Fields: $fields');

      final request = http.MultipartRequest(method??'POST', Uri.parse('$baseUrl$path'));
      request.headers.addAll(headers);

      fields.forEach((key, value) {
        request.fields[key] = value;
      });

      final response = await request.send().timeout(Duration(seconds: requestTimeout), onTimeout: _handleStreamedTimeout);
      final responseString = await response.stream.bytesToString();

      _logResponse(http.Response(responseString, response.statusCode));

      return http.Response(responseString, response.statusCode);
    } catch (e) {
      return _handleApiException(e);
    }
  }

  Future<http.Response> postMultipartFile(String path, Map<String, String> fields, String fileKey, String filePath, {String? bearerToken,String? method}) async {
    try {
      final headers = _buildHeaders(bearerToken, 'multipart/form-data');

      log('${method ?? 'POST'} Multipart File Request: $baseUrl$path');
      log('Request Headers: $headers');
      log('Multipart Fields: $fields');
      log('File Key: $fileKey');
      log('File Path: $filePath');

      final request = http.MultipartRequest(method??'POST', Uri.parse('$baseUrl$path'));
      request.headers.addAll(headers);

      fields.forEach((key, value) {
        request.fields[key] = value;
      });

      final file = File(filePath);
      final fileStream = http.ByteStream(file.openRead());
      final length = await file.length();

      final multipartFile = http.MultipartFile(
        fileKey,
        fileStream,
        length,
        filename: file.path,
        contentType: MediaType('image', _getMediaType(file.path)),
      );

      request.files.add(multipartFile);


      final response = await request.send().timeout(Duration(seconds: requestTimeout), onTimeout: _handleStreamedTimeout);
      final responseString = await response.stream.bytesToString();

      _logResponse(http.Response(responseString, response.statusCode));

      return http.Response(responseString, response.statusCode);
    } catch (e) {
      return _handleApiException(e);
    }
  }

  Map<String, String> _buildHeaders(String? bearerToken, String contentType) {
    final headers = <String, String>{
      'Content-Type': contentType,
    };

    if (bearerToken != null) {
      headers['Authorization'] = 'Bearer $bearerToken';
    }

    return headers;
  }

  Future<http.Response> _handleTimeout() async {
    return http.Response('Request Timeout', 504);
  }

  Future<http.StreamedResponse> _handleStreamedTimeout() async {
    const errorBody = 'Request Timeout';
    final errorStream = Stream<List<int>>.fromIterable([errorBody.codeUnits]);
    final errorResponse = http.StreamedResponse(
      errorStream,
      504,
      contentLength: errorBody.length,
    );
    return errorResponse;
  }

  Future<http.Response> _handleApiException(Object error) async {
    if (error is SocketException) {
      log('Socket Exception: $error');
      return http.Response('No Internet Connection', 400);
    } else {
      throw error;
    }
  }

  void _logResponse(http.Response response) {
    log('Response Status Code: ${response.statusCode}');
    log('Response Body: ${response.body}');
  }
  String _getMediaType(String filePath) {
    // Map file extensions to media types
    Map<String, String> mediaTypeMap = {
      'jpg': 'jpeg',
      'jpeg': 'jpeg',
      'png': 'png',
      'gif': 'gif',
      'bmp': 'bmp',
      'webp': 'webp',
      // Add more as needed
    };

    String extension = filePath.split('.').last.toLowerCase();
    return mediaTypeMap[extension] ?? 'jpeg'; // Default to jpeg if not recognized
  }
}