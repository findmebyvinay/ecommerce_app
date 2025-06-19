class Failure {
  Failure({this.message, this.statusCode, this.errorCode});

  Failure.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    statusCode = json['code'].toString();
    errorCode =
        json['errors'] != null ? ErrorCode.fromJson(json['errors']) : null;
  }
  String? message;
  String? statusCode;
  ErrorCode? errorCode;

  Map<String, dynamic> toJson() {
    return {"message": message, "code": statusCode};
  }
}

class ErrorCode {
  List? errors;

  ErrorCode({this.errors});

  ErrorCode.fromJson(Map<String, dynamic> json) {
    errors = json['username'];
  }
}
