class ICMLoginResult {
  bool success;
  String? message;
  dynamic error;

  ICMLoginResult({
    this.success = false,
    this.message,
  });

  factory ICMLoginResult.fromJson(Map<String, dynamic> json) {
    return ICMLoginResult(
      success: json['success'] ?? false,
      message: json['message'],
    );
  }
}