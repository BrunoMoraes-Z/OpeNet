// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeController on _HomeControllerBase, Store {
  final _$contentAtom = Atom(name: '_HomeControllerBase.content');

  @override
  Widget get content {
    _$contentAtom.reportRead();
    return super.content;
  }

  @override
  set content(Widget value) {
    _$contentAtom.reportWrite(value, super.content, () {
      super.content = value;
    });
  }

  final _$rowsAtom = Atom(name: '_HomeControllerBase.rows');

  @override
  ObservableList<dynamic> get rows {
    _$rowsAtom.reportRead();
    return super.rows;
  }

  @override
  set rows(ObservableList<dynamic> value) {
    _$rowsAtom.reportWrite(value, super.rows, () {
      super.rows = value;
    });
  }

  @override
  String toString() {
    return '''
content: ${content},
rows: ${rows}
    ''';
  }
}
