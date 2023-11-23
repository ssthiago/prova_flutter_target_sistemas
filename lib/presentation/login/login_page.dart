import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prova_flutter_target_sistemas/core/strings_constants.dart';
import 'package:prova_flutter_target_sistemas/core/utils/validate.dart';
import 'package:prova_flutter_target_sistemas/presentation/common_widgets/rounded_button.dart';
import 'package:prova_flutter_target_sistemas/presentation/login/login_store.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LoginStore _loginStore = GetIt.I.get<LoginStore>();
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(),
        body: Stack(
          children: [
            Center(
              child: SingleChildScrollView(
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Login',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 30,
                        fontFamily: GoogleFonts.robotoFlex().fontFamily,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 15),
                    buildFields(context),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: const EdgeInsets.only(bottom: 20),
                child: GestureDetector(
                  onTap: () => _loginStore.openExternalUrl(StringsConstants.urlPoliticaPrivacidade),
                  child: const Text(
                    StringsConstants.politicaPrivacidade,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildFields(BuildContext context) {
    final LoginStore _loginStore = GetIt.I.get<LoginStore>();

    return Observer(
      builder: (_) => Form(
        key: _loginStore.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            TextFormField(
              controller: _loginStore.usernameFieldController,
              onSaved: (newValue) => _loginStore.username = newValue!,
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
              controller: _loginStore.passwordFieldController,
              onSaved: (newValue) => _loginStore.password = newValue!,
              validator: (value) => Validate.password(value!, label: StringsConstants.senha),
              obscureText: _loginStore.isPasswordObscure,
              decoration: InputDecoration(
                labelText: StringsConstants.senha,
                suffixIcon: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () => _loginStore.togglePasswordObscure(),
                      child: Icon(
                        _loginStore.isPasswordObscure ? Icons.visibility_off : Icons.visibility,
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
                onPress: () => _loginStore.login(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
