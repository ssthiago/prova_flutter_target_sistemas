import 'package:prova_flutter_target_sistemas/domian/entities/user.dart';

import 'api/dio_client_api.dart';
import 'i_authentication_datasource.dart';

class AuthenticationDataSourceImpl implements IAuthenticationDataSource {
  final DioClientApi clientApi; // Supondo que MockApi seja a implementação da MockApi

  AuthenticationDataSourceImpl(this.clientApi);

  @override
  Future<bool> authenticateUser({required User user}) async {
    // Chamar o método authenticateUser da MockApi
    return clientApi.authenticateUser(user: user);
  }
}
