import 'package:flutter/material.dart';

class SquareContainerForLogo extends StatelessWidget {
  const SquareContainerForLogo(
      {super.key,
      required this.myHeight,
      required this.myWidth,
      required this.imagePath,
      this.onTapping});
  final String imagePath;
  final double myHeight;
  final double myWidth;
  final void Function()? onTapping;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapping,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white),
            image: DecorationImage(
                image: AssetImage(
                  imagePath,
                ),
                fit: BoxFit.contain)),
        height: myHeight,
        width: myWidth,
        // child: Image.asset(imagePath),
      ),
    );
  }
}
