import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:prova_flutter_target_sistemas/domian/entities/user.dart';

import 'api/i_client_api.dart';
import 'i_authentication_datasource.dart';

class AuthenticationDataSourceImpl implements IAuthenticationDataSource {
  final IClientApi clientApi;

  AuthenticationDataSourceImpl({required this.clientApi});

  @override
  Future<User?> authenticateUser({required User user}) async {
    final Response response =
        await clientApi.get(path: 'users?username=${user.username}&password=${user.password}');

    if (response.data != null && response.data.isNotEmpty) {
      // Se a resposta contiver dados, converte para um objeto User
      return User.fromJson(response.data[0]);
    } else {
      // Se a resposta estiver vazia ou não contiver dados válidos, retorna null
      return null;
    }
  }
}
