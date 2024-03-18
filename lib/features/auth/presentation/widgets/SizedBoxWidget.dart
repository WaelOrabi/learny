import 'package:flutter/material.dart';
class SizebBoxWidget extends StatelessWidget {
  const SizebBoxWidget({
    super.key,
    required this.screenHeight,
  });

  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: screenHeight * 0.02,
    );
  }
}
