class OperationCartResponse {
  bool? status;
  String? message;

  OperationCartResponse({this.status, this.message});

  factory OperationCartResponse.fromJson(Map<String, dynamic> json) {
    return OperationCartResponse(
      status: json['status'] as bool?,
      message: json['message'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
      };
}
