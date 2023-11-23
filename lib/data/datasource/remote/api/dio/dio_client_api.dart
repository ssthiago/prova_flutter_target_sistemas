import 'package:dio/dio.dart';
import 'package:prova_flutter_target_sistemas/data/datasource/remote/api/i_client_api.dart';

import 'dio_errors.dart';

class DioClientApi implements IClientApi {
  //clientApi.baseUrl = 'https://6556715f84b36e3a431fc30c.mockapi.io/api/v1/';
  String baseUrl;
  final Dio dio = Dio();

  DioClientApi({this.baseUrl = 'https://6556715f84b36e3a431fc30c.mockapi.io/api/v1/'});

  void init() {
    dio.options.baseUrl = baseUrl;
    dio.options.contentType = 'application/json; charset=utf-8';
    dio.interceptors.clear();
  }

  @override
  Future<T> get<T>({required String path, Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await dio.get(path, queryParameters: queryParameters);
      return response.data;
    } on DioException catch (e) {
      throw DioErrors.fromDioError(e);
    }
  }

  @override
  Future<T> delete<T>(String path, {dynamic data}) async {
    try {
      final response = await dio.delete(path, data: data);
      return response.data;
    } on DioException catch (e) {
      throw DioErrors.fromDioError(e);
    }
  }

  @override
  Future<T> patch<T>(String path, {dynamic data}) async {
    try {
      final response = await dio.patch(path, data: data);
      return response.data;
    } on DioException catch (e) {
      throw DioErrors.fromDioError(e);
    }
  }

  @override
  Future<T> post<T>(String path, {dynamic data}) async {
    try {
      final response = await dio.post(path, data: data);
      return response.data;
    } on DioException catch (e) {
      throw DioErrors.fromDioError(e);
    }
  }

  @override
  Future<T> put<T>(String path, {dynamic data}) async {
    try {
      final response = await dio.put(path, data: data);
      return response.data;
    } on DioException catch (e) {
      throw DioErrors.fromDioError(e);
    }
  }
}
