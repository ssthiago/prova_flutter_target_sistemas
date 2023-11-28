import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:prova_flutter_target_sistemas/data/services/authenticated/i_user_session_manager.dart';
import 'package:prova_flutter_target_sistemas/domian/entities/user.dart';
import 'package:prova_flutter_target_sistemas/domian/entities/user_session.dart';
import 'package:prova_flutter_target_sistemas/domian/repositories/i_authentication_repository.dart';
import 'package:prova_flutter_target_sistemas/domian/usecases/authentication/login/login_usecase.dart';
import 'package:prova_flutter_target_sistemas/domian/usecases/authentication/login/result/login_failure.dart';
import 'package:prova_flutter_target_sistemas/domian/usecases/authentication/login/result/login_params.dart';
import 'package:prova_flutter_target_sistemas/domian/usecases/authentication/login/result/login_success.dart';

class MockAuthenticationRepository extends Mock implements IAuthenticationRepository {}

class MockUserSessionManager extends Mock implements IUserSessionManager {}

class FakeUserSession extends Fake implements UserSession {}

void main() {
  group('LoginUseCase', () {
    late MockAuthenticationRepository mockAuthenticationRepository;
    late MockUserSessionManager mockUserSessionManager;
    late LoginUseCase loginUseCase;
    setUpAll(() {
      registerFallbackValue(FakeUserSession());
    });
    setUp(() {
      mockAuthenticationRepository = MockAuthenticationRepository();
      mockUserSessionManager = MockUserSessionManager();
      loginUseCase = LoginUseCase(mockAuthenticationRepository, mockUserSessionManager);
      registerFallbackValue(User(
          id: '1',
          name: 'Thiago',
          username: 'fallback',
          password: 'foobar')); // Cria uma instância dummy de `User` como o valor padrão
    });

    test('should return LoginSuccess when authentication is success', () async {
      // Arrange
      final params = LoginParams(username: 'user', password: 'password');
      when(
        () => mockAuthenticationRepository.authenticateUser(
            username: params.username, password: params.password),
      ).thenAnswer(
        (_) async =>
            Future.value(User(id: '1111', name: 'Thiago', username: 'user', password: 'password')),
      );

      when(
        () => mockUserSessionManager.addSession(any(), FakeUserSession()),
      ).thenAnswer(
        (_) async => Future.value(),
      );

      // Act
      final result = await loginUseCase(params);

      // Assert
      expect(result, isA<LoginSuccess>());
      expect((result as LoginSuccess).authenticatedUser, isNotNull);
      verify(() => mockAuthenticationRepository.authenticateUser(
          username: params.username, password: params.password)).called(1);
      verifyNoMoreInteractions(mockAuthenticationRepository);
    });

    test('should return LoginFailure when authentication fails', () async {
      // Arrange
      final params = LoginParams(username: 'user', password: 'password');
      when(
        () => mockAuthenticationRepository.authenticateUser(
            username: params.username, password: params.password),
      ).thenAnswer(
        (_) async => Future.value(null),
      );

      // Act
      final result = await loginUseCase(params);

      // Assert
      expect(result, isA<LoginFailure>());
      expect((result as LoginFailure).message, equals('Username ou senha inválidos'));
      verify(() => mockAuthenticationRepository.authenticateUser(
          username: params.username, password: params.password)).called(1);
      verifyNoMoreInteractions(mockAuthenticationRepository);
    });
  });
}
