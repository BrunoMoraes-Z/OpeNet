import 'package:mobx/mobx.dart';

class RecoverController {
  var email = Observable<String>('');

  bool validate() {
    final RegExp validator = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (email.value.length > 0 && validator.hasMatch(email.value)) {
      return true;
    }
    return false;
  }
}
