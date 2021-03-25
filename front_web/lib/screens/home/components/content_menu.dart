import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:openet/utils/size_config.dart';

class BuildContentMenu extends StatelessWidget {
  const BuildContentMenu({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var st = GetStorage('local');
    var user = st.read('user');

    String createdUserDate() {
      var dt = user['created_at'];
      var pt = dt.toString().split("T")[0];
      return '${pt.split('-')[2]}/${pt.split('-')[1]}/${pt.split('-')[0]}';
    }

    return Container(
      height: SizeConfig.screenHeight - 150,
      width: SizeConfig.getProportionateScreenWidth(25) - 35,
      // color: Colors.redAccent,
      child: Column(
        children: [
          Container(
            width: SizeConfig.getProportionateScreenWidth(25),
            height: 180,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Color(0xfff0f0f0).withOpacity(1),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.4),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3),
                )
              ],
            ),
            child: Padding(
              padding: EdgeInsets.only(
                top: 12,
                bottom: 12,
              ),
              child: Column(
                children: [
                  Text(
                    'Nome',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text('${user['first_name']} ${user['last_name']}'),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'E-Mail',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(user['email']),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Data de Cadastro',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(createdUserDate()),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
