import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:prova_flutter_target_sistemas/core/strings_constants.dart';
import 'package:prova_flutter_target_sistemas/core/utils/validate.dart';
import 'package:prova_flutter_target_sistemas/presentation/common_widgets/bottom_sheet/bottom_sheet_widget.dart';
import 'package:prova_flutter_target_sistemas/presentation/common_widgets/rounded_button.dart';
import 'package:prova_flutter_target_sistemas/presentation/informations/informations_store.dart';
import 'package:prova_flutter_target_sistemas/presentation/login/login_store.dart';

class InformationsFields extends StatelessWidget {
  const InformationsFields({
    super.key,
    required this.context,
  });

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    final InformationsStore informationsStore = GetIt.I.get<InformationsStore>();

    return Observer(
      builder: (_) => Form(
        key: informationsStore.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            TextFormField(
              controller: informationsStore.textFieldController,
              onSaved: (newValue) => informationsStore.text = newValue!,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                suffixIcon: GestureDetector(
                  onTap: () => print('Salvou uma nova nova informação'),
                  child: const Icon(
                    Icons.send,
                  ),
                ),
                labelText: StringsConstants.digiteSeuTexto,
              ),
              validator: (value) =>
                  Validate.textInformacao(value!, label: StringsConstants.informacao),
            ),
          ],
        ),
      ),
    );
  }
}
