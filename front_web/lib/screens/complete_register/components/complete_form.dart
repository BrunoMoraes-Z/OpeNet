import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_storage/get_storage.dart';
import 'package:openet/components/back_login_line.dart';
import 'package:openet/components/default_button.dart';
import 'package:openet/screens/home/home_screen.dart';
import 'package:openet/utils/courses.dart';

class CompleteForm extends StatefulWidget {
  CompleteForm({Key key}) : super(key: key);

  @override
  _CompleteFormState createState() => _CompleteFormState();
}

class _CompleteFormState extends State<CompleteForm> {
  var storage = GetStorage('local').read('gcomplete');
  final _formKey = GlobalKey<FormState>();
  final RegExp emailValidatorRegExp =
      RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  bool _passwordVisible = false;
  bool _passwordVisible_2 = false;
  String email = '', password = '', password_2 = '';
  String curso = 'Administração';
  DateTime born;

  void selectDate(BuildContext context) async {
    DateTime picked = await showDatePicker(
      // locale: const Locale("pt_br", "PT_BR"),
      errorFormatText: 'Data inválida.',
      errorInvalidText:
          'Informe uma data anterior á 01/01/${DateTime.now().year - 15}',
      context: context,
      initialDate: DateTime(DateTime.now().year - 18),
      firstDate: DateTime(DateTime.now().year - 100),
      lastDate: DateTime(DateTime.now().year - 15),
      helpText: 'Date de Nascimento',
      cancelText: 'Cancelar',
      confirmText: 'Confirmar',
    );
    if (picked != null) {
      setState(() {
        born = picked;
      });
    }
  }

  String bornDateTextField(DateTime time) {
    if (time == null) {
      return '01/01/${DateTime.now().year - 18}';
    } else {
      return '${time.day < 10 ? '0' : ''}${time.day}/${time.month < 10 ? '0' : ''}${time.month}/${time.year}';
    }
  }

