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
    final LoginSuccess loginSuccess = LoginSuccess();
    User authenticatedUser = User(username: params.username, password: params.password);
    bool isLoginSuccess = await repository.authenticateUser(user: authenticatedUser);
    if (isLoginSuccess) {
      loginSuccess.authenticatedUser = authenticatedUser;
      return loginSuccess;
    } else {
      return LoginFailure('Username ou senha inválidos');
    }
  }
}
