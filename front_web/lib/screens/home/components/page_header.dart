import 'package:flutter/material.dart';
import 'package:openet/components/logout_icon_button.dart';
import 'package:openet/utils/size_config.dart';

class PageHeader extends StatelessWidget {
  const PageHeader({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 30,
        left: 30,
        right: 30,
      ),
      child: Container(
        width: SizeConfig.screenWidth - 60,
        height: 80,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Color(0xfff0f0f0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3),
            )
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Spacer(),
              Text(
                'OpeNet',
                style: TextStyle(
                  color: Color(0xff2a2a2a),
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
              Spacer(
                flex: 12,
              ),
              LogoutIcon(),
            ],
          ),
        ),
      ),
    );
  }
}
