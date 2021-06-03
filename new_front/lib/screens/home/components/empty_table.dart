import 'package:flutter/material.dart';
import 'package:openet/screens/home/components/data_row_info.dart';
import 'package:openet/screens/home/controller/home_controller.dart';

DataTable emptyTable(HomeController controller) {
  return DataTable(
    dividerThickness: 1.5,
    columns: [
      DataColumn(label: Text('ID'), numeric: false),
      DataColumn(label: Text('Nome Completo'), numeric: false),
      DataColumn(label: Text('E-mail'), numeric: false),
      DataColumn(label: Text('Ação'), numeric: false)
    ],
    rows: [
      DataRowInfo(
        controller,
        id: '',
        name: '',
        email: '',
      ),
    ],
  );
}
