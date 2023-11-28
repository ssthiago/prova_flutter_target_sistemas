import 'package:prova_flutter_target_sistemas/data/datasource/remote/i_authentication_datasource.dart';
import 'package:prova_flutter_target_sistemas/domian/entities/user.dart';
import 'package:prova_flutter_target_sistemas/domian/repositories/i_authentication_repository.dart';

class AuthenticationRepositoryImpl implements IAuthenticationRepository {
  final IAuthenticationDataSource authenticationDataSource;

  AuthenticationRepositoryImpl(this.authenticationDataSource);

  @override
  Future<User?> authenticateUser({required String username, required String password}) async =>
      await authenticationDataSource.authenticateUser(username: username, password: password);
}
