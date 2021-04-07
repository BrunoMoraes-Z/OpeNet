import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:openet/components/default_button.dart';
import 'package:openet/screens/login/web/components/google.dart';
import 'package:openet/screens/recover/recover_screen.dart';
import 'package:openet/screens/registration/register_screen.dart';
import 'package:openet/utils/requests.dart';

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
                makeSession(
                  context: context,
                  email: email,
                  password: password,
                );
              }
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
            'Cadastrar Novo Usuário',
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
