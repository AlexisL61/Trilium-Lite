import 'package:src/services/logger/Logger.dart';

String tokenParser(Map<String, dynamic> data) {
  return data["authToken"];
}
