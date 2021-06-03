import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class NoPendingUsersFound extends StatelessWidget {
  const NoPendingUsersFound({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 450,
          width: 450,
          child: SvgPicture.asset('no_data.svg'),
        ),
        SizedBox(height: 60),
        Text(
          'Nenhum cadastro pendente encontrado.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: GoogleFonts.montserrat().fontFamily,
            fontSize: 50,
          ),
        )
      ],
    );
  }
}
