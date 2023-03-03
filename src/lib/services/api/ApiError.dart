class ApiError implements Exception{
  final String code;
  final String message;
  final int status;

  ApiError({required this.code, required this.message, required this.status});

  factory ApiError.fromJson(Map<String, dynamic> json) {
    return ApiError(
      code: json['code'],
      message: json['message'],
      status: json['status'],
    );
  }

  @override
  toString() {
    return "$message ($code)";
  }

}
