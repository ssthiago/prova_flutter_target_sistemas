import 'package:prova_flutter_target_sistemas/domian/entities/user.dart';
import 'package:prova_flutter_target_sistemas/domian/repositories/authentication_repository.dart';

class AuthenticateUser {
  final AuthenticationRepository repository;

  AuthenticateUser(this.repository);

  Future<bool> call(User user) async {
    // Implementação da lógica de autenticação
    // Retorna true se a autenticação for bem-sucedida, false caso contrário.
    return await repository.authenticateUser(user);
  }
}
