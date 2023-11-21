import 'package:prova_flutter_target_sistemas/domian/entities/user.dart';

abstract class IAuthenticationDataSource {
  Future<User?> authenticateUser({required User user});
}
