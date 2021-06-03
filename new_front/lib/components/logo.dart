import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Logo extends StatelessWidget {
  const Logo({required this.imageSrc});

  final String imageSrc;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 1178 / 2,
          child: SvgPicture.asset(imageSrc),
        )
      ],
    );
  }
}
