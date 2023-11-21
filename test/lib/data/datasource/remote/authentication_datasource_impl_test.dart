import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:prova_flutter_target_sistemas/data/datasource/remote/api/dio/dio_client_api.dart';
import 'package:prova_flutter_target_sistemas/data/datasource/remote/api/i_client_api.dart';
import 'package:prova_flutter_target_sistemas/data/datasource/remote/authentication_datasource_impl.dart';
import 'package:prova_flutter_target_sistemas/data/datasource/remote/i_authentication_datasource.dart';
import 'package:prova_flutter_target_sistemas/domian/entities/user.dart';

class MockClientApi extends Mock implements IClientApi {}

void main() {
  group('AuthenticationDataSourceImpl', () {
    late MockClientApi mockDioClientApi;
    late IAuthenticationDataSource authenticationDataSource;

    setUp(() {
      mockDioClientApi = MockClientApi();
      authenticationDataSource = AuthenticationDataSourceImpl(clientApi: mockDioClientApi);
    });

    test('should successfully authenticate user', () async {
      // Arrange - Configura o comportamento esperado
      final user = User(username: 'correctUsername', password: 'correctPassword');
      final path = 'users?username=${user.username}&password=${user.password}';
      final Response<dynamic> response = Response(
        data: '{"id": 231, "username": "${user.username}", "password": "${user.password}"}',
        statusCode: 200,
        requestOptions: RequestOptions(),
      );

      when(() => mockDioClientApi.get(path: path)).thenAnswer((_) async => response);

      //Act - Executa a ação
      final result = await authenticationDataSource.authenticateUser(user: user);
      //expect(result, matcher);
    });
  });
}
