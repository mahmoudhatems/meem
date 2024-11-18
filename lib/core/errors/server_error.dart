// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';

abstract class Failure {
  final String errorMessage;
  Failure({
    required this.errorMessage,
  });
}

class ServerFailure extends Failure {
  ServerFailure({required super.errorMessage});
  factory ServerFailure.fromDioException(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure(
            errorMessage: "Connection Timeout with ApiServer ");
      case DioExceptionType.receiveTimeout:
        return ServerFailure(errorMessage: "Receive Timeout with ApiServer ");
      case DioExceptionType.sendTimeout:
        return ServerFailure(errorMessage: "Send Timeout with ApiServer ");
      case DioExceptionType.cancel:
        return ServerFailure(errorMessage: "Request is cancel ");
      case DioExceptionType.connectionError:
        return ServerFailure(errorMessage: "No internet Connection");
      case DioExceptionType.unknown:
        return ServerFailure(errorMessage: "Unexpected Error,try again");
      case DioExceptionType.badResponse:
        return ServerFailure._formBadResponse(
            dioError.response!.statusCode!, dioError.response!.data);
      default:
        return ServerFailure(errorMessage: 'Opps , there was an error');
    }
  }
  factory ServerFailure._formBadResponse(int statusCode, dynamic response) {
    switch (statusCode) {
      case 400:
        return ServerFailure(
          errorMessage: response["message"], //this for changed Depend on api
        );
      case 401:
        return ServerFailure(errorMessage: 'Unauthorized');
      case 403:
        return ServerFailure(errorMessage: 'Forbidden');
      case 404:
        return ServerFailure(errorMessage: 'Not Found');

      case 408:
        return ServerFailure(errorMessage: 'Request Timeout');

      case 409:
        return ServerFailure(errorMessage: 'Conflict');

      case 410:
        return ServerFailure(errorMessage: 'Gone');

      case 411:
        return ServerFailure(errorMessage: 'Length Required');

      case 412:
        return ServerFailure(errorMessage: 'Precondition Failed');

      case 413:
        return ServerFailure(errorMessage: 'Payload Too Large');

      case 414:
        return ServerFailure(errorMessage: 'URI Too Long');

      case 415:
        return ServerFailure(errorMessage: 'Unsupported Media Type');

      case 416:
        return ServerFailure(errorMessage: 'Range Not Satisfiable');

      case 417:
        return ServerFailure(errorMessage: 'Expectation Failed');

      case 418:
        return ServerFailure(errorMessage: 'I\'m a teapot');
      case 421:
        return ServerFailure(errorMessage: 'Misdirected Request');
      case 422:
        return ServerFailure(errorMessage: 'Unprocessable Entity');

      case 429:
        return ServerFailure(errorMessage: 'Too Many Requests');

      case 500:
        return ServerFailure(errorMessage: 'Internal Server Error');
      case 502:
        return ServerFailure(errorMessage: 'Bad Gateway');
      case 503:
        return ServerFailure(errorMessage: 'Service Unavailable');
      case 504:
        return ServerFailure(errorMessage: 'Gateway Timeout');
      case 505:
        return ServerFailure(errorMessage: 'HTTP Version Not Supported');
      case 511:
        return ServerFailure(errorMessage: 'Network Authentication Required');

      case 521:
        return ServerFailure(errorMessage: 'Web Server Is Down');

      case 522:
        return ServerFailure(errorMessage: 'Connection Timed Out');

      case 523:
        return ServerFailure(errorMessage: 'Origin Is Unreachable');

      case 524:
        return ServerFailure(errorMessage: 'A Timeout Occurred');

      case 525:
        return ServerFailure(errorMessage: 'SSL Handshake Failed');

      case 526:
        return ServerFailure(errorMessage: 'Invalid SSL Certificate');

      case 527:
        return ServerFailure(errorMessage: 'Network Connect Timeout Error');

      case 528:
        return ServerFailure(errorMessage: 'Network Authentication Required');

      default:
        return ServerFailure(errorMessage: 'Unexpected error');
    }
  }
}
