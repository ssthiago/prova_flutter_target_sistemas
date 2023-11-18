import 'package:prova_flutter_target_sistemas/domian/entities/user.dart';

abstract class IAuthenticationRepository {
  Future<bool> authenticateUser({required User user});
}
