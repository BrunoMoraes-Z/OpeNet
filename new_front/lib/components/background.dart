import 'package:flutter/material.dart';

class BackGround extends StatelessWidget {
  const BackGround({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Color(0xfff0f0f5),
          ),
        ),
        Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 1278),
            child: child,
          ),
        ),
      ],
    );
    ;
  }
}
