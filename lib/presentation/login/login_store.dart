import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobx/mobx.dart';

part 'login_store.g.dart';

class LoginStore = LoginStoreBase with _$LoginStore;

abstract class LoginStoreBase with Store {
  @observable
  String username = '';

  @observable
  String password = '';

  @action
  void setUsername(String value) => username = value;

  @action
  void setPassword(String value) => password = value;

  @action
  void goToInformationPage(BuildContext context) => GoRouter.of(context).go('/informations');
}

//flutter packages pub run build_runner build
//flutter pub run build_runner build --delete-conflicting-outputs
