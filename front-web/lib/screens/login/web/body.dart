import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:openet/screens/login/web/components/login_form.dart';
import 'package:openet/utils/size_config.dart';

class BodyWeb extends StatelessWidget {
  const BodyWeb({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: SizeConfig.screenWidth,
        color: Color(0xfff0f0f5),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Row(
              children: [
                Container(
                  width: constraints.maxWidth / 2,
                  height: constraints.maxHeight,
                  child: Padding(
                    padding: EdgeInsets.only(left: 140, right: 140),
                    child: LoginForm(),
                  ),
                ),
                Container(
                  width: constraints.maxWidth / 2,
                  height: constraints.maxHeight,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 50),
                        child: SvgPicture.asset(
                          '/logo_web.svg',
                          width: (constraints.maxWidth / 2) - 100,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
