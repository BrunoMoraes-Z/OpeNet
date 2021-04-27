import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:openet/screens/home/home_screen.dart';
import 'package:openet/screens/login/login_screen.dart';

void createUser({
  BuildContext context,
  String first_name,
  String last_name,
  String user_name,
  String email,
  String password,
  String curso,
  String g_id,
  int periodo,
  int init_curso,
  DateTime born,
}) async {
  var uri = Uri.parse('http://127.0.0.1:3333/users');
  try {
    var body = json.encode({
      'first_name': first_name,
      'last_name': last_name,
      'user_name': user_name,
      'email': email,
      'password': password,
      'curso_id': curso,
      'periodo': periodo,
      'ano_curso': init_curso,
      'dt_nascimento': '${born.day}/${born.month}/${born.year}',
      'g_id': g_id != null ? g_id : ''
    });
    await http
        .post(
      uri,
      headers: {'Content-Type': 'application/json; charset=utf-8'},
      body: utf8.encode(body),
    )
        .then(
      (response) {
        var body = json.decode(response.body);
        if (response.statusCode == 404) {
          EasyLoading.showError(
            body['message'],
            duration: Duration(seconds: 5),
          );
        } else {
          EasyLoading.showSuccess(
            'Cadastro realizado com Sucesso.',
            duration: Duration(seconds: 5),
          );
          Navigator.pushNamed(context, LoginScreen.routeName);
        }
      },
    );
  } catch (_) {
    if (g_id != null) {
      EasyLoading.showError(
        'Verifique suas as informações.',
        duration: Duration(seconds: 5),
      );
    } else {
      EasyLoading.showError(
        'Ouve um Erro ao tentar efetuar o login.',
        duration: Duration(seconds: 5),
      );
    }
  }
  // EasyLoading.show();
}

void makeSession({
  BuildContext context,
  String email,
  String password,
}) async {
  var uri = Uri.parse('http://127.0.0.1:3333/sessions');
  try {
    await http
        .post(
      uri,
      headers: {'Content-Type': 'application/json; charset=utf-8'},
      body: utf8.encode(
        json.encode({
          'email': email,
          'password': password,
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
          Navigator.pushNamed(context, HomeScreen.routeName);
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

Future<bool> hasAccount(String email) async {
  var uri = Uri.parse('http://127.0.0.1:3333/users/has');
  try {
    var response = await http.get(uri, headers: {
      'Content-Type': 'application/json; charset=utf-8',
      'server-key': '135076f4-0890-45dc-b135-aaf63918b5b2',
      'email': email,
    });
    return response.statusCode == 200;
  } catch (_) {
    return false;
  }
}

Future<bool> makeGoogleSession(String email, String password) async {
  var uri = Uri.parse('http://127.0.0.1:3333/sessions');
  try {
    var response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json; charset=utf-8'},
      body: utf8.encode(json.encode({'email': email, 'password': password})),
    );
    var body = json.decode(response.body);
    if (response.statusCode == 200) {
      var st = GetStorage('local');
      st.write('token', body['token']);
      st.write('user', body['user']);
      return true;
    } else {
      return false;
    }
  } catch (_) {
    return false;
  }
}
