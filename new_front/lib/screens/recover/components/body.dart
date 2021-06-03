import 'package:flutter/material.dart';
import 'package:openet/components/background.dart';
import 'package:openet/components/default_button.dart';
import 'package:openet/components/logo.dart';
import 'package:openet/components/route_link.dart';
import 'package:openet/screens/login/login_screen.dart';
import 'package:openet/screens/recover/components/recover_form.dart';
import 'package:openet/screens/recover/controller/recover_controller.dart';
import 'package:openet/utils/my_toast.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    var controller = RecoverController();
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
                              RouteLink(
                                route: LoginScreen.routeName,
                                text: 'Voltar',
                              ),
                              SizedBox(
                                height: 120,
                              ),
                              RecoverForm(
                                controller: controller,
                              ),
                              SizedBox(
                                height: 120,
                              ),
                              DefaultButton(
                                text: 'Enviar',
                                backColor: Color(0xff2E9C4C),
                                press: () {
                                  if (controller.validate()) {
                                    MyToast.showSucess(
                                        'E-mail enviado com sucesso.');
                                    Navigator.pushNamed(
                                        context, LoginScreen.routeName);
                                  } else {
                                    MyToast.showError('E-mail inválido.');
                                  }
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
            Logo(
              imageSrc: 'recover_password.svg',
            ),
          ],
        ),
      ),
    );
  }
}
