import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:http/http.dart';
import 'package:openet/screens/home/components/data_row_info.dart';
import 'package:openet/screens/home/components/empty_table.dart';
import 'package:openet/screens/home/components/no_pending_users_found.dart';
import 'package:openet/screens/home/controller/home_controller.dart';
import 'package:openet/utils/requests.dart';

class PendingUserTable extends StatelessWidget {
  const PendingUserTable({Key? key, required this.controller})
      : super(key: key);

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    bool isValidResponse(dynamic input) {
      try {
        return input['message'] == 'Nenhum cadastro pendente encontrado.';
      } catch (e) {}
      return false;
    }

    return Observer(builder: (_) {
      return FutureBuilder(
        future: listPendingUsers(),
        builder: (BuildContext context, AsyncSnapshot<Response> result) {
          if (result.hasData) {
            var content = json.decode(result.data!.body);
            if (isValidResponse(content)) {
              return NoPendingUsersFound();
            } else {
              content.forEach((i) => controller.rows.add(i));
              return DataTable(
                dividerThickness: 1.5,
                columns: [
                  DataColumn(label: Text('ID'), numeric: false),
                  DataColumn(label: Text('Nome Completo'), numeric: false),
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
            return NoPendingUsersFound();
          }
          return emptyTable(controller);
        },
      );
    });
  }
}
