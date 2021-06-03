import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';
import 'package:openet/screens/home/components/panels/cadastros_dash.dart';
import 'package:openet/screens/home/components/panels/home_dash.dart';
part 'home_controller.g.dart';

class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  @observable
  Widget content = HomeDashBoard();

  @observable
  ObservableList<dynamic> rows = ObservableList();
}
