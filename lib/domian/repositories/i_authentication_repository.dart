import 'package:prova_flutter_target_sistemas/domian/entities/user.dart';

abstract class IAuthenticationRepository {
  Future<User?> authenticateUser({required String username, required String password});
}
