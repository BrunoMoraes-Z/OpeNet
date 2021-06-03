import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:openet/components/background.dart';
import 'package:openet/components/default_button.dart';
import 'package:openet/components/logo.dart';
import 'package:openet/screens/home/home_screen.dart';
import 'package:openet/screens/login/components/login_form.dart';
import 'package:openet/screens/login/controller/login_controller.dart';
import 'package:openet/screens/recover/recover_screen.dart';
import 'package:openet/screens/register/register_screen.dart';
import 'package:openet/utils/google.dart';
import 'package:openet/utils/my_toast.dart';
import 'package:openet/utils/requests.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    var controller = LoginController();
    return BackGround(
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 100),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      child: Container(
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Text(
                                'OpeNet',
                                style: TextStyle(
                                  fontFamily: GoogleFonts.roboto().fontFamily,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 32,
                                ),
                              ),
                              SizedBox(
                                height: 140,
                              ),
                              LoginForm(
                                controller: controller,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextButton(
                                    child: Text('Esqueci minha senha'),
                                    onPressed: () {
                                      Navigator.pushNamed(
                                          context, RecoverScreen.routeName);
                                    },
                                  ),
                                  TextButton(
                                    child: Text('Registrar'),
                                    onPressed: () {
                                      Navigator.pushNamed(
                                          context, RegisterScreen.routeName);
                                    },
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 120,
                              ),
                              DefaultButton(
                                text: 'Entrar',
                                backColor: Color(0xff2E9C4C),
                                press: () {
                                  var message = controller.validate();
                                  if (message.length == 0) {
                                    login(controller.aluno.toJson())
                                        .then((value) {
                                      var content = json.decode(value.body);
                                      if (value.statusCode != 200) {
                                        MyToast.showError(content['message']);
                                      } else {
                                        if (content['user']['admin']) {
                                          GetStorage('local').write('admin', 1);
                                        } else {
                                          GetStorage('local').remove('admin');
                                        }
                                        MyToast.showSucess(
                                            'Login realizado com sucesso.');
                                        Navigator.pushNamed(
                                            context, HomeScreen.routeName);
                                      }
                                    });
                                  } else {
                                    MyToast.showError(message);
                                  }
                                },
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              DefaultButton(
                                text: 'Entrar com o Google',
                                backColor: Color(0xFF3BA7E6),
                                press: () {
                                  Google().startSignIn(context);
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Logo(imageSrc: 'logo_web.svg'),
          ],
        ),
      ),
    );
  }
}
