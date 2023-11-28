import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:prova_flutter_target_sistemas/core/strings_constants.dart';
import 'package:prova_flutter_target_sistemas/core/utils/validate.dart';
import 'package:prova_flutter_target_sistemas/domian/entities/information.dart';
import 'package:prova_flutter_target_sistemas/presentation/common_widgets/bottom_sheet/bottom_sheet_widget.dart';
import 'package:prova_flutter_target_sistemas/presentation/common_widgets/rounded_button.dart';
import 'package:prova_flutter_target_sistemas/presentation/informations/informations_store.dart';

class InformationsFields extends StatelessWidget {
  const InformationsFields({
    Key? key,
    required this.context,
  }) : super(key: key);

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    final InformationsStore informationsStore = GetIt.I.get<InformationsStore>();
    // Mova a definição do FocusNode para o escopo do widget
    final FocusNode textFormFieldFocus = FocusNode();
    return FutureBuilder(
        future: informationsStore.inicializeInformations,
        builder: (context, snapshot) {
          return Observer(
            builder: (_) => Form(
              key: informationsStore.formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    focusNode: textFormFieldFocus,
                    controller: informationsStore.textFieldController,
                    onSaved: (newValue) => informationsStore.text = newValue!,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      suffixIcon: GestureDetector(
                        onTap: () {
                          informationsStore.addInformation();
                          FocusScope.of(context).requestFocus(textFormFieldFocus);
                        },
                        child: const Icon(
                          Icons.send,
                        ),
                      ),
                      labelText: StringsConstants.digiteSeuTexto,
                    ),
                    validator: (value) =>
                        Validate.textInformacao(value!, label: StringsConstants.informacao),
                  ),
                  const SizedBox(height: 16.0),
                  SingleChildScrollView(
                    physics: const ScrollPhysics(),
                    child: ListView.builder(
                      itemCount: informationsStore.informationList.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => Card(
                        child: ListTile(
                          title: Text(informationsStore.informationList[index].text),
                          // Adicione botões de edição/exclusão conforme necessário
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () {
                                  Information oldInformation =
                                      informationsStore.informationList[index];
                                  informationsStore.editTextFieldController.text =
                                      oldInformation.text;
                                  // Abre um AlertDialog para edição
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text(StringsConstants.editarInformacoes),
                                        content: TextField(
                                          controller: informationsStore.editTextFieldController,
                                          decoration: const InputDecoration(
                                              labelText: StringsConstants.novoTexto),
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              // Cancela a edição e fecha o AlertDialog
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text(StringsConstants.cancelar),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              // Salva a edição e fecha o AlertDialog
                                              informationsStore.editInformation(
                                                oldInformation,
                                                Information(
                                                  text: informationsStore
                                                      .editTextFieldController.text,
                                                ),
                                              );
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text(StringsConstants.salvar),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  // Abre um AlertDialog para confirmar a exclusão
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text(StringsConstants.confirmarExclusao),
                                        content: const Text(StringsConstants.certezaDesejaExcluir),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              // Cancela a exclusão e fecha o AlertDialog
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text(StringsConstants.cancelar),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              // Confirma a exclusão e fecha o AlertDialog
                                              informationsStore.removeInformation(
                                                  informationsStore.informationList[index], index);
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text(StringsConstants.confirmar),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 60.0),
                ],
              ),
            ),
          );
        });
  }
}
