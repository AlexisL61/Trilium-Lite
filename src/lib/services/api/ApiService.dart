import 'dart:convert';
import 'dart:io';

import 'package:src/services/api/ApiConfiguration.dart';
import 'package:src/services/api/ApiError.dart';

typedef ApiDataParser<T> = T Function(Map<String, dynamic> message);

class ApiService {
  HttpClient client = HttpClient();
  ApiConfiguration? configuration;

  static final ApiService instance = ApiService._internal(null);

  factory ApiService() {
    return instance;
  }

  ApiService._internal(this.configuration);

  Future<T> _apiCall<T>({
    required String method,
    required String path,
    required ApiDataParser<T> dataParser,
    dynamic data,
  }) async {
    if (configuration == null) {
      throw ApiError(
          code: "NO_CONFIGURATION",
          message: "Not connected to server",
          status: -1);
    } else {
      try {
        final request = await client.open(
            method, configuration!.serverUri, configuration!.port, path);
        request.headers.contentType = ContentType.json;
        request.write(jsonEncode(data));
        final response = await request.close();
        final responseBody = jsonDecode(await response.transform(utf8.decoder).join());
        _errorVerification(responseBody);
        return dataParser(responseBody);
      } on ApiError catch (e) {
        rethrow;
      } catch (e) {
        throw "Cannot connect to server : $e";
      }
    }
  }

  void _errorVerification(Map<String, dynamic> responseJson) {
    if (responseJson.containsKey("status")) {
      throw ApiError.fromJson(responseJson);
    }
  }
}
