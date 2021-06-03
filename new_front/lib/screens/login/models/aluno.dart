import 'package:mobx/mobx.dart';
part 'aluno.g.dart';

class Aluno = _AlunoBase with _$Aluno;

abstract class _AlunoBase with Store {
  @observable
  String email = '';
  @action
  setEmail(value) => email = value;

  @observable
  String password = '';
  @action
  setPassword(value) => password = value;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = email;
    data['password'] = '$password';
    return data;
  }
}
