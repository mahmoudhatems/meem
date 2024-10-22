import 'package:dio/dio.dart';
import 'package:meem/core/api/api_consumer.dart';
import 'package:meem/core/api/endpoints.dart';
import 'package:meem/core/cached/cached_secure.dart';

class DioConsumer implements ApiConsumer {
  final Dio dio;
  DioConsumer({
    required this.dio,
    String langue = "en",
  }) {
    Map<String, dynamic> headers = {
      "Authorization": CachedSecure.getToken(),
      ApiKeys.language: langue,
    };
    dio
      ..options.baseUrl = EndPoints.baseUrl
      ..options.headers = headers
      ..interceptors
          .add(LogInterceptor(error: true, request: true, responseBody: true));
  }
  @override
  Future delete(
      {required String endPoint, Map<String, dynamic>? queryParameters}) async {
    Response response =
        await dio.delete(endPoint, queryParameters: queryParameters);
    return response.data;
  }

  @override
  Future get(
      {required String endPoint, Map<String, dynamic>? queryParameters}) async {
    Response response = await dio.get(endPoint,
        queryParameters: queryParameters,
        options: Options(
          headers: {
            "Authorization": await CachedSecure.getToken(),
          },
        ));
    return response.data;
  }

  @override
  Future patch(
      {required String endPoint,
      bool isFormData = false,
      Map<String, dynamic>? bodyData,
      Map<String, dynamic>? queryParameters}) async {
    Response response = await dio.patch(endPoint,
        queryParameters: queryParameters,
        data: isFormData ? FormData.fromMap(bodyData!) : bodyData,
        options: Options(
          headers: {
            "Authorization": await CachedSecure.getToken(),
          },
        ));
    return response.data;
  }

  @override
  Future post(
      {required String endPoint,
      bool isFormData = false,
      Map<String, dynamic>? bodyData,
      Map<String, dynamic>? queryParameters}) async {
    Response response = await dio.post(endPoint,
        queryParameters: queryParameters,
        data: isFormData ? FormData.fromMap(bodyData!) : bodyData,
        options: Options(
          headers: {
            "Authorization": await CachedSecure.getToken(),
          },
        ));
    return response.data;
  }

  @override
  Future put(
      {required String endPoint,
      bool isFormData = false,
      Map<String, dynamic>? bodyData,
      Map<String, dynamic>? queryParameters}) async {
    Response response = await dio.put(endPoint,
        queryParameters: queryParameters,
        data: isFormData ? FormData.fromMap(bodyData!) : bodyData,
        options: Options(
          headers: {
            "Authorization": await CachedSecure.getToken(),
          },
        ));
    return response.data;
  }
}
