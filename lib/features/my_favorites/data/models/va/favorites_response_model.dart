import 'data.dart';

class FavoritesResponseModel {
  bool? status;
  dynamic message;
  Data? data;

  FavoritesResponseModel({this.status, this.message, this.data});

  factory FavoritesResponseModel.fromJson(Map<String, dynamic> json) => FavoritesResponseModel(
        status: json['status'] as bool?,
        message: json['message'] as dynamic,
        data: json['data'] == null
            ? null
            : Data.fromJson(json['data'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'data': data?.toJson(),
      };
}
