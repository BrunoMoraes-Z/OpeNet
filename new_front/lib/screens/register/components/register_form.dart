import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_storage/get_storage.dart';
import 'package:line_icons/line_icons.dart';
import 'package:openet/components/date_text_input_formatter.dart';
import 'package:openet/components/input_form_text.dart';
import 'package:openet/models/curso.dart';
import 'package:openet/screens/register/controller/register_controller.dart';
import 'package:openet/utils/requests.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({required this.controller});

  final RegisterController controller;

  @override
  Widget build(BuildContext context) {
    var st = GetStorage('local');
    if (st.hasData('g_user')) {
      var content = st.read('g_user');
      controller.aluno.setName(content['first_name']);
      controller.aluno.setLastName(content['last_name']);
      controller.aluno.setEmail(content['email']);
      st.remove('g_user');
      controller.aluno.setIdGoogle(st.read('g_id'));
      st.remove('g_id');
    }
    cursos().then((value) {
      controller.cursos.addAll(value);
      controller.aluno.setIdCurso(controller.cursos[0].id);
    });
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: st.hasData('g_id')
                    ? Observer(
                        builder: (_) {
                          return InputTextField(
                            hint: 'Nome',
                            icon: LineIcons.userCircle,
                            content: controller.aluno.name,
                            inputAction: TextInputAction.next,
                            onChanged: controller.aluno.setName,
                          );
                        },
                      )
                    : InputTextField(
                        hint: 'Nome',
                        icon: LineIcons.userCircle,
                        inputAction: TextInputAction.next,
                        onChanged: controller.aluno.setName,
                      ),
              ),
              SizedBox(width: 10),
              Flexible(
                child: st.hasData('g_id')
                    ? Observer(
                        builder: (_) {
                          return InputTextField(
                            hint: 'Sobre Nome',
                            icon: LineIcons.userCircle,
                            content: controller.aluno.lastName,
                            inputAction: TextInputAction.next,
                            onChanged: controller.aluno.setLastName,
                          );
                        },
                      )
                    : InputTextField(
                        hint: 'Sobre Nome',
                        icon: LineIcons.userCircle,
                        inputAction: TextInputAction.next,
                        onChanged: controller.aluno.setLastName,
                      ),
              ),
            ],
          ),
          SizedBox(width: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: InputTextField(
                  hint: 'Usuário',
                  icon: LineIcons.userTag,
                  inputAction: TextInputAction.next,
                  onChanged: controller.aluno.setUserName,
                ),
              ),
              SizedBox(width: 10),
              Flexible(
                child: InputTextField(
                  hint: 'Data de Nascimento',
                  icon: LineIcons.calendar,
                  inputAction: TextInputAction.next,
                  onChanged: controller.aluno.setBorn,
                  formatters: [DateTextFormatter()],
                ),
              ),
            ],
          ),
          SizedBox(width: 5),
          st.hasData('g_id')
              ? Observer(
                  builder: (_) {
                    return InputTextField(
                      hint: 'Email',
                      icon: LineIcons.mailBulk,
                      content: controller.aluno.email,
                      inputAction: TextInputAction.next,
                      onChanged: controller.aluno.setEmail,
                    );
                  },
                )
              : InputTextField(
                  hint: 'Email',
                  icon: LineIcons.mailBulk,
                  inputAction: TextInputAction.next,
                  onChanged: controller.aluno.setEmail,
                ),
          SizedBox(width: 5),
          Row(
            children: [
              Icon(
                LineIcons.university,
                color: Color(0xff848487),
              ),
              SizedBox(width: 15),
              FutureBuilder(
                future: cursos(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<Curso>> snapshot) {
                  Widget wid = Text('Curso');
                  if (snapshot.hasData) {
                    wid = Observer(builder: (_) {
                      return DropdownButton(
                        hint: Text('Curso'),
                        value: controller.aluno.idCurso.length > 1
                            ? controller.aluno.idCurso
                            : snapshot.data![0].id,
                        onChanged: (value) {
                          controller.aluno.setIdCurso(value.toString());
                        },
                        items: snapshot.data!.map(
                          (e) {
                            return DropdownMenuItem(
                              child: Text(e.name),
                              value: e.id,
                            );
                          },
                        ).toList(),
                      );
                    });
                  }
                  return wid;
                },
              ),
            ],
          ),
          SizedBox(width: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: InputTextField(
                  hint: 'Período',
                  icon: LineIcons.listOl,
                  onChanged: controller.aluno.setPeriodo,
                ),
              ),
              SizedBox(width: 10),
              Flexible(
                child: InputTextField(
                  hint: 'Ano de Ínicio',
                  icon: LineIcons.listOl,
                  onChanged: controller.aluno.setAnoStart,
                ),
              ),
            ],
          ),
          SizedBox(width: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: InputTextField(
                  hint: 'Senha',
                  icon: LineIcons.lock,
                  inputAction: TextInputAction.next,
                  obscure: true,
                  onChanged: controller.aluno.setPassword,
                ),
              ),
              SizedBox(width: 10),
              Flexible(
                child: InputTextField(
                  hint: 'Confirmar Senha',
                  icon: LineIcons.lock,
                  obscure: true,
                  onChanged: controller.aluno.setConfirmPassword,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
