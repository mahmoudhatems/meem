import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:meem/core/errors/server_error.dart';
import 'package:meem/core/utils/models/auth_model/auth_model.dart';
import 'package:meem/features/Auth/data/data_sources/remote_data_source.dart';

abstract class AuthRepo {
  Future<Either<Failure, AuthModel>> login({
    required String email,
    required String password,
  });

  Future<Either<Failure, AuthModel>> register(
    context, {
    required String email,
    required String password,
    required String name,
    required String phone,
  });
}

class AuthRepoImpl implements AuthRepo {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepoImpl({required this.authRemoteDataSource});
  @override
  Future<Either<Failure, AuthModel>> login(
      {required String email, required String password}) async {
    try {
      AuthModel authModel =
          await authRemoteDataSource.login(email: email, password: password);

      return right(authModel);
    } on DioException catch (e) {
      return left(ServerFailure.fromDioException(e));
    } catch (e) {
      return left(ServerFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, AuthModel>> register(
    context, {
    required String email,
    required String password,
    required String name,
    required String phone,
  }) async {
    try {
      AuthModel authModel = await authRemoteDataSource.register(
        context,
        email: email,
        password: password,
        name: name,
        phone: phone,
      );
      return right(authModel);
    } on DioException catch (e) {
      return left(ServerFailure.fromDioException(e));
    } catch (e) {
      return left(ServerFailure(errorMessage: e.toString()));
    }
  }
}
