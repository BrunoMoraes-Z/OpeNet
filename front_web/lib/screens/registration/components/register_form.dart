import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:openet/components/back_login_line.dart';
import 'package:openet/components/default_button.dart';
import 'package:openet/utils/courses.dart';
import 'package:openet/utils/requests.dart';

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
  bool _passwordVisible_2 = false;
  String email = '', password = '', password_2 = '';
  String curso = 'Administração';
  String f_name = '', l_name = '';
  int periodo = 1;
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
      return '00/00/0000';
    } else {
      return '${time.day < 10 ? '0' : ''}${time.day}/${time.month < 10 ? '0' : ''}${time.month}/${time.year}';
    }
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
                  validator: (value) {
                    value = value.trim();
                    if (value.isEmpty) {
                      return 'Informe um Nome válido';
                    }
                    setState(() {
                      f_name = value;
                    });
                    return null;
                  },
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
                  validator: (value) {
                    value = value.trim();
                    if (value.isEmpty) {
                      return 'Informe um Sobre Nome válido';
                    }
                    setState(() {
                      l_name = value;
                    });
                    return null;
                  },
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
                    setState(() {
                      periodo = value;
                    });
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
                createUser(
                    context: context,
                    first_name: f_name,
                    last_name: l_name,
                    born: born,
                    curso: curso,
                    email: email,
                    password: password,
                    periodo: periodo);
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
        if (kIsWeb) {
          password_2 = value;
        }
        if (value.isEmpty || value.length < 6) {
          return 'Informe uma senha válida.';
        } else {
          if (password_2 != password) {
            return 'As senhas não estão iguais.';
          }
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
