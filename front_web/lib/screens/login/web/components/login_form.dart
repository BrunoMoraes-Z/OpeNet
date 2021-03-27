import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';
import 'package:openet/components/default_button.dart';
import 'package:openet/screens/complete_register/complete_register.dart';
import 'package:openet/screens/home/home_screen.dart';
import 'package:openet/screens/login/web/components/google.dart';
import 'package:openet/screens/recover/recover_screen.dart';
import 'package:openet/screens/registration/register_screen.dart';

class LoginForm extends StatefulWidget {
  LoginForm({Key key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final RegExp emailValidatorRegExp =
      RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  bool _passwordVisible = false;
  String email = '', password = '';

  void makeSession(String emailv, String passwordv) async {
    var uri = Uri.parse('http://127.0.0.1:3333/sessions');
    try {
      await http
          .post(
        uri,
        headers: {'Content-Type': 'application/json; charset=utf-8'},
        body: utf8.encode(
          json.encode({
            'email': emailv,
            'password': passwordv,
          }),
        ),
      )
          .then(
        (response) {
          var body = json.decode(response.body);
          if (response.statusCode == 200) {
            var st = GetStorage('local');
            st.write('token', body['token']);
            st.write('user', body['user']);
            setState(() {
              Navigator.pushNamed(
                context,
                HomeScreen.routeName,
              );
            });
            EasyLoading.dismiss();
            EasyLoading.showSuccess(
              'Login Realizado com Sucesso.',
              duration: Duration(seconds: 2),
            );
          } else {
            EasyLoading.showError(
              'Erro de Login. Tente Novamente.',
              // body['message'],
              duration: Duration(seconds: 3),
            );
          }
        },
      );
    } catch (_) {
      EasyLoading.showError(
        'Ouve um Erro ao tentar efetuar o login.',
        duration: Duration(seconds: 5),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'OpeNet',
            style: TextStyle(
              color: Color(0xff2a2a2a),
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 120,
          ),
          TextFormField(
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
                if (kIsWeb || Platform.isWindows) {
                  email = value;
                }
                return null;
              }
            },
            decoration: InputDecoration(
              hintText: 'Email',
              prefixIcon: Icon(Icons.mail),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          buildLoginFormPasswordField(),
          SizedBox(
            height: 5,
          ),
          BuildForgotAndRegisterComponents(),
          SizedBox(
            height: 60,
          ),
          DefaultButton(
            text: 'Entrar',
            event: () {
              if (_formKey.currentState.validate()) {
                makeSession(email, password);
              }
            },
          ),
          SizedBox(
            height: 5,
          ),
          DefaultButton(
            text: 'teste',
            event: () {
              var st = GetStorage('local');
              if (!st.hasData('gcomplete')) {
                st.write('gcomplete', {
                  'email': 'moraes.7@gmail.com',
                  'f_name': 'Bruno',
                  'l_name': 'Moraes'
                });
                print('salvo');
              }
              Navigator.pushNamed(context, CompleteRegister.routeName);
            },
          ),
          SizedBox(
            height: 5,
          ),
          kIsWeb ? GoogleSignInButton() : Container()
        ],
      ),
    );
  }

  TextFormField buildLoginFormPasswordField() {
    return TextFormField(
      obscureText: !_passwordVisible,
      textInputAction: TextInputAction.done,
      onSaved: (value) => password = value,
      onChanged: (value) {
        value = value.trim();
        if (value.isEmpty || value.length < 6) {
          return 'Informe uma senha válida.';
        }
        return null;
      },
      validator: (value) {
        value = value.trim();
        if (value.isEmpty || value.length < 6) {
          return 'Informe uma senha válida.';
        }
        if (kIsWeb || Platform.isWindows) {
          password = value;
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: 'Senha',
        prefixIcon: Icon(Icons.lock_outline),
        suffixIcon: IconButton(
          icon: Icon(
            _passwordVisible
                ? Icons.visibility_outlined
                : Icons.visibility_off_outlined,
          ),
          onPressed: () {
            setState(() {
              _passwordVisible = !_passwordVisible;
            });
          },
        ),
      ),
    );
  }
}

class BuildForgotAndRegisterComponents extends StatelessWidget {
  const BuildForgotAndRegisterComponents({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () => {
            Navigator.pushNamed(context, RecoverScreen.routeName),
          },
          child: Text(
            'Recuperar Senha',
            style: TextStyle(
              color: Colors.grey.shade700,
              fontSize: 12,
            ),
          ),
        ),
        GestureDetector(
          onTap: () => {
            Navigator.pushNamed(context, RegisterScreen.routeName),
          },
          child: Text(
            'Registrar',
            style: TextStyle(
              color: Colors.grey.shade700,
              fontSize: 12,
            ),
          ),
        )
      ],
    );
  }
}
