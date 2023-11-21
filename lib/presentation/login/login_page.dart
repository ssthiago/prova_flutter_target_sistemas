import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prova_flutter_target_sistemas/presentation/common_widgets/rounded_button.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                    //TODO testar widget Gap()
                    const SizedBox(height: 15),
                    buildFields(),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: const EdgeInsets.only(bottom: 20),
                child: const Text(
                  'Política de privacidade',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildFields() {
    return Form(
      //key: controller.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          TextFormField(
            //controller: controller.emailFieldController,
            //onSaved: (newValue) => controller.email = newValue,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              suffixIcon: Icon(
                Icons.person_2_outlined,
              ),
              labelText: 'email',
            ),
            //validator: (value) => Validate.email(value!, label: email),
          ),
          const SizedBox(height: 10),
          TextFormField(
            //controller: controller.passwordFieldController,
            //onSaved: (newValue) => controller.password = newValue,
            //onChanged: controller.onPasswordChanged,
            //validator: (value) => Validate.password(value!, label: senha),
            //obscureText: controller.isPasswordObscure,
            decoration: InputDecoration(
              labelText: 'senha',
              suffixIcon: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    //onTap: () => controller.togglePasswordHidden(),
                    child: const Icon(
                      //controller.isPasswordObscure ? Icons.visibility_off : Icons.visibility,
                      Icons.visibility,
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
              onPress: () {},
/*
              enabled: (!controller.loginState.isLoading),
              isLoading: (controller.loginState.isLoading),
              text: login,
              onPress: () => controller.login(),
*/
            ),
          ),
        ],
      ),
    );
  }
}
