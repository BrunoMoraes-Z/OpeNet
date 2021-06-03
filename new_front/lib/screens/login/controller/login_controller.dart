import 'package:mobx/mobx.dart';
import 'package:openet/screens/login/models/aluno.dart';
part 'login_controller.g.dart';

class LoginController = _LoginControllerBase with _$LoginController;

abstract class _LoginControllerBase with Store {
  var aluno = Aluno();

  String validate() {
    if (aluno.email.trim().isEmpty || aluno.email.trim().length < 3) {
      return "Informe um nome de usuário valido.";
    }
    if (aluno.password.trim().isEmpty || aluno.password.trim().length < 6) {
      return "Informe uma senha valida.";
    }

    return '';
  }
}
