import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:openet/screens/recover/components/recover_form.dart';
import 'package:openet/screens/registration/components/register_form.dart';
import 'package:openet/utils/size_config.dart';

class Body extends StatelessWidget {
  const Body({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
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
                    child: Column(
                      children: [
                        Spacer(),
                        Text(
                          'OpeNet',
                          style: TextStyle(
                            color: Color(0xff2a2a2a),
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 60,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 50),
                          child: SvgPicture.asset(
                            '${kIsWeb ? '' : 'assets'}/recover_password.svg',
                            width: (constraints.maxWidth / 2) - 100,
                          ),
                        ),
                        Spacer(
                          flex: 2,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: constraints.maxWidth / 2,
                    height: constraints.maxHeight,
                    child: Padding(
                      padding: EdgeInsets.only(left: 140, right: 140),
                      child: RecoverForm(),
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
