import 'package:prova_flutter_target_sistemas/domian/entities/user.dart';
import 'package:prova_flutter_target_sistemas/domian/repositories/i_authentication_repository.dart';
import 'package:prova_flutter_target_sistemas/domian/result/result.dart';
import 'package:prova_flutter_target_sistemas/domian/usecases/authentication/login/result/login_params.dart';
import 'package:prova_flutter_target_sistemas/domian/usecases/i_usecase.dart';

import 'result/login_failure.dart';
import 'result/login_success.dart';

class LoginUseCase implements IUseCase<LoginParams, Result> {
  final IAuthenticationRepository repository;

  LoginUseCase(this.repository);

  @override
  Future<Result> call(LoginParams params) async {
    try {
      User? authenticatedUser = await repository.authenticateUser(
          user: User(username: params.username, password: params.password));

      if (authenticatedUser != null) {
        return LoginSuccess(authenticatedUser: authenticatedUser);
      } else {
        return LoginFailure('Username ou senha inválida');
      }
    } catch (e) {
      // Tratar exceções se necessário
      throw Exception('Erro inesperado durante a autenticação : ${e.toString()}');
    }
  }
}
