import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:openet/components/input_form_text.dart';
import 'package:openet/screens/login/controller/login_controller.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({required this.controller});

  final LoginController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          InputTextField(
            hint: 'Usuário ou E-mail',
            icon: LineIcons.user,
            inputAction: TextInputAction.next,
            onChanged: controller.aluno.setEmail,
          ),
          SizedBox(
            height: 25,
          ),
          InputTextField(
            hint: 'Senha',
            icon: LineIcons.lock,
            obscure: true,
            onChanged: controller.aluno.setPassword,
          ),
          SizedBox(
            height: 2,
          )
        ],
      ),
    );
  }
}
