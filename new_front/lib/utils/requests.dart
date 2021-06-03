import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:openet/models/curso.dart';
import 'package:openet/screens/register/models/aluno.dart';
import 'package:openet/utils/my_toast.dart';

Future<List<Curso>> cursos() async {
  var uri = Uri.parse('http://127.0.0.1:3333/cursos');
  var response = await http.get(uri);
  List<Curso> cursos = [];
  var body = json.decode(response.body);
  for (int i = 0; i < body.length; i++) {
    cursos.add(Curso.fromJson(body[i]));
  }
  return cursos;
}

Future<http.Response> register(Aluno aluno) async {
  var uri = Uri.parse('http://127.0.0.1:3333/users');
  var response = await http.post(
    uri,
    headers: {'Content-Type': 'application/json; charset=utf-8'},
    body: utf8.encode(json.encode(aluno.toJson())),
  );
  return response;
}

Future<http.Response> login(dynamic content) async {
  var uri = Uri.parse('http://127.0.0.1:3333/sessions');
  var response = await http.post(
    uri,
    headers: {'Content-Type': 'application/json; charset=utf-8'},
    body: utf8.encode(json.encode({
      'email': content['email'],
      'password': content['password'],
    })),
  );
  return response;
}

Future<http.Response> has({required email}) async {
  var uri = Uri.parse('http://127.0.0.1:3333/users/has');
  var response = await http.get(uri, headers: {
    'Content-Type': 'application/json; charset=utf-8',
    'server-key': '135076f4-0890-45dc-b135-aaf63918b5b2',
    'email': email,
  });
  return response;
}

Future<http.Response> listPendingUsers() async {
  var uri = Uri.parse('http://127.0.0.1:3333/users/pending');
  var response = await http.get(uri);
  return response;
}

void acceptUser({id}) async {
  var uri = Uri.parse('http://127.0.0.1:3333/users/pending');
  var body = json.encode({'user_id': id});
  var response = await http.patch(uri,
      headers: {'Content-Type': 'application/json; charset=utf-8'},
      body: utf8.encode(body));
  if (response.statusCode == 200) {
    MyToast.showSucess('Usuário aprovado com sucesso.');
  } else {
    MyToast.showError('Ouve um erro ao tentar aprovar o cadastro.');
  }
}

void declineUser({id}) async {
  var uri = Uri.parse('http://127.0.0.1:3333/users/pending');
  var body = json.encode({'user_id': id});
  var response = await http.delete(uri,
      headers: {'Content-Type': 'application/json; charset=utf-8'},
      body: utf8.encode(body));
  if (response.statusCode == 200) {
    MyToast.showSucess('Usuário reprovado com sucesso.');
  } else {
    MyToast.showError('Ouve um erro ao tentar reprovar o cadastro.');
  }
}
