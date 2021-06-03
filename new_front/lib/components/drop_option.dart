import 'package:flutter/material.dart';

class DropOption extends StatelessWidget {
  const DropOption({
    required this.initialValue,
    required this.icon,
    required this.itens,
  });

  final String initialValue;
  final IconData icon;
  final List<DropdownMenuItem<String>> itens;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      value: initialValue,
      // onChanged: (value) {
      //   value.value = value.trim();
      // },
      // onSaved: (value) {
      //   value.value = value.trim();
      // },
      items: itens,
      icon: icon == null ? null : Icon(icon),
    );
  }
}
