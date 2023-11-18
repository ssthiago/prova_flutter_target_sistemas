import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:prova_flutter_target_sistemas/domian/entities/user.dart';
import 'package:prova_flutter_target_sistemas/domian/repositories/i_authentication_repository.dart';
import 'package:prova_flutter_target_sistemas/domian/usecases/authentication/login/login_usecase.dart';
import 'package:prova_flutter_target_sistemas/domian/usecases/authentication/login/result/login_failure.dart';
import 'package:prova_flutter_target_sistemas/domian/usecases/authentication/login/result/login_params.dart';
import 'package:prova_flutter_target_sistemas/domian/usecases/authentication/login/result/login_success.dart';

class MockAuthenticationRepository extends Mock implements IAuthenticationRepository {}

void main() {
  group('LoginUseCase', () {
    late MockAuthenticationRepository mockAuthenticationRepository;
    late LoginUseCase loginUseCase;

    setUp(() {
      mockAuthenticationRepository = MockAuthenticationRepository();
      loginUseCase = LoginUseCase(mockAuthenticationRepository);
      registerFallbackValue(User(
          username: 'fallback',
          password: 'foobar')); // Cria uma instância dummy de `User` como o valor padrão
    });

    test('should return LoginSuccess when authentication is success', () async {
      // Arrange
      final params = LoginParams(username: 'user', password: 'password');
      when(
        () => mockAuthenticationRepository.authenticateUser(user: any<User>(named: 'user')),
      ).thenAnswer(
        (_) async => Future.value(true),
      );

      // Act
      final result = await loginUseCase(params);

      // Assert
      expect(result, isA<LoginSuccess>());
      expect((result as LoginSuccess).authenticatedUser, isNotNull);
      verify(() => mockAuthenticationRepository.authenticateUser(user: any<User>(named: 'user')))
          .called(1);
      verifyNoMoreInteractions(mockAuthenticationRepository);
    });

    test('should return LoginFailure when authentication fails', () async {
      // Arrange
      final params = LoginParams(username: 'user', password: 'password');
      when(
        () => mockAuthenticationRepository.authenticateUser(user: any<User>(named: 'user')),
      ).thenAnswer(
        (_) async => Future.value(false),
      );

      // Act
      final result = await loginUseCase(params);

      // Assert
      expect(result, isA<LoginFailure>());
      expect((result as LoginFailure).message, equals('Username ou senha inválidos'));
      verify(() => mockAuthenticationRepository.authenticateUser(user: any<User>(named: 'user')))
          .called(1);
      verifyNoMoreInteractions(mockAuthenticationRepository);
    });
  });
}
