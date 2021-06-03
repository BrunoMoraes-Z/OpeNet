import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:line_icons/line_icons.dart';

class InputTextField extends StatefulWidget {
  const InputTextField({
    required this.hint,
    required this.icon,
    required this.onChanged,
    this.content = '',
    this.formatters,
    this.inputAction = TextInputAction.done,
    this.obscure = false,
  });

  final String hint;
  final Function(String) onChanged;
  final IconData icon;
  final bool obscure;
  final TextInputAction inputAction;
  final String? content;
  final List<TextInputFormatter>? formatters;

  @override
  _InputTextFieldState createState() => _InputTextFieldState();
}

class _InputTextFieldState extends State<InputTextField> {
  bool hidden = true;
  IconButton _btnHide() {
    return IconButton(
      icon: Icon(hidden ? LineIcons.eye : LineIcons.eyeSlash),
      onPressed: () {
        setState(() {
          hidden = !hidden;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: widget.onChanged,
      textInputAction: widget.inputAction,
      inputFormatters: widget.formatters,
      controller: TextEditingController(text: widget.content ?? ''),
      enabled: widget.content!.length == 0 ? true : false,
      decoration: InputDecoration(
        hintText: widget.hint,
        icon: Icon(widget.icon),
        errorText: null,
        suffixIcon: widget.obscure ? _btnHide() : null,
      ),
      obscureText: widget.obscure ? hidden : false,
    );
  }
}
