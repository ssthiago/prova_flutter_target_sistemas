abstract class IClientApi {
  Future<T> get<T>(
      {required String path, Map<String, dynamic>? queryParameters});
  Future<T> post<T>(String path, {Object? data});
  Future<T> patch<T>(String path, {Object? data});
  Future<T> put<T>(String path, {Object? data});
  Future<T> delete<T>(String path, {Object? data});
}
