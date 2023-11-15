import 'package:prova_flutter_target_sistemas/domian/entities/user.dart';
import 'package:prova_flutter_target_sistemas/domian/result/success.dart';

class LoginSuccess extends Success {
  User? authenticatedUser;

  LoginSuccess({
    this.authenticatedUser,
    String message = '',
  }) : super(message);
}
