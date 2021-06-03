import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:openet/components/background.dart';
import 'package:openet/screens/home/components/option_column.dart';
import 'package:openet/screens/home/components/person_card.dart';
import 'package:openet/screens/home/controller/home_controller.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = '/';

  @override
  Widget build(BuildContext context) {
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
                      name: 'Bruno Moraes',
                      email: 'moraes.7bruno@gmail.com',
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
