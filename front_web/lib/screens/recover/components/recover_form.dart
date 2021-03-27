import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:openet/components/back_login_line.dart';
import 'package:openet/components/default_button.dart';
import 'package:openet/screens/login/login_screen.dart';

class RecoverForm extends StatefulWidget {
  RecoverForm({Key key}) : super(key: key);

  @override
  _RecoverFormState createState() => _RecoverFormState();
}

class _RecoverFormState extends State<RecoverForm> {
  final _formKey = GlobalKey<FormState>();
  final RegExp emailValidatorRegExp =
      RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  String email = '', password = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BackLoginLine(),
            SizedBox(
              height: 20,
            ),
            Text(
              'Recuperar Senha',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            buildEmailFormFiled(),
            SizedBox(
              height: 120,
            ),
            // buildFormButton(),
            DefaultButton(
              text: 'Solicitar Nova Senha',
              event: () {
                if (_formKey.currentState.validate()) {
                  EasyLoading.showSuccess(
                    // 'E-mail para recuperação de senha enviado com sucesso.',
                    'Se o email estiver em nosso cadastro\n você receberá uma nova senha.',
                    duration: Duration(seconds: 4),
                  );
                  Navigator.pushNamed(context, LoginScreen.routeName);
                }
              },
            )
          ],
        ),
      ),
    );
  }

  TextFormField buildEmailFormFiled() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      onSaved: (value) => email = value,
      onChanged: (value) {
        value = value.trim();
        if (value.isEmpty || !emailValidatorRegExp.hasMatch(value)) {
          return 'Informe um Email válido.';
        } else {
          return null;
        }
      },
      validator: (value) {
        value = value.trim();
        if (value.isEmpty || !emailValidatorRegExp.hasMatch(value)) {
          return 'Informe um Email válido.';
        } else {
          if (kIsWeb) {
            email = value;
          }
          return null;
        }
      },
      decoration: InputDecoration(
        hintText: 'Email',
        prefixIcon: Icon(Icons.mail),
      ),
    );
  }
}
