import 'package:prova_flutter_target_sistemas/domian/entities/user.dart';

import 'i_authentication_datasource.dart';
import 'mock_api.dart';

class AuthenticationDataSourceImpl implements IAuthenticationDataSource {
  final MockApi mockApi; // Supondo que MockApi seja a implementação da MockApi

  AuthenticationDataSourceImpl(this.mockApi);

  @override
  Future<bool> authenticateUser({required User user}) async {
    // Chamar o método authenticateUser da MockApi
    return mockApi.authenticateUser(user: user);
  }
}
