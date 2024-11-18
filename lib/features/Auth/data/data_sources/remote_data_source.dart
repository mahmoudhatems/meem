import 'package:meem/core/api/api_consumer.dart';
import 'package:meem/core/api/endpoints.dart';
import 'package:meem/core/cached/cached_secure.dart';
import 'package:meem/core/functions/change_token_state.dart';
import 'package:meem/core/utils/models/auth_model/auth_model.dart';

abstract class AuthRemoteDataSource {
  Future<AuthModel> login({
    required String email,
    required String password,
  });
  Future<AuthModel> register(
    context, {
    required String email,
    required String password,
    required String name,
    required String phone,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiConsumer apiConsumer;

  AuthRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<AuthModel> login(
      {required String email, required String password}) async {
    Map<String, dynamic> jsonData = await apiConsumer.post(
        endPoint: EndPoints.login,
        bodyData: {"email": email, "password": password},
        isFormData: true);
    AuthModel authModel = AuthModel.fromJson(jsonData);
    await changeTokenState(value: "true");
    CachedSecure.saveToken(authModel.data!.token!);

    return authModel;
  }

  @override
  Future<AuthModel> register(
    context, {
    required String email,
    required String password,
    required String name,
    required String phone,
  }) async {
    Map<String, dynamic> jsonData = await apiConsumer.post(
        endPoint: EndPoints.register,
        bodyData: {
          "email": email,
          "password": password,
          "name": name,
          "phone": phone,
          "image": null
        },
        isFormData: true);
    AuthModel authModel = AuthModel.fromJson(jsonData);
    await changeTokenState(value: "true");
    CachedSecure.saveToken(authModel.data!.token!);
    return authModel;
  }
}
