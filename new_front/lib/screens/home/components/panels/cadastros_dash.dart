import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:http/http.dart';
import 'package:openet/screens/home/components/data_row_info.dart';
import 'package:openet/screens/home/components/empty_table.dart';
import 'package:openet/screens/home/components/no_pending_users_found.dart';
import 'package:openet/screens/home/components/peding_user_table.dart';
import 'package:openet/screens/home/controller/home_controller.dart';
import 'package:openet/utils/requests.dart';

class CadastrosPendentesDashBoard extends StatelessWidget {
  const CadastrosPendentesDashBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = HomeController();

    bool isValidResponse(dynamic input) {
      try {
        return input['message'] == 'Nenhum cadastro pendente encontrado.';
      } catch (e) {}
      return false;
    }

    return Container(
      decoration: BoxDecoration(
        color: Color(0xfff0f0f5),
        borderRadius: BorderRadius.all(Radius.circular(30)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0.0, 1.0), //(x,y)
            blurRadius: 3.0,
          ),
        ],
      ),
      child: Center(
        child: Column(
          children: [
            SizedBox(height: 120),
            Container(
              height: 700,
              child: SingleChildScrollView(
                child: FutureBuilder(
                  future: listPendingUsers(),
                  builder:
                      (BuildContext context, AsyncSnapshot<Response> result) {
                    Widget component = emptyTable(controller);
                    if (result.hasData) {
                      var content = json.decode(result.data!.body);
                      if (isValidResponse(content)) {
                        component = NoPendingUsersFound();
                      } else {
                        content.forEach((i) => controller.rows.add(i));
                        component = DataTable(
                          dividerThickness: 1.5,
                          columns: [
                            DataColumn(label: Text('ID'), numeric: false),
                            DataColumn(
                                label: Text('Nome Completo'), numeric: false),
                            DataColumn(label: Text('E-mail'), numeric: false),
                            DataColumn(label: Text('Ação'), numeric: false)
                          ],
                          rows: controller.rows
                              .map((e) => DataRowInfo(controller,
                                  id: e['user_id'],
                                  email: e['email'],
                                  name: "${e['first_name']} ${e['last_name']}"))
                              .toList(),
                        );
                      }
                    } else if (result.hasError) {
                      component = NoPendingUsersFound();
                    }
                    // return Observer(builder: (_) {
                    // return component;
                    // });
                    return component;
                  },
                ),
              ),
            ),
            Container(
              child: Column(
                children: [
                  SizedBox(
                    height: 75,
                  ),
                  Text('Listagem de cadastros pententes por aprovação.')
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