  void makeSession(String emailv, String passwordv) async {
    var uri = Uri.parse('http://127.0.0.1:3333/sessions');
    try {
      await http
          .post(
        uri,
        headers: {'Content-Type': 'application/json; charset=utf-8'},
        body: utf8.encode(
          json.encode({
            'email': emailv,
            'password': passwordv,
          }),
        ),
      )
          .then(
        (response) {
          var body = json.decode(response.body);
          if (response.statusCode == 200) {
            var st = GetStorage('local');
            st.write('token', body['token']);
            st.write('user', body['user']);
            setState(() {
              Navigator.pushNamed(
                context,
                HomeScreen.routeName,
              );
            });
            EasyLoading.dismiss();
            EasyLoading.showSuccess(
              'Login Efetuado',
              duration: Duration(seconds: 2),
            );
          } else {
            EasyLoading.showError(
              body['message'],
              duration: Duration(seconds: 3),
            );
          }
        },
      );
    } catch (_) {
      EasyLoading.showError(
        'Ouve um Erro ao tentar efetuar o login.',
        duration: Duration(seconds: 5),
      );
    }
    // EasyLoading.show();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BackLoginLine(),
          SizedBox(
            height: 20,
          ),
          Text(
            'Cadastre-se',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  enabled: true,
                  initialValue: storage['f_name'],
                  decoration: InputDecoration(
                    hintText: 'Nome',
                    prefixIcon: Icon(Icons.contact_page_rounded),
                  ),
                ),
              ),
              SizedBox(
                width: 15,
              ),
              Expanded(
                child: TextFormField(
                  enabled: true,
                  initialValue: storage['l_name'],
                  decoration: InputDecoration(
                    hintText: 'Sobre Nome',
                    prefixIcon: Icon(Icons.contact_page_rounded),
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 15,
          ),
          buildEmailFormFiled(),
          SizedBox(
            height: 15,
          ),
          Row(
            children: [
              Text(
                'Curso',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xff7E7E7E),
                ),
              ),
              SizedBox(
                width: 15,
              ),
              Expanded(
                flex: 2,
                child: DropdownButtonFormField(
                  value: curso,
                  onChanged: (value) {
                    setState(() {
                      curso = value;
                    });
                  },
                  dropdownColor: Color(0xFFCCCCCC),
                  items: periodos.keys.map((value) {
                    return DropdownMenuItem(
                      child: Text(value),
                      value: value,
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Container(
                width: 120,
                child: Text(
                  'Data De Nascimento',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xff7E7E7E),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  selectDate(context);
                },
                child: Container(
                  height: 50,
                  width: 120,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Color(0xFF7E7E7E),
                        width: 1,
                      ),
                    ),
                  ),
                  child: Text(
                    bornDateTextField(born),
                    style: TextStyle(
                      fontSize: 15,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(
                width: 15,
              ),
              Text(
                'Periodo',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xff7E7E7E),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                flex: 1,
                child: DropdownButtonFormField(
                  value: 1,
                  onChanged: (value) {
                    setState(() {});
                  },
                  dropdownColor: Color(0xFFCCCCCC),
                  items: periodos.entries
                      .firstWhere((element) => element.key == curso)
                      .value
                      .map((value) {
                    return DropdownMenuItem(
                      child: Text('$value'),
                      value: value,
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          buildFormPasswordField(),
          SizedBox(
            height: 15,
          ),
          buildFormConfirmPasswordField(),
          SizedBox(
            height: 65,
          ),
          DefaultButton(
            text: 'Cadastre-se',
            event: () {
              if (_formKey.currentState.validate()) {
                makeSession(email, password);
              }
            },
          )
        ],
      ),
    );
  }

  TextFormField buildEmailFormFiled() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      validator: (value) {
        value = value.trim();
        if (value.isEmpty || !emailValidatorRegExp.hasMatch(value)) {
          return 'Informe um Email válido.';
        } else {
          if (kIsWeb) {
            email = value;
          }
          return null;
        }
      },
      enabled: false,
      initialValue: storage['email'],
      decoration: InputDecoration(
        hintText: 'Email',
        prefixIcon: Icon(Icons.mail),
      ),
    );
  }

  TextFormField buildFormPasswordField() {
    return TextFormField(
      obscureText: !_passwordVisible,
      textInputAction: TextInputAction.done,
      onSaved: (value) => password = value,
      onChanged: (value) {
        value = value.trim();
        if (value.isEmpty || value.length < 6) {
          return 'Informe uma senha válida.';
        }
        return null;
      },
      validator: (value) {
        value = value.trim();
        if (value.isEmpty || value.length < 6) {
          return 'Informe uma senha válida.';
        }
        if (kIsWeb) {
          password = value;
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: 'Senha',
        prefixIcon: Icon(Icons.lock_outline),
        suffixIcon: IconButton(
          icon: Icon(
            _passwordVisible
                ? Icons.visibility_outlined
                : Icons.visibility_off_outlined,
          ),
          onPressed: () {
            setState(() {
              _passwordVisible = !_passwordVisible;
            });
          },
        ),
      ),
    );
  }

  TextFormField buildFormConfirmPasswordField() {
    return TextFormField(
      obscureText: !_passwordVisible_2,
      textInputAction: TextInputAction.done,
      onSaved: (value) => password_2 = value,
      onChanged: (value) {
        value = value.trim();
        if (value.isEmpty || value.length < 6) {
          return 'Informe uma senha válida.';
        }
        return null;
      },
      validator: (value) {
        value = value.trim();
        if (value.isEmpty || value.length < 6) {
          return 'Informe uma senha válida.';
        }
        if (kIsWeb) {
          password = value;
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: 'Confirmar Senha',
        prefixIcon: Icon(Icons.lock_outline),
        suffixIcon: IconButton(
          icon: Icon(
            _passwordVisible_2
                ? Icons.visibility_outlined
                : Icons.visibility_off_outlined,
          ),
          onPressed: () {
            setState(() {
              _passwordVisible_2 = !_passwordVisible_2;
            });
          },
        ),
      ),
    );
  }
}
