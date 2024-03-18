import 'dart:html' as html;
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DisplayVideoYoutube extends StatelessWidget {
  final String videoUrl;
   DisplayVideoYoutube({Key? key, required this.videoUrl}) : super(key: key);

  String viewID = "your-view-id";

  @override
  Widget build(BuildContext context) {
    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
      viewID,
          (int id) => html.IFrameElement()
        ..width = MediaQuery.of(context).size.width.toString()
        ..height = MediaQuery.of(context).size.height.toString()
        ..src = 'https://www.youtube.com/embed/IyFZznAk69U'
        ..style.border = 'none',
    );

    return SizedBox(
      height: 400.h,
      width: 700.w,
      child: HtmlElementView(
        viewType: viewID,
      ),
    );
  }}

