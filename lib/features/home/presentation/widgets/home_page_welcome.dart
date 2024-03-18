import 'dart:async';
import 'package:flutter/material.dart';
import 'package:learny_project/features/home/presentation/widgets/smoth_widget.dart';
import 'home_page_view.dart';



class HomePageWelcome extends StatefulWidget {
  const HomePageWelcome({Key? key}) : super(key: key);

  @override
  State<HomePageWelcome> createState() => _HomePageWelcomeState();
}

class _HomePageWelcomeState extends State<HomePageWelcome> {
  final PageController _controller = PageController(initialPage: 0);
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();

    Timer.periodic(
      const Duration(seconds: 2),
          (timer) {
        if (_currentIndex < 3) {
          _controller.nextPage(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut);
          _currentIndex++;
        } else {
          _controller.animateToPage(0,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut);
          _currentIndex = 0;
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PageView(
          physics: const BouncingScrollPhysics(),
          controller: _controller,
          onPageChanged: (index) {
            setState(
                  () {
                _currentIndex = index;
              },
            );
          },
          children:  [
            HomePageView(
              image: 'assets/images/posts.png',
              ),

            HomePageView(
              image: 'assets/images/posts.png',
              ),

            HomePageView(
              image: 'assets/images/posts.png',
            ),
          ],
        ),
        HomeSmoothPageIndicator(controller: _controller),
      ],
    );
  }
}