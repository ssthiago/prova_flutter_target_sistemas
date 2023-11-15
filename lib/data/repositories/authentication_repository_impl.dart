import 'package:prova_flutter_target_sistemas/data/datasource/remote/authentication_datasource.dart';
import 'package:prova_flutter_target_sistemas/domian/entities/user.dart';
import 'package:prova_flutter_target_sistemas/domian/repositories/i_authentication_repository.dart';

class AuthenticationRepositoryImpl implements IAuthenticationRepository {
  final AuthenticationDataSource authenticationDataSource;

  AuthenticationRepositoryImpl(this.authenticationDataSource);

  @override
  Future<bool> authenticateUser(User user) async {
    // Implementação da autenticação utilizando localDataSource
    //return await authenticationDataSource.authenticateUser(user:UserModel.fromEntity(user));
    return await authenticationDataSource.authenticateUser(user: user);
  }
}
