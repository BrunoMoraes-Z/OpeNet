import 'package:flutter/material.dart';

class OptionRow extends StatelessWidget {
  const OptionRow({
    required this.icon,
    required this.text,
    required this.press,
    Key? key,
  }) : super(key: key);

  final IconData icon;
  final String text;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    bool selected = false;
    return Padding(
      padding: EdgeInsets.only(
        right: 10,
        left: 20,
        bottom: 20,
      ),
      child: MouseRegion(
        onHover: (e) => selected = !selected,
        child: InkWell(
          onTap: press,
          child: Container(
            height: 60,
            padding: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: selected ? Colors.grey.shade300 : Color(0xfff0f0f5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0.0, 1.0), //(x,y)
                    blurRadius: 3.0,
                  ),
                ]),
            child: Row(
              children: [
                Icon(
                  icon,
                  size: 25,
                ),
                SizedBox(width: 30),
                Text(
                  text,
                  style: TextStyle(fontSize: 18),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
