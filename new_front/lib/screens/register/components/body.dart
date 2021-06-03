import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:openet/components/background.dart';
import 'package:openet/components/default_button.dart';
import 'package:openet/components/logo.dart';
import 'package:openet/components/route_link.dart';
import 'package:openet/screens/login/login_screen.dart';
import 'package:openet/screens/register/components/register_form.dart';
import 'package:openet/screens/register/controller/register_controller.dart';
import 'package:openet/utils/my_toast.dart';
import 'package:openet/utils/requests.dart';

class Body extends StatelessWidget {
  final controller = RegisterController();

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return BackGround(
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Logo(
              imageSrc: 'register_new_user.svg',
            ),
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
                                child: Observer(
                                  builder: (_) {
                                    return Container(
                                      child: SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            SizedBox(height: 15),
                                            Column(
                                              children: List.generate(
                                                controller.erros.length,
                                                (index) => Row(
                                                  children: [
                                                    SizedBox(width: 10),
                                                    Icon(
                                                      Icons.error,
                                                      size: 14,
                                                      color: Colors.redAccent,
                                                    ),
                                                    SizedBox(width: 5),
                                                    Text(
                                                      controller.erros[index],
                                                      style: TextStyle(
                                                        color: Colors.redAccent,
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              RegisterForm(
                                controller: controller,
                              ),
                              SizedBox(
                                height: 120,
                              ),
                              DefaultButton(
                                text: 'Completar',
                                backColor: Color(0xff2E9C4C),
                                press: () {
                                  if (controller.validate()) {
                                    register(controller.aluno).then((value) {
                                      var content = json.decode(value.body);
                                      if (value.statusCode != 200) {
                                        MyToast.showError(
                                            "${content['message']}");
                                      } else {
                                        print(content);
                                        MyToast.showSucess(
                                            "Conta criado com sucesso.");
                                        Navigator.popAndPushNamed(
                                            context, LoginScreen.routeName);
                                      }
                                    }).onError((error, stackTrace) {
                                      MyToast.showError(
                                          "Ouve um Erro ao tentar realizar o cadastro.");
                                    });
                                  } else {
                                    MyToast.showError(
                                        "Foram encontrados erros no formulário.");
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
          ],
        ),
      ),
    );
  }
}
