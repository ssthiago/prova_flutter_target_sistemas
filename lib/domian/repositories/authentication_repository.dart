import 'package:prova_flutter_target_sistemas/domian/entities/user.dart';

abstract class AuthenticationRepository {
  Future<bool> authenticateUser(User user);
}
