import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyElevatedButton extends StatelessWidget {
  final BorderRadiusGeometry? borderRadius;
  final double? width;
  final double height;
  final List<Color> color;
  final bool signUpWithGoogle;
  final VoidCallback? onPressed;
  final Widget child;

   MyElevatedButton({

    Key? key,
    required this.onPressed,
    required this.child,
    this.borderRadius,
    this.width=600,
    this.height = 50,
    this.color =const [Color(0xff16d9e3), Color(0xff30c7ec), Color(0xff46aef7)],  this.signUpWithGoogle=false ,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final borderRadius = this.borderRadius ?? BorderRadius.circular(10).w;
    return InkWell(
      hoverColor: Colors.transparent,
      focusColor: Colors.transparent,

      onTap: onPressed,
      child: Container(

        alignment: Alignment.center,
        width: width,
        height: height,
        decoration: BoxDecoration(
          gradient:  LinearGradient(
              colors: color),
          borderRadius: borderRadius,
          border:Border.all(
            color: const Color(0xffaec6cf),
            width: 1.w,
            style: BorderStyle.solid,
          ),
        ),
        child: child,
      ),
    );
  }
}
