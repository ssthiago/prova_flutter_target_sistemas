import 'package:prova_flutter_target_sistemas/data/datasource/local_datasource.dart';
import 'package:prova_flutter_target_sistemas/data/models/user_model.dart';
import 'package:prova_flutter_target_sistemas/domian/entities/user.dart';
import 'package:prova_flutter_target_sistemas/domian/repositories/authentication_repository.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final LocalDataSource localDataSource;

  AuthenticationRepositoryImpl(this.localDataSource);

  @override
  Future<bool> authenticateUser(User user) async {
    // Implementação da autenticação utilizando localDataSource
    return await localDataSource.authenticateUser(UserModel.fromEntity(user));
  }
}
