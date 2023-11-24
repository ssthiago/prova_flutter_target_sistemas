import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobx/mobx.dart';
import 'package:url_launcher/url_launcher.dart';

part 'informations_store.g.dart';

class InformationsStore = InformationsStoreBase with _$InformationsStore;

abstract class InformationsStoreBase with Store {
  InformationsStoreBase();

  @observable
  String text = '';

  TextEditingController textFieldController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @action
  void setText(String value) => text = value;

  void _goToInformationPage(BuildContext context) => GoRouter.of(context).go('/informations');

  Future<void> openExternalUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Não foi possivel abrir a url:  $url');
    }
  }
}
