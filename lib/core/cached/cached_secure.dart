// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CachedSecure {
  static late FlutterSecureStorage _storage;
  CachedSecure._();
  static init() {
    _storage = const FlutterSecureStorage();
  }

  static Future<void> saveToken(String value) async {
    return await _storage.write(key: 'token', value: value);
  }

  static Future<String?> getToken() async {
    return await _storage.read(key: 'token');
  }

  static Future<bool> containToken() async {
    return await _storage.containsKey(key: 'token');
  }

  static Future<void> deleteToken() async {
    return await _storage.delete(key: 'token');
  }

  static Future<void> saveUserInfo() async {
    User user = User(age: 20, name: "ammar");
    Map userMap = user.toJson();
    String userString = jsonEncode(userMap);
    return await _storage.write(key: 'userInfo', value: userString);
  }

  static Future<User?> getUserInfo() async {
    String? userInfo = await _storage.read(key: 'userInfo');
    if (userInfo != null) {
      Map<String, dynamic> userMap = jsonDecode(userInfo);
      User user = User.fromJson(userMap);
      return user;
    }
    return null;
  }
}

class User {
  String name;
  int age;
  User({
    required this.name,
    required this.age,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(name: json['name'], age: json['age']);
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'age': age};
  }
}
