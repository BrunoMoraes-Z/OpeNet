import 'package:flutter/material.dart';
import 'package:openet/screens/home/components/content_area.dart';
import 'package:openet/screens/home/components/content_menu.dart';
import 'package:openet/screens/home/components/page_header.dart';

class Body extends StatelessWidget {
  const Body({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [
              Color(0xff28a745),
              Color(0xff20c997),
            ],
          ),
        ),
        child: Column(
          children: [
            PageHeader(),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BuildContentMenu(),
                SizedBox(width: 16),
                BuildContentArea(),
              ],
            )
          ],
        ),
      ),
    );
  }
}
