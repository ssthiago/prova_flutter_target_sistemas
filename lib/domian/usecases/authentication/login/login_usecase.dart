import 'package:prova_flutter_target_sistemas/data/services/authenticated/i_user_session_manager.dart';
import 'package:prova_flutter_target_sistemas/domian/entities/user.dart';
import 'package:prova_flutter_target_sistemas/domian/entities/user_session.dart';
import 'package:prova_flutter_target_sistemas/domian/repositories/i_authentication_repository.dart';
import 'package:prova_flutter_target_sistemas/domian/result/result.dart';
import 'package:prova_flutter_target_sistemas/domian/usecases/authentication/login/result/login_params.dart';
import 'package:prova_flutter_target_sistemas/domian/usecases/i_usecase.dart';

import 'result/login_failure.dart';
import 'result/login_success.dart';

class LoginUseCase implements IUseCase<LoginParams, Result> {
  final IAuthenticationRepository repository;
  final IUserSessionManager sessionManager;

  const LoginUseCase(this.repository, this.sessionManager);

  @override
  Future<Result> call(LoginParams params) async {
    try {
      User? authenticatedUser =
          await repository.authenticateUser(username: params.username, password: params.password);

      if (authenticatedUser != null) {
        await sessionManager.addSession(
          authenticatedUser.id!,
          UserSession(isAuthenticated: true, user: authenticatedUser),
        );
        return LoginSuccess(authenticatedUser: authenticatedUser);
      } else {
        return LoginFailure('Username ou senha inválidos');
      }
    } catch (e) {
      // Tratar exceções se necessário
      throw Exception('Erro inesperado durante a autenticação : ${e.toString()}');
    }
  }
}
