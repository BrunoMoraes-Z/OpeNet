// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'aluno.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$Aluno on _AlunoBase, Store {
  final _$emailAtom = Atom(name: '_AlunoBase.email');

  @override
  String get email {
    _$emailAtom.reportRead();
    return super.email;
  }

  @override
  set email(String value) {
    _$emailAtom.reportWrite(value, super.email, () {
      super.email = value;
    });
  }

  final _$passwordAtom = Atom(name: '_AlunoBase.password');

  @override
  String get password {
    _$passwordAtom.reportRead();
    return super.password;
  }

  @override
  set password(String value) {
    _$passwordAtom.reportWrite(value, super.password, () {
      super.password = value;
    });
  }

  final _$_AlunoBaseActionController = ActionController(name: '_AlunoBase');

  @override
  dynamic setEmail(dynamic value) {
    final _$actionInfo =
        _$_AlunoBaseActionController.startAction(name: '_AlunoBase.setEmail');
    try {
      return super.setEmail(value);
    } finally {
      _$_AlunoBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setPassword(dynamic value) {
    final _$actionInfo = _$_AlunoBaseActionController.startAction(
        name: '_AlunoBase.setPassword');
    try {
      return super.setPassword(value);
    } finally {
      _$_AlunoBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
email: ${email},
password: ${password}
    ''';
  }
}
