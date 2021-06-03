import 'package:mobx/mobx.dart';
import 'package:openet/models/curso.dart';
import 'package:openet/screens/register/models/aluno.dart';
import 'package:openet/utils/errors_list.dart';
part 'register_controller.g.dart';

class RegisterController = _RegisterControllerBase with _$RegisterController;

abstract class _RegisterControllerBase with Store {
  var aluno = Aluno();

  @computed
  bool get isValid {
    return erros.length == 0;
  }

  @observable
  late ObservableList<String> erros = ObservableList<String>();
  @observable
  late ObservableList<Curso> cursos = ObservableList<Curso>();
  @action
  void _updateError(String error, bool status) {
    if (status && !erros.contains(error)) {
      erros.add(error);
    } else if (!status) {
      erros.remove(error);
    }
  }

  @action
  bool validate() {
    _updateError(errorTypes['invalid_name']!, aluno.name.trim().length < 3);
    _updateError(
        errorTypes['invalid_last_name']!, aluno.lastName.trim().length < 3);
    _updateError(
        errorTypes['invalid_user_name']!, aluno.userName.trim().length < 4);
    _updateError(
      errorTypes['invalid_born']!,
      !aluno.born.isBefore(DateTime.now()) &&
          ((DateTime.now().year - aluno.born.year) > 17),
    );
    _updateError(
      errorTypes['invalid_mail']!,
      !RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+').hasMatch(aluno.email),
    );
    _updateError(
        errorTypes['invalid_password']!, aluno.password.trim().length < 6);
    _updateError(
      errorTypes['invalid_passwords']!,
      aluno.password.trim() != aluno.confirmPassword.trim(),
    );

    return isValid;
  }
}
