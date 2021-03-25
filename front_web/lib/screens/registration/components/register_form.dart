import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';
import 'package:openet/components/courses.dart';
import 'package:openet/screens/home/home_screen.dart';
import 'package:openet/screens/login/login_screen.dart';

class RegisterForm extends StatefulWidget {
  RegisterForm({Key key}) : super(key: key);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final RegExp emailValidatorRegExp =
      RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  bool _passwordVisible = false;
  String email = '', password = '';
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
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                icon: Icon(Icons.keyboard_arrow_left),
                onPressed: () {
                  Navigator.pushNamed(context, LoginScreen.routeName);
                },
              ),
              Text(
                'Voltar para Login',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
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
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
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
                  items: cources.map((value) {
                    return DropdownMenuItem(
                      child: Text(value),
                      value: value,
                    );
                  }).toList(),
                ),
              ),
              SizedBox(
                width: 15,
              ),
              Expanded(
                flex: 1,
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Período',
                    prefixIcon: Icon(Icons.format_list_numbered),
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  'Data De Nascimento',
                  style: TextStyle(fontSize: 16, color: Color(0xff7f7f82)),
                ),
              ),
              GestureDetector(
                onTap: () {
                  selectDate(context);
                },
                child: Container(
                  height: 45,
                  width: 120,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Color(0xffc3c3c7),
                        width: 2,
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
              )
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
          buildFormButton(),
        ],
      ),
    );
  }

  TextFormField buildEmailFormFiled() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      onSaved: (value) => email = value,
      onChanged: (value) {
        value = value.trim();
        if (value.isEmpty || !emailValidatorRegExp.hasMatch(value)) {
          return 'Informe um Email válido.';
        } else {
          return null;
        }
      },
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
        hintText: 'Confirmar Senha',
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

  GestureDetector buildFormButton() {
    return GestureDetector(
      onTap: () {
        if (_formKey.currentState.validate()) {
          makeSession(email, password);
        }
      },
      child: Container(
        height: 45,
        width: 180,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.25),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3),
            )
          ],
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Color(0xff28a745),
              Color(0xff20c997),
            ],
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        child: Text(
          'Cadastre-se',
          style: TextStyle(
            fontSize: 20,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
