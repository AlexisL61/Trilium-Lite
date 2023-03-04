import 'package:src/services/api/ApiService.dart';
import 'package:src/services/logger/Logger.dart';

import '../api/ApiConfiguration.dart';

class LoginService {
  static final LoginService instance = LoginService._internal();

  factory LoginService() {
    return instance;
  }

  LoginService._internal();

  Future<void> login(String serverURL, String password) async {
    Logger().startLogThread("Try login to $serverURL");
    Uri uri = Uri.parse(serverURL);
    ApiService().configuration = ApiConfiguration(serverUri: uri.host, port : uri.port, token:null);
    String token = await ApiService().login(password);
    ApiService().configuration!.token = token;
    Logger().stopLogThread("Login success");
  }
}
