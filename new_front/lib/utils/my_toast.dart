import 'package:fluttertoast/fluttertoast.dart';

class MyToast {
  static void showSucess(String message) {
    _show(message, false);
  }

  static void showError(String message) {
    _show(message, true);
  }

  static void _show(String message, bool error) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP,
      webBgColor: error ? '#d44646' : '#46d467',
      timeInSecForIosWeb: 5,
    );
  }
}
