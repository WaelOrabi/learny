import 'dart:html';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:html' as html;
import 'dart:ui' as ui;
import '../../../../teachers/presentation/widgets/becom_a_teacher_widgets/pdf_viewer.dart';
import '../../bloc/posts/posts_bloc.dart';
class AddPdfPostScreen extends StatefulWidget {
  const AddPdfPostScreen({Key? key, required this.postPDFTitleController, required this.postPDFDescriptionController}) : super(key: key);
  final TextEditingController postPDFTitleController;
  final TextEditingController postPDFDescriptionController;

  @override
  State<AddPdfPostScreen> createState() => _AddPdfPostScreenState();
}

class _AddPdfPostScreenState extends State<AddPdfPostScreen> {
  String url1 = '';
  String base64 = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Post PDF: ",
          style: TextStyle(
              color: Colors.black,
              fontSize: 25.sp,
              fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 10.h,
        ),
        Container(
          width: 400.w,
          child: TextFormField(
            maxLines: null,
            controller: widget.postPDFTitleController,
            style: TextStyle(
                fontSize: 25.sp,
                fontWeight: FontWeight.normal,
                color: Colors.black87),
            onSaved: (value) {
              widget.postPDFTitleController.text = value!;
            },
            decoration: const InputDecoration(
              hintText: 'Write title about your PDF.',
              // Enabled Border
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
              // Focused Border
              focusedBorder: UnderlineInputBorder(
                borderSide:
                BorderSide(color: Colors.blue, width: 2),
              ),
            ),
          ),
        ),
        Container(
          width: 800.w,
          child: TextFormField(
            maxLines: null,
            controller: widget.postPDFDescriptionController,
            style: TextStyle(
                fontSize: 25.sp,
                fontWeight: FontWeight.normal,
                color: Colors.black87),
            onSaved: (value) {
              widget.postPDFDescriptionController.text = value!;
            },
            decoration: const InputDecoration(
              hintText: 'Write description about your PDF.',
              // Enabled Border
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
              // Focused Border
              focusedBorder: UnderlineInputBorder(
                borderSide:
                BorderSide(color: Colors.blue, width: 2),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 30.h,
        ),

        Stack(
          children: [
            DottedBorder(
              strokeWidth: 2,
              color: Colors.black87,
              dashPattern: [6, 3, 2, 1],
              child: Container(
                  width: 450.w,
                  height: 350.h,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: InkWell(
                    onTap: () async {
                      _pickPdfFromGallery();
                    },
                    child: url1.isEmpty
                        ? const Icon(
                      Icons
                          .add_photo_alternate_outlined,
                      size: 50,
                    )
                        : PdfViewer(
                      url: url1,
                      width: 400.w,
                      height: 300.h,
                    ),
                  )),
            ),
            Positioned(
                top: 5,
                right: 5,
                child: IconButton(
                    onPressed: () async {
                      _pickPdfFromGallery();
                    },
                    icon: Icon(Icons.edit))),
          ],
        ),


      ],
    );
  }
  Future<html.File?> _pickPdfFromGallery() async {
    if (kIsWeb) {
      final pdfFile = await pickPdfFromGallery();
      if (pdfFile != null) {
        final url = html.Url.createObjectUrl(pdfFile);
        final reader = html.FileReader();
        reader.readAsDataUrl(pdfFile);
        await reader.onLoad.first;
        base64 = reader.result as String;
        String b = base64.replaceFirst("application/pdf", "image/pdf");
        BlocProvider.of<PostsBloc>(context)
            .pdfBase64 = b;

        // ignore: undefined_prefixed_name
        ui.platformViewRegistry.registerViewFactory(
          url,
              (int viewId) => IFrameElement()
            ..src = url
            ..style.border = 'none'
            ..height = '100%'
            ..width = '100%',
        );
        setState(() {
          url1 = url;
          base64 = reader.result as String;
        });
      }
    }
  }
}


