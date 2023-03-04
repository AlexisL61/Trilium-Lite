class Logger {
  static final Logger _instance = Logger._internal();

  factory Logger() {
    return _instance;
  }

  Logger._internal();

  int threadDepth = 0;

  void log(String message) {
    print(
        "${"\x1B[34m[" + DateTime.now().toString() + "] : " + _getLogDepthString()}$message\x1B[0m");
  }

  void error(String message) {
    print(
        "${"\x1B[31m[" + DateTime.now().toString() + "] : " + _getLogDepthString()}$message\x1B[0m");
  }

  void startLogThread(String message) {
    log("> $message");
    threadDepth++;
  }

  void stopLogThread([String message=""]) {
    threadDepth--;
    log("< $message");
  }

  void reserLogThreads(){
    threadDepth = 0;
  }

  String _getLogDepthString() {
    String depthString = "";
    for (int i = 0; i < threadDepth; i++) {
      depthString += "| ";
    }
    return depthString;
  }
}
