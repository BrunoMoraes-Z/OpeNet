import 'package:flutter/material.dart';
import 'package:openet/utils/size_config.dart';

class BuildContentArea extends StatelessWidget {
  const BuildContentArea({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.screenHeight - 150,
      width: SizeConfig.getProportionateScreenWidth(75) - 35,
      child: Column(),
    );
  }
}
