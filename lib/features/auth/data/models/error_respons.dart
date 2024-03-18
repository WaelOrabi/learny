
class ErrorResponse {
   String message;
   List<String>? errors;

  ErrorResponse({
    required this.message,
    required this.errors,
  });

  factory ErrorResponse.fromJson(Map<String, dynamic> json) {
    return ErrorResponse(
      message: json['message'],
      errors: json['errors'][0]==null?null:
      List<String>.from(json['errors']),
    );
  }
}
