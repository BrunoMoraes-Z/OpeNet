import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:openet/screens/home/components/panels/cadastros_dash.dart';
import 'package:openet/screens/home/components/panels/home_dash.dart';
import 'package:openet/screens/home/controller/home_controller.dart';
import 'package:openet/utils/requests.dart';

DataRow DataRowInfo(HomeController controller, {id, name, email}) {
  return DataRow(
    cells: [
      DataCell(Text(id, maxLines: 1)),
      DataCell(Text(name, maxLines: 2)),
      DataCell(Text(email, maxLines: 2)),
      DataCell(Row(children: [
        if (id == '') Container(),
        if (id != '')
          IconButton(
              onPressed: () {
                acceptUser(id: id);
                var obj = controller.rows.firstWhere((element) {
                  return element['user_id'] == id;
                });
                controller.rows.remove(obj);
              },
              icon: Icon(LineIcons.check)),
        if (id != '')
          IconButton(
              onPressed: () {
                declineUser(id: id);
                var obj = controller.rows.firstWhere((element) {
                  return element['user_id'] == id;
                });
                controller.rows.remove(obj);
              },
              icon: Icon(LineIcons.times))
      ]))
    ],
  );
}
