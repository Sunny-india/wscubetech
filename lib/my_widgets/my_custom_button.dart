import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  const MyButton(
      {super.key,
      required this.onTapping,
      required this.buttonWidth,
      required this.buttonHeight,
      required this.buttonWidget});
  //final Function? onTapping;
  final void Function()? onTapping;
  final double buttonHeight;
  final double buttonWidth;
  final Widget buttonWidget;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTapping,
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.grey.shade300,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.shade500,
                    offset: const Offset(-2, -2),
                    blurRadius: 3,
                    spreadRadius: 1),
                BoxShadow(
                  color: Colors.grey.shade400,
                  offset: Offset(4, 4),
                  blurRadius: 3,
                  spreadRadius: 1,
                ),
              ]),
          height: buttonHeight,
          width: buttonWidth,
          child: FittedBox(
            child: buttonWidget,
          ),
        ));
  }
}
