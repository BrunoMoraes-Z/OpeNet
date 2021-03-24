import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:openet/screens/home/components/body.dart';
import 'package:openet/utils/size_config.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = '/home';

  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Body();
  }
}
