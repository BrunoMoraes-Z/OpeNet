import 'package:flutter/material.dart';
import 'package:openet/screens/login/web/body.dart';

class LoginScreen extends StatelessWidget {
  static String routeName = '/login';
  const LoginScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BodyWeb(),
    );
  }
}
