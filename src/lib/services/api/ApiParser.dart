import 'package:src/services/logger/Logger.dart';

import '../../model/Note.dart';

String tokenParser(Map<String, dynamic> data) {
  return data["authToken"];
}

Note noteParser(Map<String, dynamic> data) {
  return Note.fromJson(data);
}
