import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_storage/get_storage.dart';
import 'package:openet/utils/size_config.dart';

class BodyWeb extends StatelessWidget {
  const BodyWeb({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: SizeConfig.screenWidth,
        color: Color(0xfff0f0f5),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Row(
              children: [
                Container(
                  width: constraints.maxWidth / 2,
                  height: constraints.maxHeight,
                  child: Padding(
                    padding: EdgeInsets.only(left: 140, right: 140),
                    child: LoginForm(),
                  ),
                ),
                Container(
                  width: constraints.maxWidth / 2,
                  height: constraints.maxHeight,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 50),
                        child: SvgPicture.asset(
                          '/logo_web.svg',
                          width: (constraints.maxWidth / 2) - 100,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

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

  void makeSession(String email, String password) async {
    if (email.trim().length > 0 && password.trim().length > 0) {
      var uri = Uri.parse('http://127.0.0.1:3333/sessions');
      var response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json; charset=utf-8'},
        body: utf8.encode(
          json.encode({
            'email': email,
            'password': password,
          }),
        ),
      );
      print(response.body);
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
          print('VALIDO');
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
