import 'package:prova_flutter_target_sistemas/data/datasource/local/local_authenticated_datasource.dart';
import 'package:prova_flutter_target_sistemas/domian/entities/user.dart';
import 'package:prova_flutter_target_sistemas/domian/repositories/authentication_repository.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final LocalAuthenticatedDataSource localInformationDataSource;

  AuthenticationRepositoryImpl(this.localInformationDataSource);

  @override
  Future<bool> authenticateUser(User user) async {
    // Implementação da autenticação utilizando localDataSource
    //return await localInformationDataSource.authenticateUser(UserModel.fromEntity(user));
    return true;
  }
}
