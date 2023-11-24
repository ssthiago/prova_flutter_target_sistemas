// entidade que representa uma sessão local de usuario
import 'dart:convert';

import 'user.dart';

class UserSession {
  bool isAuthenticated;
  User user;

  UserSession({
    required this.isAuthenticated,
    required this.user,
  });

  String toJson() {
    return jsonEncode({
      'isAuthenticated': isAuthenticated,
      'user': user.toJson(),
    });
  }

  factory UserSession.fromJson(String jsonString) {
    Map<String, dynamic> json = jsonDecode(jsonString);
    return UserSession(
      isAuthenticated: json['isAuthenticated'],
      user: User.fromJson(json['user']),
    );
  }
}
