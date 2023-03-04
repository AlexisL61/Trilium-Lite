import 'package:src/services/logger/Logger.dart';

class ApiConfiguration {
  String serverUri;
  int port;
  String? token;

  ApiConfiguration({required this.serverUri, required this.port, required this.token}){
    Logger().log("New ApiConfiguration : $serverUri $port");
  }
}
