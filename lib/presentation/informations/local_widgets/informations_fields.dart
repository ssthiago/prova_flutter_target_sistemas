import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:prova_flutter_target_sistemas/core/strings_constants.dart';
import 'package:prova_flutter_target_sistemas/core/utils/validate.dart';
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

    return Observer(
      builder: (_) => Column(
        children: [
          TextFormField(
            controller: informationsStore.textFieldController,
            onSaved: (newValue) => informationsStore.text = newValue!,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              suffixIcon: GestureDetector(
                onTap: () => informationsStore.addInformation(),
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
          Observer(
            builder: (_) => Column(
              children: informationsStore.infoList.map((info) {
                return Card(
                  child: ListTile(
                    title: Text(info.text),
                    // Adicione botões de edição/exclusão conforme necessário
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            // Lógica para editar a informação
                            // Você pode exibir um modal de edição ou navegar para uma nova tela de edição
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            // Lógica para excluir a informação
                            // informationsStore.removeInformation(info);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
