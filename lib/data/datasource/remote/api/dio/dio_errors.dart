import 'package:dio/dio.dart';

class DioErrors implements Exception {
  String message = '';

  DioErrors.fromDioError(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.cancel:
        message = 'A solicitação para o servidor foi cancelada';
        break;
      case DioExceptionType.connectionTimeout:
        message = 'Tempo limite de conexão com o servidor';
        break;
      case DioExceptionType.receiveTimeout:
        message = 'Receive timeout in connection with API server';
        break;
      case DioExceptionType.badResponse:
        message = _handleError(dioException);
        break;
      case DioExceptionType.sendTimeout:
        message = 'Send timeout in connection with API server';
        break;
      default:
        message = 'Alguma coisa deu errado';
        break;
    }
  }

  String _handleError(dynamic error) {
    late String errorMessage;

    try {
      final apiErrors = Map.from(error.response?.data);
      errorMessage =
          apiErrors['errors']?[0]?['message'] ?? 'Nossos servidores estão enfrentando problemas.';
    } catch (e) {
      errorMessage = 'Nossos servidores estão enfrentando problemas. Tente conectar mais tarde.';
    }

    return errorMessage.toString();
  }

  @override
  String toString() {
    return message;
  }
}
