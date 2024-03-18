import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter/material.dart';

class HomeSmoothPageIndicator extends StatelessWidget {
  const HomeSmoothPageIndicator({
    super.key,
    required PageController controller,
  }) : _controller = controller;

  final PageController _controller;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: SmoothPageIndicator(
          controller: _controller,
          count: 3,
          effect: WormEffect(
            activeDotColor: Colors.white,
            dotColor: Colors.grey.shade300,
            dotWidth: 8,
            dotHeight: 8,
          ),
        ),
      ),
    );
  }
}