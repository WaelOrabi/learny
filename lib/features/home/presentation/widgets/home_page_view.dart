import 'package:flutter/material.dart';

class HomePageView extends StatelessWidget {
  const HomePageView({
    super.key,

    required this.image,
  });


  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(image),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}