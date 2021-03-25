import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';
import 'package:openet/screens/home/home_screen.dart';
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
              'Login Efetuado',
              duration: Duration(seconds: 2),
            );
          } else {
            EasyLoading.showError(
              body['message'],
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
    // EasyLoading.show();
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
          buildLoginFormButton(),
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
        if (kIsWeb) {
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

  GestureDetector buildLoginFormButton() {
    return GestureDetector(
      onTap: () {
        if (_formKey.currentState.validate()) {
          makeSession(email, password);
        }
      },
      child: Container(
        height: 45,
        width: 160,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.25),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3),
            )
          ],
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Color(0xff28a745),
              Color(0xff20c997),
            ],
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        child: Text(
          'Entrar',
          style: TextStyle(
            fontSize: 20,
          ),
          textAlign: TextAlign.center,
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
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        //
        // TO DO ?
        //
        // GestureDetector(
        //   onTap: () => {
        //     print('Esqueci'),
        //   },
        //   child: Text(
        //     'Esqueci Minha Senha',
        //     style: TextStyle(
        //       color: Colors.grey.shade700,
        //       fontSize: 12,
        //     ),
        //   ),
        // ),
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
