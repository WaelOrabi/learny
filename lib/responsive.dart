import 'package:flutter/material.dart';
class ResponsiveUi extends StatelessWidget {
  final Widget mobile;
  final Widget? mobileLarge;
  final Widget? tablet;
  final Widget web;
   const ResponsiveUi({Key? key, required this.mobile, this.mobileLarge, this.tablet, required this.web}) : super(key: key);
   static bool isMobile(BuildContext context)=>
       MediaQuery.of(context).size.width<=500;
   static bool isMobilerLarge(BuildContext context)=>
       MediaQuery.of(context).size.width<=700;
   static bool isTablet(BuildContext context)=>
       MediaQuery.of(context).size.width<1024;
   static isWeb(BuildContext context)=>
       MediaQuery.of(context).size.width>=1024;
  @override
  Widget build(BuildContext context) {
    final Size _size=MediaQuery.of(context).size;
    if(_size.width>=1024){
      return web;
    }
    else if(_size.width>=700 && tablet!=null){
      return tablet!;
    }
    else if(_size.width>=450 && mobileLarge!=null){
      return mobileLarge!;
    }
    else {
      return mobile;
    }
    }

  }

