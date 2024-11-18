abstract class ApiConsumer {
  Future get({
    required String endPoint,
    Map<String, dynamic>? queryParameters,
  });
  Future delete({
    required String endPoint,
    Map<String, dynamic>? queryParameters,
  });
  Future post({
    required String endPoint,
    bool isFormData = false,
    Map<String, dynamic>? bodyData,
    Map<String, dynamic>? queryParameters,
  });
  Future patch({
    required String endPoint,
    bool isFormData = false,
    Map<String, dynamic>? bodyData,
    Map<String, dynamic>? queryParameters,
  });
  Future put({
    required String endPoint,
    bool isFormData = false,
    Map<String, dynamic>? bodyData,
    Map<String, dynamic>? queryParameters,
  });
}
