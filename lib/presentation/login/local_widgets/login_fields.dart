import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:prova_flutter_target_sistemas/core/strings_constants.dart';
import 'package:prova_flutter_target_sistemas/core/utils/validate.dart';
import 'package:prova_flutter_target_sistemas/presentation/common_widgets/bottom_sheet/bottom_sheet_widget.dart';
import 'package:prova_flutter_target_sistemas/presentation/common_widgets/rounded_button.dart';
import 'package:prova_flutter_target_sistemas/presentation/login/login_store.dart';

class LoginFields extends StatelessWidget {
  const LoginFields({
    super.key,
    required this.context,
  });

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    final LoginStore loginStore = GetIt.I.get<LoginStore>();

    return Observer(
      builder: (_) => Form(
        key: loginStore.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            TextFormField(
              controller: loginStore.usernameFieldController,
              onSaved: (newValue) => loginStore.username = newValue!,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                suffixIcon: Icon(
                  Icons.person_2_outlined,
                ),
                labelText: StringsConstants.nomeUsuario,
              ),
              validator: (value) => Validate.username(value!, label: StringsConstants.nomeUsuario),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: loginStore.passwordFieldController,
              onSaved: (newValue) => loginStore.password = newValue!,
              validator: (value) => Validate.password(value!, label: StringsConstants.senha),
              obscureText: loginStore.isPasswordObscure,
              decoration: InputDecoration(
                labelText: StringsConstants.senha,
                suffixIcon: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () => loginStore.togglePasswordObscure(),
                      child: Icon(
                        loginStore.isPasswordObscure ? Icons.visibility_off : Icons.visibility,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Icon(
                      Icons.lock_outline_rounded,
                    ),
                    const SizedBox(width: 10),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 50),
            SizedBox(
              width: double.infinity,
              child: RoundedButton(
                enabled: true,
                isLoading: false,
                text: 'login',
                onPress: () {
                  loginStore.login(context).then((value) {
                    if (loginStore.bottomSheetStore.isBottomSheetVisible) {
                      showCustomBottomSheet(context);
                    }
                  });

                  //loginStore.showCustomBottomSheet();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
