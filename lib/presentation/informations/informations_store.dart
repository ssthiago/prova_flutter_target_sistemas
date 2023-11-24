import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:prova_flutter_target_sistemas/data/services/information/information_manager.dart';
import 'package:prova_flutter_target_sistemas/domian/entities/information.dart';
import 'package:url_launcher/url_launcher.dart';

part 'informations_store.g.dart';

class InformationsStore = InformationsStoreBase with _$InformationsStore;

abstract class InformationsStoreBase with Store {
  final InformationsManager informationManager;

  InformationsStoreBase(this.informationManager);
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
      final userId = '123'; // Substitua isso pela lógica para obter o ID do usuário autenticado
      final newInformation = Information(text: text /*, timestamp: DateTime.now()*/);
      await informationManager.addInformation(userId, newInformation);
      text = ''; // Limpa o campo de texto após adicionar a informação
    }
  }

  @action
  Future<void> editInformation(Information oldInformation, Information newInformation) async {
    final userId = '123'; // Substitua isso pela lógica para obter o ID do usuário autenticado
    final index = infoList.indexWhere((info) => info == oldInformation);

    if (index != -1) {
      infoList[index] = newInformation;
      await informationManager.addInformation(userId, newInformation);
    }
  }

  @action
  Future<void> removeInformation(Information information, int index) async {
    final userId = '123'; // Substitua isso pela lógica para obter o ID do usuário autenticado
    infoList.remove(information);
    await informationManager.removeInformation(userId, index);
  }

  Future<void> openExternalUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Não foi possivel abrir a url:  $url');
    }
  }
}
