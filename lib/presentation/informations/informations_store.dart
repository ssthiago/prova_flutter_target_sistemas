import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobx/mobx.dart';
import 'package:prova_flutter_target_sistemas/data/services/authenticated/i_user_session_manager.dart';
import 'package:prova_flutter_target_sistemas/data/services/information/i_information_manager.dart';
import 'package:prova_flutter_target_sistemas/domian/entities/information.dart';
import 'package:prova_flutter_target_sistemas/domian/entities/user_session.dart';
import 'package:prova_flutter_target_sistemas/domian/usecases/authentication/logout/logout_usecase.dart';
import 'package:prova_flutter_target_sistemas/domian/usecases/authentication/logout/result/logout_success.dart';
import 'package:url_launcher/url_launcher.dart';

part 'informations_store.g.dart';

class InformationsStore = InformationsStoreBase with _$InformationsStore;

abstract class InformationsStoreBase with Store {
  final IInformationsManager informationManager;
  final IUserSessionManager userSessionManager;
  final LogoutUseCase logoutUseCase;

  InformationsStoreBase({
    required this.userSessionManager,
    required this.informationManager,
    required this.logoutUseCase,
  });

  @observable
  String text = '';

  @computed
  Future<String> get loggedInUserName async {
    UserSession? authenticatedUserSession = await userSessionManager.getAuthenticatedUser();
    return Future.value(authenticatedUserSession?.user.name ?? '');
  }

  //@observable
  ObservableList<Information> informationList = ObservableList<Information>();

  @computed
  Future<ObservableList<Information>> get inicializeInformations async {
    final String? authenticatedUserId = await _getAutenticatedUserId();
    var imformationMap = await informationManager.getInformationMap();
    if (imformationMap.containsKey(authenticatedUserId!)) {
      informationList = ObservableList<Information>.of(imformationMap[authenticatedUserId]!);
      return informationList;
    }
    return ObservableList<Information>();
  }

  TextEditingController textFieldController = TextEditingController();
  @observable
  TextEditingController editTextFieldController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @action
  void setText(String value) => text = value;

  @action
  Future<void> logout(BuildContext context) async {
    await logoutUseCase().then((result) {
      if (result is LogoutSuccess) {
        GoRouter.of(context).pushReplacement('/');
      }
    });
  }

  @action
  Future<void> addInformation() async {
    final bool isValid = formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    final String? authenticatedUserId = await _getAutenticatedUserId();
    final newInformation =
        Information(text: textFieldController.text /*, timestamp: DateTime.now()*/);
    await informationManager.addInformation(authenticatedUserId!, newInformation);
    informationList.add(newInformation);
    text = ''; // Limpa o campo de texto após adicionar a informação
    textFieldController.text = '';
  }

  @action
  Future<void> editInformation(Information oldInformation, Information newInformation) async {
    final String? authenticatedUserId = await _getAutenticatedUserId();
    final index = informationList.indexWhere((info) => info == oldInformation);

    if (index != -1 && oldInformation.text != newInformation.text) {
      informationList[index] = newInformation;
      await informationManager.addInformation(authenticatedUserId!, newInformation);
    }
  }

  @action
  Future<void> removeInformation(Information information, int index) async {
    final String? authenticatedUserId = await _getAutenticatedUserId();
    informationList.remove(information);
    await informationManager.removeInformation(authenticatedUserId!, index);
  }

  Future<String?> _getAutenticatedUserId() async {
    final UserSession? userSession = await userSessionManager.getAuthenticatedUser();
    return userSession?.user.id;
  }

  Future<void> openExternalUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Não foi possivel abrir a url:  $url');
    }
  }
}
