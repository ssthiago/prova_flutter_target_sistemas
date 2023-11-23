import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobx/mobx.dart';
import 'package:prova_flutter_target_sistemas/domian/usecases/authentication/login/login_usecase.dart';
import 'package:url_launcher/url_launcher.dart';

part 'login_store.g.dart';

class LoginStore = LoginStoreBase with _$LoginStore;

abstract class LoginStoreBase with Store {
  final LoginUseCase loginUseCase;

  LoginStoreBase({required this.loginUseCase});

  @observable
  String username = '';

  @observable
  String password = '';

  @observable
  bool isPasswordObscure = true;

  TextEditingController emailFieldController = TextEditingController();

  TextEditingController passwordFieldController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @action
  void setUsername(String value) => username = value;

  @action
  void setPassword(String value) => password = value;

  @action
  Future<void> login(BuildContext context) async {
    final bool isValid = formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    formKey.currentState!.save();

    // redirecionar para a de informations
    _goToInformationPage(context);
  }

  @action
  void togglePasswordObscure() => isPasswordObscure = !isPasswordObscure;

  void _goToInformationPage(BuildContext context) => GoRouter.of(context).go('/informations');

  Future<void> openExternalUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Não foi possivel abrir a url:  $url');
    }
  }
}

//flutter packages pub run build_runner build
//flutter pub run build_runner build --delete-conflicting-outputs
