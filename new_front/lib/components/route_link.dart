import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class RouteLink extends StatelessWidget {
  const RouteLink({required this.route, required this.text});

  final String route, text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, route);
      },
      child: Container(
        child: Row(
          children: [
            Icon(LineIcons.angleLeft),
            SizedBox(width: 5),
            Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.w900,
              ),
            )
          ],
        ),
      ),
    );
  }
}
