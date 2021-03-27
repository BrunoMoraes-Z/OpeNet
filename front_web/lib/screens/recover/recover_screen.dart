import 'package:flutter/material.dart';
import 'package:openet/screens/recover/components/body.dart';

class RecoverScreen extends StatelessWidget {
  static String routeName = '/recover';

  const RecoverScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}
