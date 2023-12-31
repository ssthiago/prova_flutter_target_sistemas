import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobx/mobx.dart';
import 'package:prova_flutter_target_sistemas/domian/result/result.dart';
import 'package:prova_flutter_target_sistemas/domian/usecases/authentication/login/login_usecase.dart';
import 'package:prova_flutter_target_sistemas/domian/usecases/authentication/login/result/login_failure.dart';
import 'package:prova_flutter_target_sistemas/domian/usecases/authentication/login/result/login_params.dart';
import 'package:prova_flutter_target_sistemas/domian/usecases/authentication/login/result/login_success.dart';
import 'package:prova_flutter_target_sistemas/presentation/common_widgets/bottom_sheet/bottom_sheet_store.dart';
import 'package:url_launcher/url_launcher.dart';

part 'login_store.g.dart';

class LoginStore = LoginStoreBase with _$LoginStore;

abstract class LoginStoreBase with Store {
  final LoginUseCase loginUseCase;
  final BottomSheetStore bottomSheetStore;

  LoginStoreBase({required this.loginUseCase, required this.bottomSheetStore});

  @observable
  String username = '';

  @observable
  String password = '';

  @observable
  bool isPasswordObscure = true;

  TextEditingController usernameFieldController = TextEditingController();

  TextEditingController passwordFieldController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @action
  void setUsername(String value) => username = value;

  @action
  void setPassword(String value) => password = value;

  @action
  Future<void> login(BuildContext context) async {
    bottomSheetStore.hideBottomSheet();
    final bool isValid = formKey.currentState!.validate();
    if (!isValid) {
      bottomSheetStore.hideBottomSheet();
      return;
    }
    formKey.currentState!.save();

    Result result = await loginUseCase(LoginParams(
        username: usernameFieldController.text, password: passwordFieldController.text));

    if (result is LoginSuccess) {
      // redirecionar para a de informations
      _goToInformationPage(context);
    }
    if (result is LoginFailure) {
      bottomSheetStore.setErrorMessage(result.message ?? '');
      bottomSheetStore.showBottomSheet();
    }
  }

  @action
  void togglePasswordObscure() => isPasswordObscure = !isPasswordObscure;

  void _goToInformationPage(BuildContext context) =>
      GoRouter.of(context).pushReplacement('/informations');

  Future<void> openExternalUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Não foi possivel abrir a url:  $url');
    }
  }
}

//flutter packages pub run build_runner build
//flutter pub run build_runner build --delete-conflicting-outputs
