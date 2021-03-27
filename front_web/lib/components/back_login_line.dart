import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:openet/screens/login/login_screen.dart';

class BackLoginLine extends StatelessWidget {
  const BackLoginLine({
    Key key,
  }) : super(key: key);

  void returnToHome(BuildContext context) {
    var storage = GetStorage('local');
    if (storage.hasData('gcomplete')) {
      storage.remove('gcomplete');
      storage.write('cancel_g', true);
    }
    Navigator.pushNamed(context, LoginScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        IconButton(
          icon: Icon(Icons.keyboard_arrow_left),
          onPressed: () {
            returnToHome(context);
          },
        ),
        GestureDetector(
          onTap: () {
            returnToHome(context);
          },
          child: Text(
            'Voltar para Login',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}
