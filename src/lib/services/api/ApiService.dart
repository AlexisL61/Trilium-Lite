import 'dart:convert';
import 'dart:io';

import 'package:src/services/api/ApiConfiguration.dart';
import 'package:src/services/api/ApiError.dart';
import 'package:src/services/api/ApiParser.dart';
import 'package:src/services/logger/Logger.dart';

import '../../model/Note.dart';

typedef ApiDataParser<T> = T Function(Map<String, dynamic> message);

class ApiService {
  HttpClient client = HttpClient();
  ApiConfiguration? configuration;

  static final ApiService instance = ApiService._internal(null);

  factory ApiService() {
    return instance;
  }

  ApiService._internal(this.configuration);

  Future<String> login(String password) {
    return _apiCall<String>(
        method: "POST",
        path: "/etapi/auth/login",
        data: {"password": password},
        dataParser: tokenParser);
  }

  Future<Note> getNote(String id){
    return _apiCall<Note>(
        method: "GET",
        path: "/etapi/notes/"+id,
        
        dataParser: noteParser);
  }

  Future<T> _apiCall<T>({
    required String method,
    required String path,
    required ApiDataParser<T> dataParser,
    dynamic data,
  }) async {
    Logger().startLogThread("API call : $method $path");
    if (configuration == null) {
      throw ApiError(
          code: "NO_CONFIGURATION",
          message: "Not connected to server",
          status: -1);
    } else {
      try {
        // Opening the request
        final request = await client.open(
            method, configuration!.serverUri, configuration!.port, path);

        request.headers.contentType = ContentType.json;
        if (configuration!.token != null) {
          request.headers.add("Authorization", "${configuration!.token}");
        }
        if (data != null)
          request.write(jsonEncode(data));
        final response = await request.close();
        final responseData = await response.transform(utf8.decoder).join();
        Logger().log("Response : ${response.statusCode} ${responseData}");
        final responseBody = jsonDecode(responseData);
        _errorVerification(responseBody);

        return dataParser(responseBody);
      } on ApiError catch (e) {
        Logger().error("Error received from the api : ${e.code}");
        rethrow;
      } catch (e) {
        Logger().error("Error while calling API : $e");
        throw "Cannot connect to server : $e";
      } finally {
        Logger().stopLogThread();
      }
    }
  }

  void _errorVerification(Map<String, dynamic> responseJson) {
    if (responseJson.containsKey("status")) {
      throw ApiError.fromJson(responseJson);
    }
  }
}
