import 'package:flutter/material.dart';

class MyBox extends StatelessWidget {
  const MyBox({super.key, this.mHeight, this.mWidth});
  final double? mHeight;
  final double? mWidth;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: mHeight,
      width: mWidth,
    );
  }
}
