import 'package:flutter/material.dart';

class SquareContainerForLogo extends StatelessWidget {
  const SquareContainerForLogo(
      {super.key,
      required this.myHeight,
      required this.myWidth,
      required this.imagePath,
      required this.containerColor,
      this.onTapping});
  final String imagePath;
  final double myHeight;
  final double myWidth;
  final Color containerColor;
  final void Function()? onTapping;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapping,
      child: Container(
        padding: const EdgeInsets.all(4),
        height: myHeight,
        width: myWidth,
        decoration: BoxDecoration(
          color: containerColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.shade300,
                offset: const Offset(4, 4),
                blurRadius: 10,
                spreadRadius: 1),
            const BoxShadow(
                color: Colors.white,
                offset: Offset(-4, -4),
                blurRadius: 10,
                spreadRadius: 1)
          ],
          border: Border.all(color: Colors.grey.shade300),
          // image: DecorationImage(
          //     image: AssetImage(
          //       imagePath,
          //     ),
          //     fit: BoxFit.contain),
        ),
        child: Image.asset(imagePath),
      ),
    );
  }
}
