import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:flutter_screenutil/flutter_screenutil.dart';
class PdfViewer extends StatefulWidget {
  final String url;
  final double width;
  final double height;
  const PdfViewer({Key? key, required this.url, required this.width, required this.height}) : super(key: key);

  @override
  _PdfViewerState createState() => _PdfViewerState();
}

class _PdfViewerState extends State<PdfViewer> {
  final html.IFrameElement _iframeElement = html.IFrameElement();

  @override
  void initState() {
    super.initState();
    _iframeElement.src = widget.url;
    _iframeElement.style.border = 'none';
    _iframeElement.height = '${widget.height}px';
    _iframeElement.width = '${widget.width}px';

    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
      widget.url,
          (int viewId) => _iframeElement,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400.w,
      height: 300.h,
      child: HtmlElementView(
        viewType: widget.url,
      ),
    );
  }
}

Future<html.File?> pickPdfFromGallery() async {
  final input = html.FileUploadInputElement()..accept = 'application/pdf';
  input.click();
  await input.onChange.first;
  return input.files?.first;
}