import 'package:mobx/mobx.dart';
part 'aluno.g.dart';

class Aluno = _AlunoBase with _$Aluno;

abstract class _AlunoBase with Store {
  @observable
  String name = '';
  @action
  setName(String value) => name = value;

  @observable
  String lastName = '';
  @action
  setLastName(String value) => lastName = value;

  @observable
  String userName = '';
  @action
  setUserName(String value) => userName = value;

  @observable
  String email = '';
  @action
  setEmail(String value) => email = value;

  @observable
  String password = '';
  @action
  setPassword(String value) => password = value;

  @observable
  String confirmPassword = '';
  @action
  setConfirmPassword(String value) => confirmPassword = value;

  @observable
  String idCurso = '';
  @action
  setIdCurso(String value) => idCurso = value;

  @observable
  String googleId = '';
  @action
  setIdGoogle(String value) => googleId = value;

  @observable
  int anoStart = DateTime.now().year;
  @action
  setAnoStart(String value) {}

  @observable
  int periodo = 1;
  @action
  setPeriodo(String value) {}

  @observable
  DateTime born = DateTime.now();
  @action
  setBorn(String value) {
    if (value.length == 10) {
      var splits = value.split('/');
      born = DateTime.parse('${splits[2]}${splits[1]}${splits[0]}');
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = name;
    data['last_name'] = lastName;
    data['user_name'] = userName;
    data['email'] = email;
    data['password'] = '$password';
    data['curso_id'] = idCurso;
    data['periodo'] = periodo;
    data['ano_curso'] = anoStart;
    data['dt_nascimento'] =
        '${born.day}/${born.month < 10 ? "0" : ""}${born.month}/${born.year}';
    data['g_id'] = googleId;
    return data;
  }
}
