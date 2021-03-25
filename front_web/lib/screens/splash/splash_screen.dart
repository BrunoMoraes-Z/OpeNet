import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:openet/utils/size_config.dart';

class SplashScreen extends StatelessWidget {
  static String routeName = '/splash';

  const SplashScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Color(0xff28a745),
                    Color(0xff20c997),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: SizeConfig.getProportionateScreenWidth(60),
                right: SizeConfig.getProportionateScreenWidth(60),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(0),
                    child: SvgPicture.asset('assets/logo_mobile.svg'),
                  ),
                  Text(
                    'OpeNet',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Roboto',
                    ),
                  ),
                  Spacer(
                    flex: 2,
                  ),
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                        color: Color(0xff2a2a2a),
                        borderRadius: BorderRadius.all(
                          Radius.circular(50),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.30),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          )
                        ]),
                    child: IconButton(
                      color: Color(0xfff0f0f5),
                      icon: Icon(Icons.arrow_forward_outlined),
                      iconSize: 30,
                      onPressed: () => print('Click'),
                    ),
                  ),
                  Spacer(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
