import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:prova_flutter_target_sistemas/data/services/authenticated/i_user_session_manager.dart';
import 'package:prova_flutter_target_sistemas/data/services/information/i_information_manager.dart';
import 'package:prova_flutter_target_sistemas/domian/entities/information.dart';
import 'package:prova_flutter_target_sistemas/domian/entities/user_session.dart';
import 'package:url_launcher/url_launcher.dart';

part 'informations_store.g.dart';

class InformationsStore = InformationsStoreBase with _$InformationsStore;

abstract class InformationsStoreBase with Store {
  final IInformationsManager informationManager;
  final IUserSessionManager userSessionManager;

  InformationsStoreBase({required this.userSessionManager, required this.informationManager});

  @observable
  String text = '';

  @observable
  ObservableList<Information> infoList = ObservableList<Information>();

  TextEditingController textFieldController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @action
  void setText(String value) => text = value;

  @action
  Future<void> addInformation() async {
    if (formKey.currentState?.validate() ?? false) {
      final UserSession userSession = await userSessionManager.getAuthenticatedUser();
      final newInformation = Information(text: text /*, timestamp: DateTime.now()*/);
      await informationManager.addInformation(userSession.user.id!, newInformation);
      text = ''; // Limpa o campo de texto após adicionar a informação
      textFieldController.text = '';
    }
  }

  @action
  Future<void> editInformation(Information oldInformation, Information newInformation) async {
    final UserSession userSession = await userSessionManager.getAuthenticatedUser();
    final index = infoList.indexWhere((info) => info == oldInformation);

    if (index != -1) {
      infoList[index] = newInformation;
      await informationManager.addInformation(userSession.user.id!, newInformation);
    }
  }

  @action
  Future<void> removeInformation(Information information, int index) async {
    final UserSession userSession = await userSessionManager.getAuthenticatedUser();
    infoList.remove(information);
    await informationManager.removeInformation(userSession.user.id!, index);
  }

  Future<void> openExternalUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Não foi possivel abrir a url:  $url');
    }
  }
}
