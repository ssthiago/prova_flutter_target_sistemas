import 'package:prova_flutter_target_sistemas/domian/entities/user.dart';

import 'api/i_client_api.dart';
import 'i_authentication_datasource.dart';

class AuthenticationDataSourceImpl implements IAuthenticationDataSource {
  final IClientApi clientApi;

  AuthenticationDataSourceImpl({required this.clientApi});

  @override
  Future<User?> authenticateUser({required User user}) async {
    final response =
        await clientApi.get(path: 'users?username=${user.username}&password=${user.password}');
    return User(username: 'username', password: 'password');
  }
}
