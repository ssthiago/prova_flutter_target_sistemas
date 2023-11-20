import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:prova_flutter_target_sistemas/data/datasource/remote/api/dio_client_api.dart';
import 'package:prova_flutter_target_sistemas/data/datasource/remote/authentication_datasource_impl.dart';
import 'package:prova_flutter_target_sistemas/data/datasource/remote/i_authentication_datasource.dart';
import 'package:prova_flutter_target_sistemas/domian/entities/user.dart';

class MockApiTest extends Mock implements DioClientApi {}

void main() {
  group('AuthenticationDataSourceImpl', () {
    late MockApiTest mockApi;
    late IAuthenticationDataSource authenticationDataSource;

    setUp(() {
      mockApi = MockApiTest();
      authenticationDataSource = AuthenticationDataSourceImpl(mockApi);
    });

    test('should successfully authenticate user', () async {
      final user = User(username: 'correctUsername', password: 'correctPassword');

      when(() => mockApi.authenticateUser(user: user)).thenAnswer((_) async => true);

      final result = await authenticationDataSource.authenticateUser(user: user);

      expect(result, true);
    });

    test('should fail to authenticate user with invalid credentials', () async {
      final user = User(username: 'incorrectUsername', password: 'incorrectPassword');

      when(() => mockApi.authenticateUser(user: user)).thenAnswer((_) async => false);

      final result = await authenticationDataSource.authenticateUser(user: user);

      expect(result, false);
    });
  });
}
