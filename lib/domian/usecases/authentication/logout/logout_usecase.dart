import 'package:prova_flutter_target_sistemas/data/services/authenticated/i_user_session_manager.dart';
import 'package:prova_flutter_target_sistemas/domian/entities/user_session.dart';
import 'package:prova_flutter_target_sistemas/domian/result/result.dart';
import 'package:prova_flutter_target_sistemas/domian/usecases/i_usecase_no_params.dart';

import 'result/logout_failure.dart';
import 'result/logout_success.dart';

class LogoutUseCase implements IUseCaseNoParams<Result> {
  final IUserSessionManager userSessionManager;

  const LogoutUseCase(this.userSessionManager);

  @override
  Future<Result> call() async {
    try {
      UserSession? authenticatedUserSession = await userSessionManager.getAuthenticatedUser();

      if (authenticatedUserSession != null) {
        await userSessionManager.removeSession(authenticatedUserSession.user.id!);
        return LogoutSuccess();
      } else {
        return LogoutFailure('Nenhum usuario autenticado');
      }
    } catch (e) {
      // Tratar exceções se necessário
      throw Exception('Erro inesperado durante o logout : ${e.toString()}');
    }
  }
}
