import 'package:prova_flutter_target_sistemas/domian/entities/user.dart';

class UserModel {
  final String username;
  final String password;

  UserModel({required this.username, required this.password});

  factory UserModel.fromEntity(User user) {
    return UserModel(username: user.username, password: user.password);
  }
}
