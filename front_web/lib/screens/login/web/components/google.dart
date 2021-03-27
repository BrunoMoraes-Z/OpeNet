import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:openet/components/default_button.dart';
import 'package:openet/screens/complete_register/complete_register.dart';
import 'package:openet/screens/home/home_screen.dart';

class GoogleSignInButton extends StatefulWidget {
  GoogleSignInButton({Key key}) : super(key: key);

  @override
  _GoogleSignInButtonState createState() => _GoogleSignInButtonState();
}

class _GoogleSignInButtonState extends State<GoogleSignInButton> {
  GoogleSignIn googleSignIn = GoogleSignIn(
    clientId:
        '79885564168-j8spfq8f9lco1231foupl3pc20u66m2o.apps.googleusercontent.com',
  );

  @override
  void initState() {
    checkSignInStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultButton(
      text: 'Entrar Com o Google',
      colors: [
        Color(0xFF2B70BE),
        Color(0xFF55A0F7),
      ],
      event: () {
        startSignIn();
      },
    );
  }

  void checkSignInStatus() async {
    var storage = GetStorage('local');
    if (storage.hasData('cancel_g')) {
      storage.remove('cancel_g');
      await googleSignIn.signOut();
      return;
    }
    await Future.delayed(Duration(seconds: 2));
    bool isSigned = await googleSignIn.isSignedIn();
    if (isSigned) {
      EasyLoading.showSuccess('Logado');
      // Navigator.pushNamed(context, HomeScreen.routeName);
    }
  }

  Future<bool> hasAccount(String email) async {
    return false;
  }

  void startSignIn() async {
    await googleSignIn.signOut();
    GoogleSignInAccount user = await googleSignIn.signIn();
    if (user == null) {
      EasyLoading.showError('Ouve um Erro ao tentar efetuar o login.',
          duration: Duration(seconds: 3));
    } else {
      bool has = await hasAccount(user.email);
      if (has) {
        Navigator.pushNamed(context, HomeScreen.routeName);
      } else {
        var st = GetStorage('local');
        if (!st.hasData('gcomplete')) {
          var splitted = user.displayName.split(' ');
          st.write('gcomplete', {
            'email': user.email,
            'f_name': splitted[0],
            'l_name': splitted.getRange(1, splitted.length)
          });
          print('salvo');
          Navigator.pushNamed(context, CompleteRegister.routeName);
        }
      }
    }
  }
}
