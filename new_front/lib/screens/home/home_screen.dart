import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_storage/get_storage.dart';
import 'package:openet/components/background.dart';
import 'package:openet/screens/home/components/option_column.dart';
import 'package:openet/screens/home/components/person_card.dart';
import 'package:openet/screens/home/controller/home_controller.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = '/';

  @override
  Widget build(BuildContext context) {
    var storage = GetStorage('local');
    var user = storage.read('user');
    var controller = HomeController();
    return Scaffold(
      body: BackGround(
        child: Row(
          children: [
            Container(
              child: Container(
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
                child: Column(
                  children: [
                    PersonCard(
                      name: "${user['first_name']} ${user['last_name']}",
                      email: user['email'],
                      image: 'user.jpg',
                    ),
                    OptionColumn(
                      controller: controller,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                child: Observer(
                  builder: (_) {
                    return controller.content;
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
