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
    late LoginUseCase loginUseCase;
    late MockAuthenticationRepository mockRepository;

    setUp(() {
      mockRepository = MockAuthenticationRepository();
      loginUseCase = LoginUseCase(mockRepository);
    });

    test('should authenticate user successfully', () async {
      // Arrange
      final params = LoginParams(username: 'user', password: 'password');
      final authenticatedUser = User(username: 'user', password: 'password');
      bool a = await mockRepository.authenticateUser(authenticatedUser);
      when(() => mockRepository.authenticateUser(authenticatedUser)).thenAnswer((_) async => true);

      // Act
      final result = await loginUseCase(params);

      // Assert
      expect(result, isA<LoginSuccess>());
      expect((result as LoginSuccess).authenticatedUser, equals(authenticatedUser));
      verify(() => mockRepository.authenticateUser(authenticatedUser)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('should return LoginFailure when authentication fails', () async {
      // Arrange
      final params = LoginParams(username: 'user', password: 'password');
      final authenticatedUser = User(username: 'user', password: 'password');
      when(() => mockRepository.authenticateUser(authenticatedUser)).thenAnswer((_) async => false);

      // Act
      final result = await loginUseCase(params);

      // Assert
      expect(result, isA<LoginFailure>());
      expect((result as LoginFailure).message, equals('Username ou senha inválidos'));
      verify(() => mockRepository.authenticateUser(authenticatedUser)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });
  });
}
