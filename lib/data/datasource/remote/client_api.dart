import 'package:prova_flutter_target_sistemas/domian/entities/user.dart';

class MockApi {
  Future<bool> authenticateUser({required User user}) async {
    // Simulação de autenticação
    await Future.delayed(const Duration(seconds: 2));
    if (user.username == 'user' && user.password == 'password') {
      return true;
    } else {
      return false;
    }
  }
}
