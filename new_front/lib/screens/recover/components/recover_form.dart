import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:openet/components/input_form_text.dart';
import 'package:openet/screens/recover/controller/recover_controller.dart';

class RecoverForm extends StatelessWidget {
  const RecoverForm({required this.controller});

  final RecoverController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          InputTextField(
            hint: 'E-mail',
            icon: LineIcons.mailBulk,
            onChanged: (value) {},
          ),
          SizedBox(
            height: 2,
          )
        ],
      ),
    );
  }
}
