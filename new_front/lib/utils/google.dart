import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:openet/screens/home/home_screen.dart';
import 'package:openet/screens/register/register_screen.dart';
import 'package:openet/utils/my_toast.dart';
import 'package:openet/utils/requests.dart';

class Google {
  var _google = GoogleSignIn(
    clientId:
        '79885564168-j8spfq8f9lco1231foupl3pc20u66m2o.apps.googleusercontent.com',
  );

  void logout() async {
    await _google.signOut();
  }

  void startSignIn(BuildContext context) async {
    logout();
    try {
      GoogleSignInAccount? user = await _google.signIn();
      if (user == null) {
        MyToast.showError('Ouve um erro ao tentar efetuar login.');
      } else {
        login({'email': user.email, 'password': user.id}).then((value) {
          var content = json.decode(value.body);
          if (value.statusCode != 200 &&
              content['message'] != 'Cadastro ainda pendente.') {
            var st = GetStorage('local');
            st.write('g_user', {
              'email': user.email,
              'first_name': user.displayName!.split(" ")[0],
              'last_name': user.displayName!.split(" ")[1],
            });
            st.write('g_id', user.id);
            Navigator.pushNamed(context, RegisterScreen.routeName);
          } else if (value.statusCode != 200) {
            MyToast.showError(content['message']);
          }
          if (value.statusCode == 200) {
            if (content['user']['admin']) {
              GetStorage('local').write('admin', 1);
            } else {
              GetStorage('local').remove('admin');
            }
          }
          MyToast.showSucess('Login realizado com sucesso.');
          Navigator.pushNamed(context, HomeScreen.routeName);
        });
      }
    } catch (_) {}
  }
}
